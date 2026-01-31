-- 법령 모니터링 시스템 데이터베이스 스키마
-- Supabase SQL Editor에서 실행하세요

-- 1. 법령 정보 테이블
CREATE TABLE IF NOT EXISTS laws (
    id BIGSERIAL PRIMARY KEY,
    law_id VARCHAR(50) UNIQUE NOT NULL,
    law_name TEXT NOT NULL,
    law_type VARCHAR(50),
    ministry VARCHAR(100),
    enacted_date DATE,
    content TEXT,
    last_updated TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. 모니터링 키워드 테이블
CREATE TABLE IF NOT EXISTS monitoring_keywords (
    id BIGSERIAL PRIMARY KEY,
    keyword TEXT NOT NULL,
    category VARCHAR(100),
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    created_by VARCHAR(100)
);

-- 3. 법령 변경 이력 테이블
CREATE TABLE IF NOT EXISTS law_changes (
    id BIGSERIAL PRIMARY KEY,
    law_id VARCHAR(50) REFERENCES laws(law_id),
    change_type VARCHAR(50), -- 'NEW', 'AMENDED', 'REPEALED'
    change_date DATE,
    change_content TEXT,
    previous_content TEXT,
    detected_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    is_reviewed BOOLEAN DEFAULT FALSE,
    reviewed_by VARCHAR(100),
    reviewed_at TIMESTAMP WITH TIME ZONE
);

-- 4. 조치 사항 테이블
CREATE TABLE IF NOT EXISTS action_items (
    id BIGSERIAL PRIMARY KEY,
    law_change_id BIGINT REFERENCES law_changes(id),
    title TEXT NOT NULL,
    description TEXT,
    priority VARCHAR(20), -- 'HIGH', 'MEDIUM', 'LOW'
    status VARCHAR(20) DEFAULT 'PENDING', -- 'PENDING', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED'
    assigned_to VARCHAR(100),
    due_date DATE,
    completed_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    created_by VARCHAR(100),
    notes TEXT
);

-- 5. 모니터링 로그 테이블
CREATE TABLE IF NOT EXISTS monitoring_logs (
    id BIGSERIAL PRIMARY KEY,
    log_type VARCHAR(50), -- 'API_CALL', 'ERROR', 'CHANGE_DETECTED'
    message TEXT,
    details JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 인덱스 생성
CREATE INDEX IF NOT EXISTS idx_laws_law_id ON laws(law_id);
CREATE INDEX IF NOT EXISTS idx_laws_active ON laws(is_active);
CREATE INDEX IF NOT EXISTS idx_law_changes_law_id ON law_changes(law_id);
CREATE INDEX IF NOT EXISTS idx_law_changes_reviewed ON law_changes(is_reviewed);
CREATE INDEX IF NOT EXISTS idx_action_items_status ON action_items(status);
CREATE INDEX IF NOT EXISTS idx_monitoring_keywords_active ON monitoring_keywords(is_active);

-- RLS (Row Level Security) 활성화
ALTER TABLE laws ENABLE ROW LEVEL SECURITY;
ALTER TABLE monitoring_keywords ENABLE ROW LEVEL SECURITY;
ALTER TABLE law_changes ENABLE ROW LEVEL SECURITY;
ALTER TABLE action_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE monitoring_logs ENABLE ROW LEVEL SECURITY;

-- 모든 사용자가 읽기 가능하도록 설정
CREATE POLICY "Enable read access for all users" ON laws FOR SELECT USING (true);
CREATE POLICY "Enable read access for all users" ON monitoring_keywords FOR SELECT USING (true);
CREATE POLICY "Enable read access for all users" ON law_changes FOR SELECT USING (true);
CREATE POLICY "Enable read access for all users" ON action_items FOR SELECT USING (true);
CREATE POLICY "Enable read access for all users" ON monitoring_logs FOR SELECT USING (true);

-- 모든 사용자가 쓰기 가능하도록 설정 (실제 운영시에는 인증 추가 필요)
CREATE POLICY "Enable insert for all users" ON laws FOR INSERT WITH CHECK (true);
CREATE POLICY "Enable insert for all users" ON monitoring_keywords FOR INSERT WITH CHECK (true);
CREATE POLICY "Enable insert for all users" ON law_changes FOR INSERT WITH CHECK (true);
CREATE POLICY "Enable insert for all users" ON action_items FOR INSERT WITH CHECK (true);
CREATE POLICY "Enable insert for all users" ON monitoring_logs FOR INSERT WITH CHECK (true);

CREATE POLICY "Enable update for all users" ON laws FOR UPDATE USING (true);
CREATE POLICY "Enable update for all users" ON monitoring_keywords FOR UPDATE USING (true);
CREATE POLICY "Enable update for all users" ON law_changes FOR UPDATE USING (true);
CREATE POLICY "Enable update for all users" ON action_items FOR UPDATE USING (true);
CREATE POLICY "Enable update for all users" ON monitoring_logs FOR UPDATE USING (true);

CREATE POLICY "Enable delete for all users" ON laws FOR DELETE USING (true);
CREATE POLICY "Enable delete for all users" ON monitoring_keywords FOR DELETE USING (true);
CREATE POLICY "Enable delete for all users" ON law_changes FOR DELETE USING (true);
CREATE POLICY "Enable delete for all users" ON action_items FOR DELETE USING (true);
CREATE POLICY "Enable delete for all users" ON monitoring_logs FOR DELETE USING (true);
