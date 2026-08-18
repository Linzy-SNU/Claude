#!/bin/bash
# 세션 시작 시 현재 상태를 Claude 컨텍스트에 주입한다.
#
# SessionStart 훅의 stdout은 컨텍스트에 그대로 들어간다 (공식 문서 확인, 2026-08-18).
# "AGENTS.md에 읽으라고 써두는" 방식은 AI가 지시를 따라야만 작동하지만,
# 이 방식은 판단을 거치지 않고 무조건 눈앞에 놓인다.
#
# 출력 형식: hookSpecificOutput.additionalContext (JSON)
# git-auto-sync.sh와 별도로 등록해 서로 간섭하지 않게 한다.

set -uo pipefail

payload=$(cat 2>/dev/null)
target=$(printf '%s' "$payload" | jq -r '.cwd // empty' 2>/dev/null)
[ -z "$target" ] && target="${CLAUDE_PROJECT_DIR:-$PWD}"
cd "$target" 2>/dev/null || exit 0

root=$(git rev-parse --show-toplevel 2>/dev/null) || exit 0
cd "$root" || exit 0

STATE="docs/context/현재작업.md"
[ -f "$STATE" ] || exit 0

# 컨텍스트 낭비를 막는 상한. 파일이 비대해지면 잘라내고 경고한다.
MAX_LINES=60
lines=$(wc -l < "$STATE" | tr -d ' ')

{
  printf '## 작업 공간 현재 상태\n\n'
  printf '_다음은 `%s`의 내용이다. 세션 시작 시 자동 주입됨._\n\n' "$STATE"
  head -n "$MAX_LINES" "$STATE"
  if [ "$lines" -gt "$MAX_LINES" ]; then
    printf '\n⚠️ 이 파일이 %s줄로 너무 길다 (상한 %s줄). 끝난 항목을 정리할 것.\n' "$lines" "$MAX_LINES"
  fi

  printf '\n### 최근 커밋\n\n'
  git log --oneline -8 2>/dev/null | sed 's/^/- /'

  # 커밋 안 된 변경이 있으면 알린다 (이전 세션이 중단됐을 수 있음)
  dirty=$(git status --porcelain 2>/dev/null | head -5)
  if [ -n "$dirty" ]; then
    printf '\n### ⚠️ 커밋되지 않은 변경\n\n'
    printf '%s\n' "$dirty" | sed 's/^/- /'
    printf '\n이전 세션이 중단됐을 수 있다. 내용을 확인하고 이어서 진행할 것.\n'
  fi
} | jq -Rs '{
  hookSpecificOutput: {
    hookEventName: "SessionStart",
    additionalContext: .
  }
}'
