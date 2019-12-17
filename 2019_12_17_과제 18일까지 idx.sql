-- 12.18일까지 과제

SELECT
    MAX(DECODE(d, 1, dt)) 일요일, MAX(DECODE(d, 2, dt)) 월요일, MAX(DECODE(d, 3, dt)) 화요일,
    MAX(DECODE(d, 4, dt)) 수요일, MAX(DECODE(d, 5, dt)) 목요일, MAX(DECODE(d, 6, dt)) 금요일, MAX(DECODE(d, 7, dt)) 토요일
FROM
    (SELECT 
            TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1) dt,
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1), 'D') d,
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL), 'IW') iw
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD'))
GROUP BY dt - (d-1)
ORDER BY dt - (d-1);