---
name: document-publish
description: 완성된 문서를 Word와 PDF로 동시에 만들어 iCloud에 저장하고 Notion에 등록하는 스킬. "문서로 만들어줘", "파일로 저장해줘", "정리해서 저장", "워드로 뽑아줘" 요청이나, 다른 스킬(에세이·리서치·발표 등)의 결과물을 산출할 때 사용. 저장은 iCloud, 검색·공유는 Notion으로 역할이 나뉜다.
---

# Document Publish (문서 산출)

작업 결과물을 **Word + PDF 두 형식으로 동시에** 만들고, 정해진 자리에 저장한다.

## 역할 분담 (고정)

| 저장소 | 역할 |
|---|---|
| **iCloud `05.Claude_Output/`** | **저장소** — 원본 파일(.docx / .pdf)이 사는 곳 |
| **Notion** | **문서 검색·공유용** — 요약과 위치를 등록해 찾고 공유하는 곳 |
| GitHub 저장소 | 텍스트 기록·결정 로그 (문서 파일은 두지 않는다) |

Google Drive · Dropbox · OneDrive에는 **저장하지 않는다.**
여러 곳에 흩어놓으면 어느 게 최신인지 알 수 없게 된다.

## 사용 시점

- "문서로 만들어줘" / "파일로 저장해줘" / "워드로 뽑아줘"
- 다른 스킬(`essay-helper`, `research-digest`, `presentation-prep`, `paper-search` 등)이
  결과물을 낼 때 **마지막 단계로 자동 연계**

## 워크플로

### 1단계: 분류·경로 결정

| 카테고리 | 경로 |
|---|---|
| SNU | `~/Library/Mobile Documents/com~apple~CloudDocs/05.Claude_Output/02.SNU/` |
| Personal | `.../05.Claude_Output/01.Personal/` |
| Congregation | `.../05.Claude_Output/03.Congregation/` |

**서브폴더**
- SNU: `Essays/` `Reports/` `Presentations/` `Research/`
- Personal: `Plans/` `Notes/` `Projects/`
- Congregation: `Speeches/` `Outlines/` `References/`

**파일명**: `제목_YYYY-MM-DD.확장자` (예: `오만과편견_인물분석_2026-08-17.docx`)
기존 파일은 이름·위치를 바꾸지 않는다.

### 2단계: 원고를 마크다운으로 정리

작업 공간에 `.md`로 먼저 쓴다 (scratchpad 또는 `projects/` 하위).
이게 docx와 pdf의 공통 원본이 된다.

- 제목은 `# `으로 한 줄 (PDF 표지 제목이 된다)
- 표·목록·인용(`>`)·굵게(`**`)를 쓰면 두 형식 모두에 반영된다

### 3단계: PDF 생성

```bash
python3 scripts/md2pdf.py <입력.md> "<출력경로/제목_YYYY-MM-DD.pdf>"
```

- macOS 내장 한글 폰트(AppleGothic)를 쓰므로 별도 설치가 필요 없다
- 제목·작성자·날짜가 표지에 자동으로 들어간다
- 표·목록·인용·수평선 지원

### 4단계: Word 생성

`docx` 스킬로 같은 마크다운 내용을 .docx로 만든다.
같은 폴더에 같은 이름(확장자만 다름)으로 저장한다.

- 에세이면 MLA 형식(더블스페이스, 헤더, Works Cited)을 적용 → `essay-helper` 규칙 참조

### 5단계: 저장 확인 ⭐

**파일을 만들었다고 저장된 게 아니다. 반드시 확인한다.**

```bash
ls -la "<저장경로>"
```

- 두 파일이 모두 있는지, 크기가 0이 아닌지
- PDF는 내용까지 확인한다 (한글이 깨지면 파일은 생겨도 쓸모없다):

```bash
osascript -e 'use framework "Quartz"
use scripting additions
set u to current application'"'"'s |NSURL|'"'"'s fileURLWithPath:"<PDF경로>"
set d to current application'"'"'s PDFDocument'"'"'s alloc()'"'"'s initWithURL:u
return (d'"'"'s |string|()) as text' | head -20
```

### 6단계: 최종본 확인 후 Notion 등록 여부 묻기 ⭐

**Notion에 자동으로 올리지 않는다. 반드시 먼저 묻는다.**

초안까지 전부 올라가면 Notion이 검색용으로 쓸모없어진다.
Notion에는 **최종본만** 남긴다.

```
문서를 만들었습니다.
- 파일: 오만과편견_인물분석_2026-08-17.docx / .pdf
- 저장: iCloud 05.Claude_Output/02.SNU/Research/

이게 최종본인가요? Notion에도 등록할까요?
```

- **최종본이다 → 등록** : 7단계 진행
- **아직 작업 중이다** : iCloud에만 두고 Notion은 건너뛴다.
  나중에 최종본이 되면 그때 등록한다
- 이전에 등록한 같은 문서의 최종본이면 **새로 만들지 말고 기존 페이지를 갱신**한다

`AskUserQuestion`으로 물어도 되고, 대화 흐름상 자연스러우면 그냥 물어봐도 된다.
다만 **묻지 않고 올리는 것은 금지**.

### 7단계: Notion 등록 (승인받은 최종본만)

`notion-builder`로 해당 과목/카테고리 페이지 아래에 등록한다.

등록할 내용:
- **제목**, 작성일, 카테고리·과목
- **요약** (3~5줄) — 나중에 검색해서 찾을 수 있게
- **iCloud 경로** (파일 원본이 어디 있는지)
- 본문 핵심 (표·목록 위주로 옮겨 검색되게)

> Notion에는 **찾고 공유하기 위한 정보**를 넣는다. 파일 원본은 iCloud에 있다.

### 8단계: 사용자에게 전달

- `SendUserFile`로 생성한 파일을 보여준다
- 저장 경로를 알려준다 (아이폰·아이패드 파일 앱에서 바로 열린다)
- Notion 페이지 링크를 함께 준다

## 주의사항

- **원본 보존**: 요약본을 만들 때 사용자가 준 원본은 문서 맨 아래 "원문 전체"
  섹션으로 그대로 남긴다 (절대 규칙)
- **Notion 등록은 반드시 물어본다** (6단계). 최종본만 올려야 검색용으로 쓸모가 있다
- **덮어쓰기 확인**: 같은 이름의 파일이 이미 있으면 먼저 확인하고 진행한다
- Google Drive·Dropbox·OneDrive에는 저장하지 않는다 (역할 분담 표 참조)
- 한글 폰트를 못 찾으면 스크립트가 경로를 알려주며 중단된다. 조용히 넘어가지 않는다
