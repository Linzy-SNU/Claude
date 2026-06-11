# 핸드오프 (Handoff)

## 진행 상황

### ✅ GitHub 연동 완료 (2026-05-05)

- 로컬 `/Users/linzy/Claude/` ↔ GitHub `linzy-SNU/Claude` 동기화 완료
- .gitignore로 민감한 파일 제외 (credentials, .claude.json 등)
- 자동 git commit & push 설정 (`feedback_autogit.md`)

### ✅ 휴대폰·아이패드 실시간 연동 (2026-06-11)

- launchd 자동 동기화 추가: 맥북에서 5분마다 자동 커밋·푸시 (`scripts/auto-sync.sh`)
- 설치 방법 및 사용법: `기기연동_가이드.md` 참고
- **맥북에서 1회 설치 필요**: `zsh scripts/install-autosync.sh`

### ✅ 수업정리 스킬 추가 (2026-06-11)

- 다글로 녹취록 붙여넣기 → 학습 노트로 정리 → 노션 과목별 "강의노트" DB에 저장
- 스킬 위치: `projects/02.SNU/skills/lecture-notes/SKILL.md`
- 노션 구조: `1-1 SNU` → `강의` DB → 과목 페이지 → `강의노트` DB (이름/날짜)

### 🔄 새로운 설정 / 메모리

- **자동 git commit & push** (`feedback_autogit.md`)
- **자율 실행** (`feedback_autonomy.md`)
- **한국어 응답** (`feedback_language.md`)
- **발송 전 컨펌** (`feedback_confirm_before_send.md`)

## 카테고리별 진행 상황

각 프로젝트 폴더의 `handoff.md` 참고:
- **SNU (학교)**: `projects/02.SNU/handoff.md` — 수강 일정, 학사 관련
- **Personal**: `projects/01.Personal/handoff.md`
- **Congregation**: `projects/03.Congregation/handoff.md`

## 다음 단계

- 컨텍스트 전환 시 해당 프로젝트 `handoff.md` 참고
