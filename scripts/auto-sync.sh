#!/bin/zsh
# Claude 작업 공간 자동 동기화 스크립트
# 맥북의 /Users/linzy/Claude/ 변경사항을 자동으로 GitHub에 커밋·푸시합니다.
# launchd가 5분마다 실행합니다 (install-autosync.sh 참고).

WORKSPACE="/Users/linzy/Claude"
LOG="$HOME/Library/Logs/claude-autosync.log"
LOCKDIR="/tmp/claude-autosync.lock"

# 중복 실행 방지
if ! mkdir "$LOCKDIR" 2>/dev/null; then
  exit 0
fi
trap 'rmdir "$LOCKDIR"' EXIT

cd "$WORKSPACE" || exit 1

timestamp() { date "+%Y-%m-%d %H:%M:%S"; }

# 1. 로컬 변경사항이 있으면 커밋
if [[ -n "$(git status --porcelain)" ]]; then
  git add -A
  git commit -m "자동 동기화: $(timestamp)" >> "$LOG" 2>&1
fi

# 2. 원격 변경사항 가져오기 (네트워크 없으면 조용히 종료)
git pull --rebase origin main >> "$LOG" 2>&1 || exit 0

# 3. 푸시할 커밋이 있으면 푸시
if [[ -n "$(git log origin/main..HEAD --oneline 2>/dev/null)" ]]; then
  git push origin main >> "$LOG" 2>&1
  echo "[$(timestamp)] 푸시 완료" >> "$LOG"
fi
