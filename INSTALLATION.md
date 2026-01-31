# 법령 모니터링 시스템 설치 및 배포 가이드

## 📋 목차
1. [Supabase 설정](#1-supabase-설정)
2. [로컬 테스트](#2-로컬-테스트)
3. [Render 배포](#3-render-배포)
4. [시스템 사용법](#4-시스템-사용법)

---

## 1. Supabase 설정

### 1.1 Supabase 프로젝트 생성

1. https://supabase.com 접속
2. "New Project" 클릭
3. 프로젝트 정보 입력:
   - Name: law-monitoring-system
   - Database Password: 안전한 비밀번호 설정
   - Region: Northeast Asia (Seoul) 선택
4. "Create new project" 클릭

### 1.2 데이터베이스 스키마 생성

1. Supabase 대시보드 좌측 메뉴에서 "SQL Editor" 클릭
2. "New query" 클릭
3. `database_schema.sql` 파일의 내용을 복사하여 붙여넣기
4. "Run" 버튼 클릭하여 실행

### 1.3 API 키 확인

1. 좌측 메뉴에서 "Settings" > "API" 클릭
2. 다음 정보 복사:
   - **Project URL**: `https://qiwqcylerloqxdqupgbk.supabase.co`
   - **anon public key**: `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...`

### 1.4 환경 설정 파일 수정

`config.js` 파일을 열어 다음 값을 수정:

```javascript
const CONFIG = {
    SUPABASE_URL: 'YOUR_PROJECT_URL',  // 위에서 복사한 URL
    SUPABASE_KEY: 'YOUR_ANON_KEY',     // 위에서 복사한 anon key
    LAW_API_KEY: 'lawmonitor2025',
    // ...
};
```

---

## 2. 로컬 테스트

### 방법 1: 정적 파일 서버 (간단)

Python이 설치되어 있다면:

```bash
cd new_monitoring_system
python -m http.server 8000
```

브라우저에서 http://localhost:8000 접속

**주의**: 이 방법은 CORS 문제로 법제처 API 호출이 실패할 수 있습니다.

### 방법 2: Node.js 서버 (권장)

```bash
cd new_monitoring_system

# 의존성 설치
npm install

# 서버 실행
npm start
```

브라우저에서 http://localhost:3000 접속

**장점**: CORS 프록시가 포함되어 법제처 API를 정상적으로 호출할 수 있습니다.

---

## 3. Render 배포

### 3.1 GitHub 저장소 준비

```bash
cd new_monitoring_system

# Git 초기화
git init

# .gitignore 확인 (이미 생성됨)

# 파일 추가
git add .

# 커밋
git commit -m "Initial commit: 법령 모니터링 시스템"

# GitHub에 푸시 (사전에 GitHub 저장소 생성 필요)
git remote add origin https://github.com/YOUR_USERNAME/law-monitoring-system.git
git branch -M main
git push -u origin main
```

### 3.2 Render 배포 (정적 사이트)

**간단하지만 CORS 문제 있음**

1. https://render.com 접속 및 로그인
2. "New +" > "Static Site" 클릭
3. GitHub 저장소 연결
4. 설정:
   - **Name**: law-monitoring-system
   - **Branch**: main
   - **Build Command**: (비워두기)
   - **Publish Directory**: `.`
5. "Create Static Site" 클릭

### 3.3 Render 배포 (Node.js 서버) ⭐ 권장

**CORS 프록시 포함, 완전한 기능 제공**

1. https://render.com 접속 및 로그인
2. "New +" > "Web Service" 클릭
3. GitHub 저장소 연결
4. 설정:
   - **Name**: law-monitoring-system
   - **Environment**: Node
   - **Branch**: main
   - **Build Command**: `npm install`
   - **Start Command**: `npm start`
5. 환경 변수 추가:
   - `LAW_API_KEY`: lawmonitor2025
   - `NODE_ENV`: production
6. "Create Web Service" 클릭

배포 완료 후 제공되는 URL로 접속하세요!

---

## 4. 시스템 사용법

### 4.1 초기 설정

1. **키워드 등록**
   - "키워드 관리" 탭으로 이동
   - 업무와 관련된 키워드 등록 (예: "안전관리", "산업안전", "작업안전" 등)

### 4.2 법령 검색 및 모니터링 추가

1. **법령 검색**
   - "법령 검색" 탭으로 이동
   - 검색어 입력 후 검색
   - 검색 결과에서 관련 법령 클릭

2. **모니터링 추가**
   - 법령 상세 모달에서 "모니터링 추가" 버튼 클릭
   - 대시보드에서 모니터링 중인 법령 수 증가 확인

### 4.3 변경사항 확인

1. **수동 확인**
   - "변경사항" 탭으로 이동
   - "변경사항 확인" 버튼 클릭
   - 시스템이 자동으로 법령 변경사항 감지

2. **검토 처리**
   - 미검토 변경사항 확인
   - "검토 완료" 버튼 클릭하여 검토 상태로 변경

### 4.4 조치사항 관리

1. **조치사항 생성**
   - "변경사항" 탭에서 변경사항 선택
   - "조치사항 생성" 버튼 클릭
   - 제목, 설명, 우선순위, 담당자, 마감일 입력

2. **진행 상태 관리**
   - "조치사항" 탭으로 이동
   - 상태 필터로 원하는 조치사항 조회
   - "진행 시작" 또는 "완료" 버튼으로 상태 변경

### 4.5 대시보드 활용

- 실시간 통계 확인
- 최근 변경사항 모니터링
- 긴급 조치사항 확인
- 자동 새로고침 (5분마다)

---

## 🚨 문제 해결

### CORS 오류 발생 시

**증상**: 법령 검색 시 "CORS policy" 오류 발생

**해결방법**:
1. Node.js 서버 버전 사용 (server.js)
2. Render에 Web Service로 배포
3. 로컬 테스트 시 `npm start` 사용

### Supabase 연결 오류

**증상**: "Failed to fetch" 또는 연결 오류

**해결방법**:
1. `config.js`의 SUPABASE_URL과 SUPABASE_KEY 확인
2. Supabase 프로젝트가 활성 상태인지 확인
3. 브라우저 콘솔에서 자세한 오류 메시지 확인

### 데이터가 표시되지 않음

**해결방법**:
1. Supabase에서 `database_schema.sql` 정상 실행 확인
2. 테이블이 생성되었는지 확인 (Table Editor에서 확인)
3. RLS 정책이 올바르게 설정되었는지 확인

---

## 📞 지원

문제가 계속되면 다음을 확인하세요:
- 브라우저 개발자 도구 콘솔 (F12)
- Supabase 대시보드의 Logs
- Render 배포 로그

추가 도움이 필요하면 프로젝트 이슈를 등록해주세요.
