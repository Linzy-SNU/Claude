#!/bin/bash
# Claude Code git 자동 동기화 훅
#   pull  — 세션 시작 시 원격 변경사항 가져오기 (SessionStart)
#   sync  — 작업 종료 시 자동 커밋 + 푸시 (Stop)
#
# 어느 git 저장소에서든 동작한다. 안전하지 않은 상황에서는 조용히 건너뛴다.
#
# 주의: .claude/settings.json의 Stop 훅에 "async": true 를 넣지 말 것.
#   백그라운드로 돌리면 세션이 끝나면서 훅이 실행되기 전에 죽는다.
#   (2026-08-17 실제 확인 — async였을 때 커밋·푸시가 아예 실행되지 않았음)
#   지연이 걱정되면 훅을 async로 만들지 말고, 아래 푸시처럼 스크립트 안에서
#   개별 작업을 setsid로 떼어내라. 커밋은 반드시 동기로 남겨둘 것.

MODE="${1:-sync}"
LOG="$HOME/Library/Logs/claude-git-hook.log"
mkdir -p "$(dirname "$LOG")"

log() { printf '[%s] [%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$MODE" "$1" >>"$LOG"; }
skip() { log "skip: $1"; exit 0; }

# stdin의 훅 JSON에서 cwd를 읽어 이동 (없으면 현재 디렉터리 유지)
payload=$(cat 2>/dev/null)
target=$(printf '%s' "$payload" | jq -r '.cwd // empty' 2>/dev/null)
[ -z "$target" ] && target="${CLAUDE_PROJECT_DIR:-$PWD}"
cd "$target" 2>/dev/null || skip "cd 실패: $target"

git rev-parse --is-inside-work-tree >/dev/null 2>&1 || skip "git 저장소 아님: $target"
cd "$(git rev-parse --show-toplevel)" || skip "toplevel 이동 실패"
repo=$(basename "$PWD")

# 동시 실행 방지 — Stop 훅은 백그라운드(async)로 매 턴 끝에 돌기 때문에
# 턴이 빠르게 이어지면 git 작업이 겹칠 수 있다.
# 10초 안에 같은 저장소·모드가 이미 돌았으면 건너뛴다.
stamp="${TMPDIR:-/tmp}/claude-git-hook.$(printf '%s' "$PWD" | cksum | cut -d' ' -f1).$MODE"
now=$(date +%s)
if [ -f "$stamp" ] && [ $((now - $(cat "$stamp" 2>/dev/null || echo 0))) -lt 10 ]; then
  exit 0
fi
printf '%s' "$now" >"$stamp"

# --- 안전 가드 -------------------------------------------------------------
branch=$(git symbolic-ref --quiet --short HEAD 2>/dev/null) \
  || skip "detached HEAD (워크트리 등) — 손대지 않음"

gitdir=$(git rev-parse --git-dir)
for state in MERGE_HEAD REBASE_HEAD CHERRY_PICK_HEAD BISECT_LOG rebase-merge rebase-apply; do
  [ -e "$gitdir/$state" ] && skip "진행 중인 git 작업($state) 있음"
done

git remote get-url origin >/dev/null 2>&1 || skip "origin 원격 없음"

# --- pull: 세션 시작 -------------------------------------------------------
if [ "$MODE" = "pull" ]; then
  git rev-parse --abbrev-ref '@{u}' >/dev/null 2>&1 || skip "업스트림 없음 ($branch)"
  before=$(git rev-parse HEAD)
  if git pull --ff-only >>"$LOG" 2>&1; then
    after=$(git rev-parse HEAD)
    if [ "$before" != "$after" ]; then
      n=$(git rev-list --count "$before..$after")
      log "pull 완료: $n개 커밋"
      printf '{"systemMessage":"%s: git pull 완료 — 새 커밋 %s개 (%s)"}\n' "$repo" "$n" "$branch"
    else
      log "이미 최신"
    fi
  else
    log "pull 실패 (분기했거나 네트워크 문제) — 수동 확인 필요"
    printf '{"systemMessage":"%s: git pull 실패 — 로컬이 원격과 분기했을 수 있음. 직접 확인하세요."}\n' "$repo"
  fi
  exit 0
fi

# --- sync: 작업 종료 시 커밋 + 푸시 ----------------------------------------
changes=$(git status --porcelain)

if [ -n "$changes" ]; then
  # 자격증명처럼 보이는 파일이 섞이면 커밋하지 않고 사용자에게 알림
  secrets=$(printf '%s\n' "$changes" | awk '{ $1=""; sub(/^ /,""); print }' \
    | grep -Ei '(^|/)\.env($|\.)|(^|/)(id_rsa|id_ed25519)|\.(pem|key|p12|pfx|keystore)$|credential|secret|\.npmrc$|\.pypirc$' \
    | head -5)
  if [ -n "$secrets" ]; then
    log "자격증명 의심 파일 발견 — 자동 커밋 중단: $(printf '%s' "$secrets" | tr '\n' ' ')"
    printf '{"systemMessage":"%s: 자동 커밋을 건너뛰었습니다 — 민감해 보이는 파일이 있습니다: %s"}\n' \
      "$repo" "$(printf '%s' "$secrets" | tr '\n' ' ')"
    exit 0
  fi

  git add -A
  git diff --cached --quiet && skip "스테이징된 변경 없음 (.gitignore 처리됨)"
  summary=$(git diff --cached --name-only | head -3 | xargs -n1 basename 2>/dev/null | paste -sd', ' -)
  count=$(git diff --cached --name-only | wc -l | tr -d ' ')
  [ "$count" -gt 3 ] && summary="$summary 외 $((count - 3))개"
  git commit -q -m "자동 저장: $summary

Claude Code 세션 종료 시 자동 커밋 ($(date '+%Y-%m-%d %H:%M'))" >>"$LOG" 2>&1 \
    && log "커밋 완료: $summary"
fi

# 푸시: 업스트림이 있고 보낼 커밋이 있을 때만.
# 네트워크 왕복(~0.5초)이 턴 종료를 붙잡지 않도록 완전히 분리된 세션으로 띄운다.
# 훅의 "async": true 와는 다르다 — 그건 세션이 끝나면서 죽지만(2026-08-17 확인),
# 이건 setsid로 부모에서 떨어져 나가므로 세션이 끝나도 끝까지 실행된다.
# 혹시 푸시를 놓쳐도 커밋은 남아 있고, 다음 세션의 pull/sync가 자동으로 밀어준다.
if git rev-parse --abbrev-ref '@{u}' >/dev/null 2>&1; then
  ahead=$(git rev-list --count '@{u}..HEAD' 2>/dev/null || echo 0)
  if [ "$ahead" -gt 0 ]; then
    python3 -c 'import subprocess,sys
log = open(sys.argv[2], "a")
subprocess.Popen(["git", "push"], cwd=sys.argv[1],
                 stdout=log, stderr=subprocess.STDOUT,
                 start_new_session=True)' "$PWD" "$LOG" 2>>"$LOG" \
      && log "푸시 시작(백그라운드): $ahead개 커밋 → $branch" \
      || { log "백그라운드 띄우기 실패 — 동기 푸시로 대체"; git push >>"$LOG" 2>&1; }
  else
    log "푸시할 커밋 없음"
  fi
else
  log "업스트림 없음 ($branch) — 푸시 건너뜀"
fi

exit 0
