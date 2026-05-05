# 핸드오프 (Handoff)

## 진행 상황

### ✅ GitHub 연동 완료 (2026-05-05)

**목표:** `/Users/linzy/Claude/` 로컬 저장소를 GitHub의 `linzy-SNU/Claude` 저장소와 연동

**완료된 작업:**

1. **Git 초기화 및 설정**
   - 로컬 저장소에서 `git init` 실행
   - GitHub 원격 저장소 연동 (`origin`)
   - 메인 브랜치 생성 및 설정

2. **.gitignore 구성**
   - 민감한 정보 제외:
     - `.claude/credentials/` (Google OAuth credentials)
     - `.claude.json`, `.claude.json.backup` (Claude 설정)
     - `.claude/settings.local.json` (민감한 설정)
   - macOS 파일 제외: `.DS_Store`
   - IDE 파일 제외: `.vscode/`, `.idea/`

3. **보안 문제 해결**
   - GitHub Push Protection에서 Google OAuth 토큰 감지
   - `git filter-branch`를 사용해 커밋 히스토리에서 민감한 파일 제거
   - `git push origin main --force`로 정제된 히스토리 푸시

4. **저장소 구조 확인**
   - 3개 프로젝트 폴더 구조 유지 (Personal, SNU, Congregation)
   - 로컬 구조 ≈ GitHub 구조 (완벽히 일치)

**현재 상태:**
- 로컬 저장소와 GitHub 저장소가 동기화됨
- 최신 커밋: `10538b8 Update gitignore to exclude sensitive credentials`
- 모든 파일이 git으로 추적 중

### 🔄 새로운 설정

**자동 Git 커밋/푸시:**
- 특정 작업이 완료될 때마다 자동으로 `git commit`과 `git push` 실행
- 메모리: `feedback_autogit.md`

### 🗓️ Google Calendar 반복 이벤트 생성 (진행 중)

**목표:** 2026학년도 서울대 수강신청 일정을 Google Calendar에 반복 이벤트로 추가하고 이메일로 전송

**현재 상태:**
- ✅ Google Calendar 연동 확인 (kes0314@snu.ac.kr)
- ✅ Gmail 연동 확인 (메일 발송 가능)
- ⚠️ Apple Calendar 연동 상태 미확인
- ✅ 학교 일정 데이터 수집 완료 (2026-05-05)

**수집된 학교 일정 정보:**

캡처된 스크린샷(2026-05-05)에서 월-금 10:00-18:00 시간대의 다음 과목들 식별됨:

| 시간 | 월(MON) | 화(TUE) | 수(WED) | 목(THU) | 금(FRI) |
|------|---------|---------|---------|---------|---------|
| 10:00-12:00 | Building 26, Room 102 | Building 5, Room 211 | Building 1, Room 203 | Building 14, Room 208 | Building 61, Room 103 |
| 12:00-14:00 | | | | | |
| 14:00-16:00 | | | | | Building 61, Room 320 |
| 16:00-18:00 | | | | | |

**학교 일정 세부사항:**
- **학기**: 2026학년도 1학기 (예상: 2026년 3월 ~ 6월)
- **요일**: 월-금
- **제외 휴일** (2026): 
  - 5월 15일 (스승의 날)
  - 6월 6일 (현충일)
  - 8월 15일 (광복절)
  - 9월 3-5일 (추석)
  - 10월 3일 (개천절)
  - 10월 9일 (한글날)
  - 12월 25일 (크리스마스)
- **위치 형식**: "Seoul National University Building [X]" + 호수는 별도 표기
- **Google Maps 통합**: 위치 필드에서 지도 연동 필요

**다음 작업 (우선순위 순):**
1. ✅ 학교 일정 데이터 스크린샷 분석 완료
2. 🔄 Google Calendar API를 사용해 각 과목별 반복 이벤트 생성
   - 각 요일/시간별 반복 일정 설정
   - 한국 공휴일 EXDATE 규칙 적용
   - Google Maps 위치 통합
3. 학교 및 개인 이메일로 일정 요약 전송
   - kes0314@snu.ac.kr (학교 이메일)
   - kes0314@gmail.com (개인 이메일)
4. 완료 후 자동 git commit & push 실행

## 다음 단계

- 학교 일정 반복 이벤트 생성 계속 진행
- Personal/SNU/Congregation 컨텍스트 전환 시 필요한 작업 진행
