-- WITH
-- WHIH ����̸� AS (
--     ���� ����
-- )
-- SELECT *
-- FROM ����̸�

--deptno, avg(sal) avg_sal
--�ش� �μ��� �޿� ����� ��ü ������ �޿� ��պ��� ���� �μ��� ���� ��ȸ
SELECT deptno, ROUND(AVG(sal),2) avg_sal
FROM emp
GROUP BY deptno
HAVING AVG(sal) > (SELECT AVG(SAL) FROM emp);

--WHIH ���� ����Ͽ� ���� ������ �ۼ�
WITH dept_sal_avg AS(
    SELECT deptno, ROUND(AVG(sal),2) avg_sal
    FROM emp
    GROUP BY deptno),
    emp_sal_avg AS( SELECT AVG(SAL) avg_sal FROM emp )
SELECT *
FROM dept_sal_avg
WHERE avg_sal > (SELECT avg_sal FROM emp_sal_avg);


WITH test AS(
    SELECT 1, 'TEST' FROM DUAL UNION ALL
    SELECT 2, 'TEST2' FROM DUAL UNION ALL
    SELECT 3, 'TEST3' FROM DUAL)
SELECT *
FROM test;

-- ��������
-- �޷¸����
-- CONNECT BY LEVEL <= N
-- ���̺��� ROW �Ǽ��� N��ŭ �ݺ��Ѵ�
-- CONNECT BY LEVEL ���� ����� ����������
-- SELECT ������ LEVEL �̶�� Ư�� �÷��� ����� �� �ִ�.
-- ������ ǥ���ϴ� Ư�� �÷����� 1���� �����ϸ� ROWNUM�� �����ϳ�
-- ���� ���Ե� START WITH, CONNECT BY ������ �ٸ� ���� ���� �ȴ�.

--2019�� 11���� 30�ϱ��� ����
--201911
--���� + ���� = ������ŭ �̷��� ����
--201911 --> �ش����� ��¥�� ���� ���� ���� �ϴ°�??
-- 1-��, 2-��.....7-��
-- �Ͽ����̸� ��¥, .... ȭ�����̸� ��¥, .... ������̸� ��¥
SELECT
    MIN(DECODE(d, 1, dt - 7)) �Ͽ���, MIN(DECODE(d, 2, dt - 7)) ������, MIN(DECODE(d, 3, dt - 7)) ȭ����,
    MIN(DECODE(d, 4, dt - 7)) ������, MIN(DECODE(d, 5, dt - 7)) �����, MIN(DECODE(d, 6, dt - 7)) �ݿ���, MIN(DECODE(d, 7, dt - 7)) �����
FROM
    (SELECT 
            TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1) dt,
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1), 'D') d,
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL), 'IW') iw
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD') + 7)
GROUP BY dt - (d-1)
ORDER BY dt - (d-1);


-- ����(�ǽ� calendar1)
-- �޷¸���� ���� ������.sql�� �Ϻ� ���� �����͸� �̿��Ͽ�
-- 1~6���� ���� ���� �����͸� ������ ���� ���ϼ���

--�����Ѱ�
SELECT * FROM

(SELECT sum(sales) JAN
FROM sales
WHERE dt like '%/01/%'),

(SELECT sum(sales) FEB
FROM sales
WHERE dt like '%/02/%'),

(SELECT nvl(sum(sales), 0) MAT
FROM sales
WHERE dt like '%/03/%'),

(SELECT sum(sales) APR
FROM sales
WHERE dt like '%/04/%'),

(SELECT sum(sales) MAY
FROM sales
WHERE dt like '%/05/%'),

(SELECT sum(sales) JUN
FROM sales
WHERE dt like '%/06/%');


--����

SELECT /*1�� �÷�, 2�� �÷�,*/
        NVL(MIN(DECODE(mm, '01', sales_sum)), 0) JAN, NVL(MIN(DECODE(mm, '02', sales_sum)), 0) FEB,
        NVL(MIN(DECODE(mm, '03', sales_sum)), 0) MAR, NVL(MIN(DECODE(mm, '04', sales_sum)), 0) APR,
        NVL(MIN(DECODE(mm, '05', sales_sum)), 0) MAY, NVL(MIN(DECODE(mm, '06', sales_sum)), 0) JUN
FROM
(SELECT TO_CHAR(dt, 'MM') mm, SUM(sales) sales_sum
FROM sales
GROUP BY TO_CHAR(dt, 'MM'));


--PRIOR --> �̹� ���� �༮ (������)
SELECT dept_h.*, LEVEL
FROM dept_h
START WITH deptcd = 'dept0' --�������� deptcd = 'dept0' --> XXȸ��(�ֻ������) ����.
CONNECT BY PRIOR deptcd = p_deptcd
;
/* �������
    dept0(XXȸ��)
        dept0_00(�����κ�)
            dept0_00_0(��������)
        dept0_01(������ȹ��)
            dept0_01_0(��ȹ��)
                dept0_00_0_0(��ȹ��Ʈ)
        dept0_02(�����ý��ۺ�)
            dept0_02_0(����1��)
            dept0_02_1(����2��)













