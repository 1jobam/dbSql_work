-- 12.18일까지 과제

SELECT
    MIN(NVL(DECODE(d, 1, dt), dt - d + 1)) 일, MIN(NVL(DECODE(d, 2, dt), dt - d + 2)) 월, MIN(NVL(DECODE(d, 3, dt), dt - d + 3)) 화,
    MIN(NVL(DECODE(d, 4, dt), dt - d + 4)) 수, MIN(NVL(DECODE(d, 5, dt), dt - d + 5)) 목, MIN(NVL(DECODE(d, 6, dt), dt - d + 6)) 금, MIN(NVL(DECODE(d, 7, dt), dt - d + 7)) 토
FROM
    (SELECT 
            TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1) dt,
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1), 'D') d,
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL), 'IW') iw
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD'))
    GROUP BY dt - (d - 1)
    ORDER BY dt - (d - 1);
