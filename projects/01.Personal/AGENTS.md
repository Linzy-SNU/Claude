# Personal 프로젝트 설정

## 컨텍스트
- 카테고리: Personal (자기계발, 개인 프로젝트, 기록)
- 산출물 저장: `~/Library/Mobile Documents/com~apple~CloudDocs/05.Claude_Output/01.Personal/`
  (Plans/ · Notes/ · Projects/)

## ⚠️ 작업 시작 규칙 — 스킬 먼저

**지시를 받으면 즉흥적으로 처리하지 말고 먼저 스킬을 고른다.**

1. 요청이 무슨 작업인지 판단한다
2. 아래 표에서 **가장 적합한 스킬**을 찾는다
3. `Skill` 도구로 호출해 **그 스킬의 절차대로** 수행한다
4. 맞는 스킬이 없을 때만 직접 처리하고, 반복될 일이면 `skill-generator`로 만들자고 제안한다

### 요청 → 스킬

| 이런 말을 하면 | 이 스킬 |
|---|---|
| "이거 조사해줘", "깊게 알아봐줘" | `recursive-research` |
| "논문·자료 찾아줘" | `paper-search` |
| "읽은 것 정리·연결해줘" | `research-digest` |
| "이 기사 저장해줘" (URL) | `article-extractor` |
| "이 유튜브 정리해줘" | `youtube-to-notion` |
| "노션에 정리해줘/만들어줘" | `notion-builder` |
| "일정 등록해줘" | `schedule-event` |
| "암기카드", "퀴즈" (학습용) | `flashcards` |
| "번역해줘" | `translate` |
| "문서 같이 쓰자", "기획서" | `doc-coauthoring` |
| **"문서로 만들어줘", "파일로 저장"** | `document-publish` |
| Word / 엑셀 / PDF / 슬라이드 | `docx` `xlsx` `pdf` `pptx` |
| 웹사이트 조작·자동화 | `agent-browser` |

## 작업 규칙

- **눈높이**: 일반 눈높이로 대하지 않는다 (루트 CLAUDE.md 절대 규칙 참조).
  기초 설명 생략, 자료는 원전·표준 문헌 기본.
- **AI 문체 금지**: 글을 함께 고칠 때 제안 문장 자체에 AI 티가 없어야 한다.
  기준은 `academic-english-polish` 3.5단계 (영문·국문 모두 적용).
- **원본 보존**: 요약·정리 시 원본 전체를 함께 남긴다.
- **날조 금지**: 확인 못 한 사실·출처는 "확인 필요"로 남긴다.

## 연동 도구

- **Notion**: 사용 중. 정리·아카이브는 `notion-builder` 경유
- **Google Calendar**: 일정은 `schedule-event` 경유
- **Slack**: 등록됨
