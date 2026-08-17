---
name: paper-search
description: 영문학 등 학술 논문·비평을 검색해주는 스킬. "논문 찾아줘", "~에 대한 연구/비평 검색해줘", "참고문헌 찾아줘" 요청에 사용. 검색 결과를 요약하고 MLA 인용 형식으로 정리해서 노션이나 작업 공간에 저장한다.
---

# Paper Search (논문 검색)

수업·과제에 필요한 학술 자료를 찾아 요약하고 인용 형식까지 만들어주는 스킬.

## 사용 시점

- "~에 대한 논문 찾아줘" / "비평 검색해줘"
- "이 작품 관련 연구 있어?"
- "참고문헌 찾아줘 / 만들어줘"

## 워크플로

### 1단계: 검색 범위 확인

- 주제, 작품/작가, 한국어·영어 자료 여부, 용도(에세이 인용, 발표, 단순 이해)
- **자료 수준을 낮춰 잡지 않는다.** 영문학 연구의 표준 문헌(peer-reviewed 논문,
  대학출판부 단행본)을 기본으로 하고, 어려우면 쉽게 풀어 설명하는 방식으로 간다.
  입문서로 대체하지 않는다 — 원전을 읽을 수 있어야 실력이 는다
- 자료 유형을 구분해 표시: peer-reviewed 논문 / 단행본 챕터 / 학술서 / 서평 / 사전항목
  (에세이에서 인용 가치가 다르다)

### 2단계: 검색

**1순위 — 학술 API 직접 호출** (`WebFetch` 사용, 무료·키 불필요, 결과가 가장 정확):

> ⚠️ 클라우드 세션에서는 네트워크 정책상 이 API들이 403으로 차단될 수 있다 (2026-06 확인됨). 403이 나오면 재시도하지 말고 **즉시 2순위 WebSearch로 전환**할 것. 맥북 로컬 세션에서는 정상 작동.

| API | 호출 예시 | 특징 |
|-----|----------|------|
| OpenAlex | `https://api.openalex.org/works?search=검색어&per-page=10` | 인문학 포함 전 분야, 인용수·무료PDF 링크 제공 |
| Semantic Scholar | `https://api.semanticscholar.org/graph/v1/paper/search?query=검색어&fields=title,authors,year,abstract,externalIds,openAccessPdf` | 초록 포함 |
| CrossRef | `https://api.crossref.org/works?query=검색어&rows=10` | 서지정보·DOI 정확 |

- 검색어는 **영어로** 넣는다 (예: "Shakespeare sonnet temporality")
- 결과의 `openAccessPdf` / `open_access` 필드로 무료 PDF 여부 확인

**2순위 — 웹 검색 보완** (`WebSearch`):
- 한국어 자료: `site:dbpia.co.kr`, `site:riss.kr`, `site:kci.go.kr` 붙여서 검색
- 영어 비평: Google Scholar, JSTOR, Project MUSE 결과 페이지

### 2.5단계: 영문학 연구의 표준 인프라

일반 학술 검색으로는 영문학 연구의 핵심 문헌이 안 잡힌다.
아래를 안내한다 — **대부분 서울대 도서관 구독으로 교내·프록시 접속 시 무료**.

**필수 데이터베이스**

| 도구 | 용도 |
|---|---|
| **MLA International Bibliography** | 영문학 연구의 표준 색인. 이 분야 논문을 찾는 정본 경로 |
| **JSTOR / Project MUSE** | 인문학 저널 전문(全文). 회고적 아카이브가 강함 |
| **OED (Oxford English Dictionary)** | 단어의 **역사적 의미** 추적. 시대별 용례가 그대로 논거가 된다 |
| **Literature Online (LION)** | 원전 텍스트 + 비평 통합 검색 |
| **EEBO / ECCO** | 초기 근대·18세기 원본 영인본. 판본 연구의 기초 |

**핵심 저널** (이 분야 논쟁이 벌어지는 곳)

PMLA · ELH · Critical Inquiry · Representations · Modern Language Quarterly ·
Novel: A Forum on Fiction · Nineteenth-Century Literature · Victorian Studies ·
Review of English Studies · Essays in Criticism

→ 특정 저널을 훑으면 **그 분야가 지금 무엇을 논쟁 중인지** 파악된다.

**인용 사슬 타기 (citation chaining)** — 검색어보다 강력한 방법

1. **뒤로**: 좋은 논문 하나를 잡고 **각주와 참고문헌**을 턴다.
   그 분야의 필독 문헌이 거기 다 있다
2. **앞으로**: Google Scholar의 "Cited by"로 그 논문을 인용한 후속 연구를 본다
   → 논쟁이 그 뒤로 어떻게 전개됐는지 보인다
3. **정전 확인**: 여러 논문이 공통으로 인용하는 문헌 = 그 분야 필독서

**판본 확인** — 영문학에서 자주 놓치는 지점
어느 판본을 인용하는지가 논거에 영향을 준다. Norton Critical, Oxford World's
Classics, Cambridge 학술판 등 판본별 차이(주석·이본·서문)를 확인하고,
인용 시 판본을 명시한다.

- 무료 열람 가능 여부 표시. 유료 자료는 **서울대 도서관**(lib.snu.ac.kr) 교내 접속으로 볼 수 있다고 안내

### 3단계: 결과 정리

논문마다 다음 형식으로 정리 (5~8편 권장):

```
### 1. 논문 제목
- 저자, 연도, 게재지
- 📌 핵심 주장 (2~3줄)
- 💡 과제에 쓸 만한 포인트
- 🔗 링크 (무료/유료 표시)
- 📚 MLA 인용: Author. "Title." Journal, vol. X, no. X, Year, pp. XX-XX.
```

### 4단계: 저장 (사용자가 원하면)

- 노션: 해당 과목 페이지 하위에 "참고문헌" 페이지로 저장 (`notion-builder` 방식)
- 작업 공간: `projects/02.SNU/research/주제_YYYY-MM-DD.md` 저장 후 자동 커밋·푸시·머지

## 주의사항

- **존재하지 않는 논문을 지어내지 않는다** — 반드시 실제 검색 결과만 사용, 링크로 확인 가능한 것만
- 인용 형식은 영문과 기본인 **MLA 9판** 사용 (교수님이 다른 형식 요구 시 변경)
- 초록만 보고 요약한 경우 "초록 기준"임을 표시

## 사용 도구

- `WebSearch`, `WebFetch`: 논문 검색·초록 확인
- `mcp__Notion__notion-create-pages`: 노션 저장
