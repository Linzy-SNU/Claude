# 핸드오프 (Handoff)

## 진행 상황

### ✅ GitHub 연동 완료 (2026-05-05)

- 로컬 `/Users/linzy/Claude/` ↔ GitHub `linzy-SNU/Claude` 동기화 완료
- .gitignore로 민감한 파일 제외 (credentials, .claude.json 등)
- 자동 git commit & push 설정 (`feedback_autogit.md`)

### ✅ Google Calendar 수강 일정 등록 완료 (2026-05-05)

**등록된 일정 (6개 반복 이벤트):**

| 요일 | 시간 | 위치 |
|------|------|------|
| 월 | 10:00~12:00 | Building 26, Room 102 |
| 화 | 10:00~12:00 | Building 5, Room 211 |
| 수 | 10:00~12:00 | Building 1, Room 203 |
| 목 | 10:00~12:00 | Building 14, Room 208 |
| 금 | 10:00~12:00 | Building 61, Room 103 |
| 금 | 14:00~16:00 | Building 61, Room 320 |

- 반복 규칙: `FREQ=WEEKLY;UNTIL=20260619T235959Z`
- 공휴일 안내 이벤트 설명에 포함 (EXDATE 미지원으로 직접 제외 불가)
- **⚠️ 공휴일(5/15, 6/6 등) 해당 이벤트는 사용자가 Google Calendar에서 직접 삭제 필요**

### 📧 이메일 발송 대기 중

- Gmail MCP에 발송 기능 없음 → 사용자가 직접 발송 필요
- Gmail 초안함에 **"2026학년도 1학기 수강신청 일정 안내"** 저장됨
- 수신: kes0314@snu.ac.kr (학교 이메일, 한국어)

## 다음 단계

- [ ] Gmail 초안함에서 학교 이메일 직접 발송
- [ ] 공휴일 해당 캘린더 이벤트 수동 삭제
- Personal/SNU/Congregation 컨텍스트 전환 시 필요한 작업 진행
