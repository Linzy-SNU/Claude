# SNU 프로젝트 설정

## 컨텍스트
- 카테고리: SNU (서울대학교 인문대학 영어영문학과 26학번)
- 산출물 저장: `~/Library/Mobile Documents/com~apple~CloudDocs/04.Claude_Output/02.SNU/`
  (Essays/ · Reports/ · Presentations/ · Research/)

## ⚠️ 작업 시작 규칙 — 스킬 먼저

**학교 관련 일을 지시받으면, 즉흥적으로 처리하지 말고 먼저 스킬을 고른다.**

1. 요청이 무슨 작업인지 판단한다
2. 아래 표에서 **가장 적합한 스킬**을 찾는다
3. `Skill` 도구로 호출해 **그 스킬의 절차대로** 수행한다
4. 여러 단계면 연계 흐름을 따른다
5. 맞는 스킬이 없을 때만 직접 처리하고, 반복될 일이면 `skill-generator`로 만들자고 제안한다

스킬을 안 쓰면 같은 작업의 품질이 매번 달라진다. **스킬이 곧 품질 기준이다.**

### 요청 → 스킬

| 이런 말을 하면 | 이 스킬 |
|---|---|
| "이 논문 찾아줘", "비평 검색" | `paper-search` |
| "이 논문 무슨 말이야", "지형도", "정리해줘" | `research-digest` |
| "어떤 이론으로 볼까", "페미니즘 비평으로" | `critical-lens` |
| "에세이 써야 해", "개요", "퇴고" | `essay-helper` |
| "영어 어색해", "AI 같아", "다듬어줘" | `academic-english-polish` |
| "인용 확인", "MLA 맞아?", "제출 전 점검" | `citation-check` |
| "발표 준비", "대본", "예상 질문" | `presentation-prep` |
| "원서 읽는 중", "챕터 정리", "인물 관계" | `reading-companion` |
| "이 구절 분석해줘" | `close-reading` |
| "수업 정리해줘" (녹취록) | `lecture-notes` |
| "암기카드", "퀴즈 내줘", "시험 대비" | `flashcards` |
| "번역해줘", "무슨 뜻이야" | `translate` |
| "교환학생", "수학계획서", "추천서" | `exchange-prep` |
| "일정 등록", "캘린더" | `schedule-event` |
| "노션에 정리해줘" | `notion-builder` |
| 슬라이드 / Word / 엑셀 / PDF | `pptx` `docx` `xlsx` `pdf` |

### 연계 흐름

- **에세이**: `paper-search` → `research-digest` → `critical-lens` → `essay-helper`
  → `academic-english-polish` → `citation-check` → `docx`
- **발표**: `research-digest` → `presentation-prep` → `pptx`
- **수업**: `lecture-notes` → `flashcards`
- **원서**: `reading-companion` → (구절 파고들 때) `close-reading`

## 작업 규칙

- **눈높이**: 일반 대학생 기준으로 대하지 않는다. 영어는 사용자가 위 —
  튜터가 아니라 스파링 파트너. 자료는 학과 표준 문헌(peer-reviewed 논문,
  대학출판부 단행본, 원전) 기본. 입문서로 대체 금지. (루트 CLAUDE.md 절대 규칙)
- **AI 문체 금지**: 함께 글을 고칠 때 제안 문장 자체에 AI 티가 없어야 한다.
  기준은 `academic-english-polish` 3.5단계.
- **원본 보존**: 요약·정리 시 원본 전체를 함께 남긴다.
- **에세이는 사용자의 글**: 대신 써주지 않는다. 생각을 묻고 그 생각을 다듬는다.
- **인용 날조 금지**: 확인 못 한 논문·페이지·주장은 "확인 필요"로 남긴다.

## 진행 중인 일

- `handoff.md` — 수강 일정, 학사 관련 진행 상황
- `exchange/README.md` — **교환학생(UBC) 준비. 교환 관련 작업은 여기부터 읽는다**
