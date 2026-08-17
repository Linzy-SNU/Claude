# Congregation 프로젝트 설정

## 컨텍스트
- 카테고리: Congregation (회중 — 연설, 개요, 참고자료)
- 산출물 저장: `~/Library/Mobile Documents/com~apple~CloudDocs/05.Claude_Output/03.Congregation/`
  (Speeches/ · Outlines/ · References/)

## ⚠️ 작업 시작 규칙 — 스킬 먼저

**지시를 받으면 즉흥적으로 처리하지 말고 먼저 스킬을 고른다.**

1. 요청이 무슨 작업인지 판단한다
2. 아래 표에서 **가장 적합한 스킬**을 찾는다
3. `Skill` 도구로 호출해 **그 스킬의 절차대로** 수행한다
4. 맞는 스킬이 없을 때만 직접 처리하고, 반복될 일이면 `skill-generator`로 만들자고 제안한다

### 요청 → 스킬

| 이런 말을 하면 | 이 스킬 |
|---|---|
| "연설 준비", "대본", "예상 질문·시간 배분" | `presentation-prep` |
| "개요 잡아줘", "원고 같이 쓰자" | `doc-coauthoring` |
| "자료 조사해줘" | `recursive-research` |
| "이 구절 무슨 뜻이야", "번역" | `translate` |
| "노션에 정리해줘" | `notion-builder` |
| "일정 등록해줘" | `schedule-event` |
| Word / PDF / 슬라이드 | `docx` `pdf` `pptx` |

## 작업 규칙

- **원고는 사용자의 말이어야 한다**: 대신 다 써주지 않는다.
  생각을 묻고 그 생각을 다듬는 방식으로. `essay-helper`의 원칙과 동일.
- **AI 문체 금지**: 제안 문장 자체에 AI 티가 없어야 한다.
  연설문은 특히 **말할 때 자연스러운 문장**이어야 한다 (문어체 ❌).
- **원본 보존**: 요약·정리 시 원본 전체를 함께 남긴다.
- **인용 정확성**: 성구·인용문은 정확히 옮기고, 확인 못 하면 "확인 필요"로 남긴다.
  기억에 의존해 지어내지 않는다.
- **눈높이**: 일반 눈높이로 대하지 않는다 (루트 CLAUDE.md 절대 규칙 참조).

## 연동 도구

- **Notion**: 사용 중. 정리·아카이브는 `notion-builder` 경유
- **Google Calendar**: 일정은 `schedule-event` 경유
