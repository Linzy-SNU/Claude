---
name: youtube-to-notion
description: 유튜브 영상을 전사(자막 추출)하고 요약한 뒤 노션 "유튜브 자료" 데이터베이스에 저장하는 스킬. 영상 정보·한국어 요약·영어 전체 전사를 포함한 페이지를 생성하고, 마지막 응답에 생성된 노션 페이지 링크를 반드시 보여준다.
---

# YouTube to Notion (유튜브 전사 → 요약 → 노션 저장)

유튜브 링크를 받아 자막을 추출하고 요약해서 노션 유튜브 자료 데이터베이스에 저장하는 스킬.

## 사용 시점

다음과 같은 요청에 자동으로 트리거:
- "이 유튜브 전사해서 노션에 넣어줘"
- "영상 요약해서 유튜브 폴더에 저장해"
- "유튜브 정리해줘" + 링크

## 워크플로

### 1단계: 영상 메타데이터 확인

```bash
export SSL_CERT_FILE=$(python3 -m certifi)
yt-dlp --skip-download --no-warnings \
  --print "%(title)s | %(channel)s | %(duration_string)s | %(upload_date)s" "<URL>"
```

- `yt-dlp`가 없으면 `pip3 install -q yt-dlp certifi`로 설치
- **SSL 인증서 오류 발생 시**: `export SSL_CERT_FILE=$(python3 -m certifi)` 필수 (이 Mac의 python.org Python 3.14 환경에서 항상 필요)

### 2단계: 자막 다운로드

```bash
export SSL_CERT_FILE=$(python3 -m certifi)
cd /tmp && yt-dlp --skip-download --no-warnings \
  --write-auto-subs --write-subs --sub-langs "en.*,ko.*" --sub-format vtt \
  -o "yt_%(id)s" "<URL>"
```

- 한국어 영상이면 ko 자막, 영어 영상이면 en 자막 우선
- 수동 자막이 있으면 자동 자막보다 우선 사용

### 3단계: VTT → 플레인 텍스트 정리

타임스탬프/태그 제거 + 롤링 캡션 중복 제거:

```python
import re
text = open('/tmp/yt_<ID>.<lang>.vtt', encoding='utf-8').read()
lines = []
for line in text.splitlines():
    line = line.strip()
    if not line or '-->' in line or line.startswith(('WEBVTT','Kind:','Language:')) or re.match(r'^\d+$', line):
        continue
    line = re.sub(r'<[^>]+>', '', line)
    if lines and lines[-1] == line:
        continue
    lines.append(line)
out = []
for l in lines:
    if not out or l not in out[-1]:
        out.append(l)
print(' '.join(out))
```

- 자동 자막은 고유명사 표기가 부정확할 수 있음 → 불확실한 이름은 전사 정리 시 일반 표현으로 대체하고, 마지막 응답에서 사용자에게 알려주기

### 4단계: 요약 + 번역 병기 작성

한국어로 요약 작성. 노션 페이지 구성:

- **영상 정보**: 채널, 길이, 업로드일, 링크
- **요약**: 핵심 내용을 소제목별로 한국어로 정리 (개요/주요 내용/반응·분석 등 영상 성격에 맞게)
- **전체 전사 (원문 + 번역 병기)**: 원어 전사와 한국어 번역을 **문단/발언 단위로 번갈아 병기**한다.
  - 영상이 외국어(영어 등)면: 원문 한 단락 → 바로 아래 한국어 번역 한 단락 순서로 반복
  - 영상이 한국어면: 번역 불필요, 정리된 한국어 전사만
  - 인용 발언은 blockquote로
  - **원본 보존 규칙(CLAUDE.md 절대 규칙)**: 번역은 별도로 만들되 원어 전사 전문은 수정 없이 그대로 보존한다

병기 형식 예시 (Notion Markdown):

```
> "Last night was an act of self-harm by the people involved..."
>
> "어젯밤은 관련된 사람들이 저지른 자해 행위였습니다..."
```

또는 단락 단위:

```
**원문**: Now to Northern Ireland, where crowds gathered for a second night...

**번역**: 이제 북아일랜드 소식입니다. 이틀째 밤 군중이 모였습니다...
```

- 긴 영상은 병기 전문이 매우 길어지므로 노션에는 전문 병기를 넣되, 채팅 응답에는 요약만 보여준다

### 5단계: 노션 페이지 생성

**노션 "유튜브 자료" 데이터베이스** (위치: `1-1 SNU` 페이지 하위):
- 데이터베이스 ID: `a78975a0-0c7f-4e62-86be-19e77781227f`
- 데이터 소스 ID: `150744c0-f2e3-478a-8fd8-389d66e03e14` (create-pages의 parent로 사용)

속성 스키마:

| 속성 | 타입 | 값 |
|------|------|-----|
| 제목 | title | 영상 제목 |
| userDefined:URL | url | 유튜브 링크 |
| 채널 | text | 채널명 |
| 관련 과목 | select | "영미 대중소설의 이해" / "영문학입문" / "베리타스: 동양고전" / "컴퓨팅 기초" / "기타" 중 택1 |
| date:날짜:start | date | 저장한 날짜 (YYYY-MM-DD) |

- 관련 과목은 영상 내용으로 판단, 애매하면 "기타"
- 아이콘: 📺

### 6단계: 결과 알리기 (필수 형식)

마지막 응답에 **반드시 다음을 포함**:

1. **생성된 노션 페이지 링크** (클릭 가능한 마크다운 링크, 응답에서 빠뜨리지 말 것)
2. 영상 요약 (핵심만 불릿으로)
3. 채워진 속성 요약
4. 자막 품질 관련 주의사항 (있다면)

예시:

```
완료했습니다. 노션 유튜브 자료 데이터베이스에 저장했어요.

📺 [영상 제목](https://app.notion.com/p/...) (길이, 업로드일)

**영상 요약:**
- ...

노션 페이지에는 영상 정보, 한국어 요약, 원문+번역 병기 전사가 들어 있습니다.
```

## 사용 도구

- `Bash`: yt-dlp 자막 다운로드, Python 전사 정리
- `notion-search`: 데이터베이스 위치 변경 시 재탐색
- `notion-fetch`: 스키마 확인 (스키마가 바뀐 것 같을 때만)
- `notion-create-pages`: 페이지 생성 (parent: data_source_id)

## 주의사항

- **마지막 응답에 노션 링크 필수** — 링크 없이 끝내지 말 것
- 자막이 아예 없는 영상이면 사용자에게 알리고 대안(오디오 다운로드 + 전사 도구) 제안
- 긴 영상(30분+)은 전사 전문이 길어지므로 노션에는 전문을 넣되 응답에는 요약만
- 이미 같은 URL의 페이지가 있는지 의심되면 notion-search로 중복 확인
