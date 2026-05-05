# Claude 작업 공간

## 기본 정보
- 사용자: 김은수 (Linzy)
- 소속: 서울대학교 인문대학 영어영문학과 26학번
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
- 항상 `/Users/linzy/Claude/` 를 루트로 실행
- "개인으로 들어가자" → Personal 컨텍스트로 전환
- "학교로 들어가자" → SNU 컨텍스트로 전환
- "회중으로 들어가자" → Congregation 컨텍스트로 전환
- 컨텍스트 전환 시 해당 `projects/번호.카테고리/meta.md` 참고, 산출물은 해당 iCloud 폴더에 저장
- 산출물은 항상 위 iCloud Drive 경로에 카테고리에 맞게 저장

## 프로젝트 구조
```
Claude/
├── CLAUDE.md          ← 전체 설정 메타파일
└── projects/
    ├── 01.Personal/meta.md
    ├── 02.SNU/meta.md
    └── 03.Congregation/meta.md
```

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
