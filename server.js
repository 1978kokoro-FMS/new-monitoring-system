// CORS 프록시 서버
// 법제처 API CORS 문제 해결을 위한 간단한 프록시 서버

const express = require('express');
const cors = require('cors');
const axios = require('axios');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;

// CORS 설정
app.use(cors());
app.use(express.json());

// 정적 파일 제공
app.use(express.static(path.join(__dirname)));

// 법제처 API 프록시 엔드포인트
app.get('/api/law/search', async (req, res) => {
    try {
        const { query, type = 'lawNm' } = req.query;
        
        if (!query) {
            return res.status(400).json({ error: '검색어를 입력해주세요.' });
        }

        const LAW_API_KEY = process.env.LAW_API_KEY || 'lawmonitor2025';
        const apiUrl = 'https://www.law.go.kr/DRF/lawSearch.do';
        
        const params = {
            OC: LAW_API_KEY,
            target: 'law',
            type: 'XML',
            query: query
        };

        const response = await axios.get(apiUrl, { params });
        
        res.set('Content-Type', 'application/xml');
        res.send(response.data);

    } catch (error) {
        console.error('법령 검색 오류:', error.message);
        res.status(500).json({ 
            error: '법령 검색 중 오류가 발생했습니다.',
            details: error.message 
        });
    }
});

// 법령 상세 조회 프록시
app.get('/api/law/detail/:lawId', async (req, res) => {
    try {
        const { lawId } = req.params;
        
        const LAW_API_KEY = process.env.LAW_API_KEY || 'lawmonitor2025';
        const apiUrl = 'https://www.law.go.kr/DRF/lawService.do';
        
        const params = {
            OC: LAW_API_KEY,
            target: 'law',
            type: 'XML',
            MST: lawId
        };

        const response = await axios.get(apiUrl, { params });
        
        res.set('Content-Type', 'application/xml');
        res.send(response.data);

    } catch (error) {
        console.error('법령 상세 조회 오류:', error.message);
        res.status(500).json({ 
            error: '법령 상세 조회 중 오류가 발생했습니다.',
            details: error.message 
        });
    }
});

// 모든 라우트를 index.html로 리다이렉트 (SPA)
app.get('*', (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));
});

app.listen(PORT, () => {
    console.log(`법령 모니터링 시스템이 포트 ${PORT}에서 실행 중입니다.`);
    console.log(`http://localhost:${PORT}`);
});
