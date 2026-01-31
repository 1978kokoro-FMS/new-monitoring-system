// 법령 모니터링 시스템 설정
const CONFIG = {
    // Supabase 설정
    SUPABASE_URL: 'https://qiwqcylerloqxdqupgbk.supabase.co',
    SUPABASE_KEY: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFpd3FjeWxlcmxvcXhkcXVwZ2JrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk0MTQxMzMsImV4cCI6MjA3NDk5MDEzM30.haR8oLJsgp_5r-EisNqxI8ASHrdh87hiAixfMt5TG6U',
    
    // 법제처 API 설정
    LAW_API_KEY: 'lawmonitor2025',
    LAW_API_BASE_URL: 'https://www.law.go.kr/DRF',
    
    // 애플리케이션 설정
    APP_NAME: '법령 모니터링 시스템',
    ITEMS_PER_PAGE: 20,
    AUTO_REFRESH_INTERVAL: 300000, // 5분 (밀리초)
};
