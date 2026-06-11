#!/bin/zsh
# 자동 동기화 설치 스크립트 (맥북에서 한 번만 실행)
# 사용법: 터미널에서 아래 명령 실행
#   zsh /Users/linzy/Claude/scripts/install-autosync.sh

set -e

WORKSPACE="/Users/linzy/Claude"
PLIST_SRC="$WORKSPACE/scripts/com.linzy.claude-autosync.plist"
PLIST_DST="$HOME/Library/LaunchAgents/com.linzy.claude-autosync.plist"

chmod +x "$WORKSPACE/scripts/auto-sync.sh"

mkdir -p "$HOME/Library/LaunchAgents"
cp "$PLIST_SRC" "$PLIST_DST"

# 기존에 등록되어 있으면 해제 후 다시 등록
launchctl bootout "gui/$(id -u)" "$PLIST_DST" 2>/dev/null || true
launchctl bootstrap "gui/$(id -u)" "$PLIST_DST"

echo "✅ 설치 완료! 이제 5분마다 자동으로 GitHub에 동기화됩니다."
echo "   로그 확인: ~/Library/Logs/claude-autosync.log"
echo "   중지하려면: launchctl bootout gui/$(id -u) $PLIST_DST"
