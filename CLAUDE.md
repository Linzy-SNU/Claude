# Claude 작업 공간

## 기본 정보
- 사용자: 김은수 (Linzy)
- 소속: 서울대학교 인문대학 영어영문학과 26학번 (1학년)
- 수강: 영문학 전공 수업 + 코딩 수업(컴퓨팅 기초) 병행
- 배경: 외국어고 전교권 → 수시 합격. 전국 연 9명 선발 학부
- 목표: 2학년 진학 후 **UBC(캐나다) 교환학생** 파견
- 이메일: kes0314@snu.ac.kr
- 작업 디렉토리: `/Users/linzy/Claude/`

## 이 폴더의 역할
Claude Code 작업을 위한 메인 작업 공간입니다.

## 산출물 저장 위치
iCloud Drive의 `05.Claude_Output/` 폴더에 카테고리별로 저장합니다.

| 카테고리 | 경로 |
|---------|------|
| Personal | `~/Library/Mobile Documents/com~apple~CloudDocs/05.Claude_Output/01.Personal/` |
| SNU | `~/Library/Mobile Documents/com~apple~CloudDocs/05.Claude_Output/02.SNU/` |
| Congregation | `~/Library/Mobile Documents/com~apple~CloudDocs/05.Claude_Output/03.Congregation/` |

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
- **작업 방식 — 리서치 → 계획 → 제안 → 승인 (절대 규칙)**: 사용자가 무언가를 요청하면 **바로 실행하지 않는다.** 아래 순서를 지킨다.
  1. **벤치마킹·리서치 최소 3~5건** — 실제 사례·문서·자료를 찾는다. **내 머릿속 의견만으로 답하지 않는다.** 출처를 남긴다
  2. **근거 기반 계획** — 찾은 내용을 근거로 계획을 세운다. 어떤 자료의 어떤 점을 반영했는지 밝힌다
  3. **제안** — 선택지와 트레이드오프를 함께 제시한다
  4. **승인 대기** — 사용자가 승인한 뒤에 실행한다
  - 예외: 단순 조회·읽기, 명백한 오류 수정, 사용자가 "바로 해"라고 한 경우
  - 리서치 결과가 빈약하면 그렇다고 말한다. 없는 근거를 지어내 계획을 채우지 않는다
- **스킬 우선 (절대 규칙)**: **모든 작업**(학교·리서치·논문·과제·자기계발·회중 등 전부)에서, 지시를 받으면 **즉흥적으로 처리하지 말고 아래 스킬 표에서 해당 스킬을 먼저 찾아 그 스킬의 절차대로 수행한다.** 스킬이 있는데 안 쓰면 매번 품질이 달라진다.
  - 맞는 스킬이 있으면 → `Skill` 도구로 호출해서 그 워크플로를 따른다
  - 여러 개가 걸리면 → 순서대로 연계한다 (예: `paper-search` → `research-digest` → `essay-helper` → `citation-check`)
  - 맞는 스킬이 없으면 → 그때만 직접 처리하고, **반복될 일이면 `skill-generator`로 스킬을 만들자고 제안**한다
- **일반 눈높이로 대하지 않는다 (절대 규칙)**: 외고 전교권에서 수시로 서울대에 진학했고, 전국에서 한 해 9명 뽑는 학부 소속이다. 영어 학습 경력은 나보다 길다.
  - **영어에 관해서는 사용자가 위다.** 튜터가 아니라 **스파링 파트너**로 대한다. 어감·문체 판단이 갈리면 근거만 대고 **사용자 판단을 따른다**
  - 기초 문법·어휘·개념 설명으로 시간 쓰지 않는다. 모르는 것만 짚어 묻는다
  - 자료는 **학과 표준 문헌**(peer-reviewed 논문, 대학출판부 단행본, 원전)을 기본으로 한다. 입문서·요약본으로 대체하지 않는다. 어려우면 쉽게 풀어 설명하되 **수준을 낮추지는 않는다**
  - 내가 보탤 것은 **규모와 일관성**이다 — 대량 검색, 교차검증, 긴 글의 논지 일관성 점검, 분야 관례, 내 AI 문체 감시
  - 수준을 모르겠으면 **낮춰 잡지 말고 물어본다**
- **글을 함께 고칠 때 내 제안이 AI 문체가 되지 않게 한다 (절대 규칙)**: 은수님과 교차검증하며 문장을 다듬는 것이 기본 작업 방식이다. 이때 **제안하는 문장 자체가 이미 AI 티가 없어야 한다** — 마지막에 걷어내는 게 아니라 처음부터 넣지 않는다. 금지: 빈 도입구(It is important to note…), 기계적 3박자(X, Y, and Z), 접속어 남발(Moreover/Furthermore), 상투 대비구문(not merely X but Y), 티 나는 어휘(delve, tapestry, nuanced, crucial, underscore), 균일한 문장 길이. `projects/02.SNU/voice-profile.md`가 있으면 그 문체를 기준으로 삼는다. 자세한 기준과 점검 절차는 `academic-english-polish` 스킬 참조.
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
├── .claude/skills/    ← 모든 스킬 (Claude Code가 /명령어로 인식하는 곳)
└── projects/
    ├── 01.Personal/meta.md
    ├── 02.SNU/meta.md          ← 학교
    │   └── exchange/           ← 교환학생 준비 (README.md부터 읽을 것)
    └── 03.Congregation/meta.md
```

## 🎯 스킬 목록 — 학교 일은 여기서 골라 쓴다

**지시를 받으면 먼저 이 표에서 찾는다.** (위 "스킬 우선" 절대 규칙)

### 읽기·수업
| 상황 | 스킬 |
|---|---|
| 원서 읽는 중, 챕터·인물·어휘 정리 | `reading-companion` |
| 시·구절 정밀 분석 (close reading) | `close-reading` |
| 녹취록 → 강의노트 (노션 저장) | `lecture-notes` |
| 시험 대비 암기카드·퀴즈 | `flashcards` |
| 번역·해석 | `translate` |

### 리서치
| 상황 | 스킬 |
|---|---|
| 논문·비평 **찾기** | `paper-search` |
| 찾은 논문 **읽고 소화·지형도** | `research-digest` |
| 비평 이론 이해·작품 적용 | `critical-lens` |
| 심층 반복 조사 | `recursive-research` |
| 웹 기사 본문 추출 | `article-extractor` |
| 유튜브 전사 → 노션 | `youtube-to-notion` |

### 쓰기
| 상황 | 스킬 |
|---|---|
| 에세이 (주제→논지→개요→초안→퇴고) | `essay-helper` |
| 영문 다듬기 + **AI 문체 제거** | `academic-english-polish` |
| MLA 인용·출처 검증 (제출 전) | `citation-check` |
| 문서 공동 집필 | `doc-coauthoring` |

### 발표·산출물
| 상황 | 스킬 |
|---|---|
| 발표 대본·예상질문·시간배분 | `presentation-prep` |
| 슬라이드 제작 | `pptx` |
| Word 문서 | `docx` |
| 엑셀·표 | `xlsx` |
| PDF 처리 | `pdf` |

### 관리·기타
| 상황 | 스킬 |
|---|---|
| 교환학생 준비 (UBC) | `exchange-prep` |
| 캘린더 일정 등록 | `schedule-event` |
| 노션 페이지·DB 생성 | `notion-builder` |
| 새 스킬 제작 | `skill-generator` |

**자주 쓰는 연계 흐름**
- 에세이: `paper-search` → `research-digest` → `critical-lens` → `essay-helper` → `academic-english-polish` → `citation-check` → `docx`
- 발표: `research-digest` → `presentation-prep` → `pptx`
- 수업: `lecture-notes` → `flashcards`

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
