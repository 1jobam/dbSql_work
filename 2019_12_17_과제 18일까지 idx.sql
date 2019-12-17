-- 12.18�ϱ��� ����

SELECT
    MAX(DECODE(d, 1, dt)) �Ͽ���, MAX(DECODE(d, 2, dt)) ������, MAX(DECODE(d, 3, dt)) ȭ����,
    MAX(DECODE(d, 4, dt)) ������, MAX(DECODE(d, 5, dt)) �����, MAX(DECODE(d, 6, dt)) �ݿ���, MAX(DECODE(d, 7, dt)) �����
FROM
    (SELECT 
            TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1) dt,
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1), 'D') d,
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL), 'IW') iw
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD'))
GROUP BY dt - (d-1)
ORDER BY dt - (d-1);