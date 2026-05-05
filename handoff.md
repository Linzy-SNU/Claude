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

**목표:** 학교 일정을 Google Calendar에 반복 이벤트로 추가하고 이메일로 전송

**현재 상태:**
- ✅ Google Calendar 연동 확인 (kes0314@snu.ac.kr)
- ✅ Gmail 연동 확인 (메일 발송 가능)
- ⚠️ Apple Calendar 연동 상태 미확인
- ❌ 학교 일정 데이터 필요 (과목명, 요일, 시간)

**필요한 정보:**
- 과목명/수업명
- 요일 (월, 화, 수, 목, 금 등)
- 시간 (예: 09:00 ~ 10:30)

**다음 작업:**
1. 사용자로부터 학교 일정 세부 정보 수집
2. Google Calendar에 반복 이벤트 생성
3. 생성된 일정을 이메일로 전송 (kes0314@snu.ac.kr, kes0314@gmail.com)
4. Apple Calendar 확인 (필요시)

## 다음 단계

- 학교 일정 반복 이벤트 생성 계속 진행
- Personal/SNU/Congregation 컨텍스트 전환 시 필요한 작업 진행
