# 법령 모니터링 시스템

법제처 API를 활용하여 업무 관련 법령을 주기적으로 모니터링하고 변경사항을 추적하는 웹 애플리케이션입니다.

## 주요 기능

- 📊 **대시보드**: 법령 모니터링 현황을 한눈에 확인
- 🔍 **법령 검색**: 법제처 API를 통한 법령 검색 및 조회
- 🔑 **키워드 관리**: 모니터링할 키워드 등록 및 관리
- 📝 **변경사항 추적**: 법령 개정/폐지 등 변경사항 자동 감지
- ✅ **조치사항 관리**: 법령 변경에 따른 조치사항 관리 및 추적

## 기술 스택

- **Frontend**: HTML5, CSS3, JavaScript (ES6+)
- **Backend**: Supabase (PostgreSQL)
- **Hosting**: Render
- **API**: 법제처 공공데이터 API

## 데이터베이스 설정

### 1. Supabase 프로젝트 생성

1. [Supabase](https://supabase.com) 접속 및 로그인
2. 새 프로젝트 생성
3. 프로젝트 URL 및 API Key 확인

### 2. 데이터베이스 스키마 생성

`database_schema.sql` 파일의 내용을 Supabase SQL Editor에서 실행하세요.

```sql
-- Supabase Dashboard > SQL Editor에서 실행
-- database_schema.sql 파일의 내용을 복사하여 붙여넣기
```

### 3. 환경 변수 설정

`config.js` 파일에서 다음 값을 수정하세요:

```javascript
const CONFIG = {
    SUPABASE_URL: 'YOUR_SUPABASE_URL',
    SUPABASE_KEY: 'YOUR_SUPABASE_ANON_KEY',
    LAW_API_KEY: 'YOUR_LAW_API_KEY',
    // ...
};
```

## 로컬 실행

1. 프로젝트 클론 또는 다운로드

```bash
git clone <repository-url>
cd new_monitoring_system
```

2. 간단한 HTTP 서버 실행

```bash
# Python 3
python -m http.server 8000

# Node.js (http-server 패키지 설치 필요)
npx http-server -p 8000
```

3. 브라우저에서 접속

```
http://localhost:8000
```

## Render 배포

### 1. GitHub 저장소 생성 및 푸시

```bash
git init
git add .
git commit -m "Initial commit"
git remote add origin <your-github-repo-url>
git push -u origin main
```

### 2. Render에서 배포

1. [Render](https://render.com) 접속 및 로그인
2. "New +" → "Static Site" 선택
3. GitHub 저장소 연결
4. 다음 설정 사용:
   - **Build Command**: `echo "No build required"`
   - **Publish Directory**: `.`

5. "Create Static Site" 클릭

### 3. 환경 변수 설정 (옵션)

민감한 정보를 환경 변수로 관리하려면 Render 대시보드에서 설정할 수 있습니다.

## 법제처 API 설정

1. [공공데이터포털](https://www.data.go.kr) 접속
2. 회원가입 및 로그인
3. "국가법령정보센터_법령" API 신청
4. 승인 후 발급된 API Key를 `config.js`에 설정

## 사용 방법

### 1. 법령 검색 및 모니터링 추가

1. "법령 검색" 탭에서 법령명 또는 키워드로 검색
2. 검색 결과에서 법령 클릭하여 상세 내용 확인
3. "모니터링 추가" 버튼 클릭

### 2. 키워드 등록

1. "키워드 관리" 탭에서 모니터링할 키워드 등록
2. 키워드, 카테고리, 설명 입력 후 추가

### 3. 변경사항 확인

1. "변경사항" 탭에서 "변경사항 확인" 버튼 클릭
2. 자동으로 등록된 법령의 변경사항 감지
3. 미검토 변경사항을 확인하고 검토 완료 처리

### 4. 조치사항 관리

1. 변경사항에서 "조치사항 생성" 클릭
2. 제목, 설명, 우선순위, 담당자, 마감일 입력
3. 조치사항 진행 상태 관리 (대기 → 진행중 → 완료)

## 자동 모니터링

시스템은 5분마다 자동으로 대시보드를 새로고침합니다. 
더 빈번한 업데이트가 필요한 경우 `config.js`의 `AUTO_REFRESH_INTERVAL` 값을 조정하세요.

## 주의사항

- 법제처 API는 호출 횟수 제한이 있을 수 있습니다.
- CORS 문제로 인해 브라우저에서 직접 법제처 API를 호출할 수 없을 수 있습니다.
- 필요시 서버사이드 프록시를 구현해야 할 수 있습니다.

## 트러블슈팅

### CORS 오류 발생 시

법제처 API 호출 시 CORS 오류가 발생할 수 있습니다. 이 경우:

1. 브라우저 확장 프로그램(CORS Unblock 등) 사용
2. 서버사이드 프록시 구현 (Node.js, Python 등)
3. Render에서 서버 배포 후 프록시 사용

### Supabase 연결 오류

1. `config.js`의 URL과 API Key가 정확한지 확인
2. Supabase 프로젝트가 활성 상태인지 확인
3. RLS (Row Level Security) 정책이 올바르게 설정되었는지 확인

## 라이선스

MIT License

## 문의

프로젝트 관련 문의사항은 이슈를 등록해주세요.
