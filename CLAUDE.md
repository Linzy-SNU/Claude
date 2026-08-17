# Claude 작업 공간

## 기본 정보
- 사용자: 김은수 (Linzy)
- 소속: 서울대학교 인문대학 영어영문학과 26학번 (1학년)
- 수강: 영문학 전공 수업 + 코딩 수업(컴퓨팅 기초) 병행
- 이메일: kes0314@snu.ac.kr
- 작업 디렉토리: `/Users/linzy/Claude/`

## 이 폴더의 역할
Claude Code 작업을 위한 메인 작업 공간입니다.

## 산출물 저장 위치
iCloud Drive의 `04.Claude_Output/` 폴더에 카테고리별로 저장합니다.

| 카테고리 | 경로 |
|---------|------|
| Personal | `~/Library/Mobile Documents/com~apple~CloudDocs/04.Claude_Output/01.Personal/` |
| SNU | `~/Library/Mobile Documents/com~apple~CloudDocs/04.Claude_Output/02.SNU/` |
| Congregation | `~/Library/Mobile Documents/com~apple~CloudDocs/04.Claude_Output/03.Congregation/` |

### 서브폴더 구조
| 카테고리 | 서브폴더 |
|---------|---------|
| SNU | Essays/, Reports/, Presentations/, Research/ |
| Congregation | Speeches/, Outlines/, References/ |
| Personal | Plans/, Notes/, Projects/ |

### 파일명 규칙
- **새로 만드는 파일**: `제목_YYYY-MM-DD.확장자` (예: `영문에세이_2026-05-05.docx`)
- **기존 파일**: 이름 및 위치 변경 금지

## 규칙 및 선호사항
- **요약/정리 시 원본 보존 (절대 규칙)**: 수업 정리·문서 요약 등 어떤 요약 작업에서도 사용자가 제공한 원본 텍스트·파일은 절대 삭제·수정하지 않는다. 요약본은 별도로 만들고, 원본 전체는 수정 없이 그대로 함께 보존한다 (파일이면 맨 아래 "원문 전체" 섹션, 노션이면 토글/하단 섹션).
- **세션 시작 시 항상 `git pull`**: 모든 세션은 작업을 시작하기 전에 먼저 `git pull origin main`으로 최신 상태를 받아온다.
- **세션 마지막에 항상 자동 `git commit` & `git push`**: 작업이 끝나면 묻지 말고 자동으로 커밋하고 푸시해서 GitHub에 반영한다. (푸시까지 해야 다른 기기에서 보임)
- 위 두 규칙은 훅으로도 강제된다 — `scripts/git-auto-sync.sh` (SessionStart→pull, Stop→commit+push). `.claude/settings.json`에 등록되어 있어 **맥북·아이패드·클라우드 세션 어디서든 자동 적용**된다. detached HEAD·진행 중인 merge·자격증명 의심 파일(.env, *.pem, *.key 등)이 있으면 자동으로 건너뛴다. 로그: `~/Library/Logs/claude-git-hook.log`
- **작업 브랜치에 푸시한 경우 PR 생성 후 자동 머지**: 스킬 실행 등 작업이 끝나면 묻지 말고 PR을 만들어 바로 main에 머지까지 완료한다.
- **항상 클라우드 세션 사용**: 새 세션은 항상 Claude Code 클라우드(웹) 방식으로 연다. GitHub 저장소(`linzy-SNU/Claude`) 기반으로 작업하므로 맥북·아이패드·휴대폰 어디서든 같은 세션과 최신 파일을 실시간으로 이어서 쓸 수 있다.
- 클라우드 세션에서 작업한 내용은 반드시 커밋·푸시해서 GitHub에 반영한다 (푸시해야 다른 기기에서 보임)
- 맥북 로컬 폴더는 세션 시작 시 `git pull`, 작업 종료 시 커밋·푸시로 GitHub과 맞춰진다 (위 훅) — `기기연동_가이드.md` 참고
- 항상 `/Users/linzy/Claude/` 를 루트로 실행
- "개인으로 들어가자" → Personal 컨텍스트로 전환
- "학교로 들어가자" → SNU 컨텍스트로 전환
- "회중으로 들어가자" → Congregation 컨텍스트로 전환
- 컨텍스트 전환 시 해당 `projects/번호.카테고리/meta.md` 참고, 산출물은 해당 iCloud 폴더에 저장
- 산출물은 항상 위 iCloud Drive 경로에 카테고리에 맞게 저장
- **유튜브에서 가져온 자료**는 노션 `1-1 SNU` 페이지의 "유튜브 자료" 데이터베이스에 저장 (제목/URL/채널/날짜/관련 과목 속성, 정리 내용은 페이지 안에)

## 프로젝트 구조
```
Claude/
├── CLAUDE.md          ← 전체 설정 메타파일
├── .claude/skills/    ← 모든 스킬 저장 위치 (Claude Code가 /명령어로 인식하는 곳)
│   ├── lecture-notes/   ← 다글로 수업 정리 → 노션 강의노트
│   ├── notion-builder/  ← 노션에 페이지·DB 자동 생성
│   └── schedule-event/  ← Google Calendar 일정 등록
└── projects/
    ├── 01.Personal/meta.md
    ├── 02.SNU/meta.md
    └── 03.Congregation/meta.md
```

**스킬은 반드시 `.claude/skills/스킬명/SKILL.md`에 만든다.** (다른 위치는 /명령어로 인식 안 됨)

각 프로젝트 폴더 구조:
```
projects/카테고리/
├── CLAUDE.md        ← 해당 프로젝트 Claude 설정
├── README.md        ← 프로젝트 개요 및 작업 목록
├── handoff.md       ← 세션 간 인수인계
├── meta.md          ← 기타 메타 정보
├── skills/          ← 해당 프로젝트 전용 스킬 정의
└── agents/          ← 해당 프로젝트 전용 에이전트 정의
```

컨텍스트 전환 시 해당 프로젝트의 skills/와 agents/ 를 우선 참고합니다.
