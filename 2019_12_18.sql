--2019.12.17 ����

SELECT
    MIN(NVL(DECODE(d, 1, dt), dt - d + 1)) ��, MIN(NVL(DECODE(d, 2, dt), dt - d + 2)) ��, MIN(NVL(DECODE(d, 3, dt), dt - d + 3)) ȭ,
    MIN(NVL(DECODE(d, 4, dt), dt - d + 4)) ��, MIN(NVL(DECODE(d, 5, dt), dt - d + 5)) ��, MIN(NVL(DECODE(d, 6, dt), dt - d + 6)) ��, MIN(NVL(DECODE(d, 7, dt), dt - d + 7)) ��
FROM
    (SELECT 
            TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1) dt,
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1), 'D') d,
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL), 'IW') iw
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD'))
    GROUP BY dt - (d - 1)
    ORDER BY dt - (d - 1);
    
-- 201910 : 35, ù���� �Ͽ���: 20190929, ���������� �����: 20191102
-- ��(1), ��(2), ȭ(3), ��(4), ��(5), ��(6), ��(7)
SELECT ldt - fdt + 1
FROM
(SELECT LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) dt,

        LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) + 
        7 - TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'D') ldt,
        
        TO_DATE(:yyyymm, 'YYYYMM') -
        (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') - 1) fdt
        
FROM dual);



--TEST
SELECT LAST_DAY(SYSDATE) dt,
        LAST_DAY(SYSDATE) + 
        7 - TO_CHAR(LAST_DAY(SYSDATE), 'D') ldt
FROM dual;



-- ���� ����
SELECT
    MIN(DECODE(d, 1, dt)) ��, MIN(DECODE(d, 2, dt)) ��, MIN(DECODE(d, 3, dt)) ȭ,
    MIN(DECODE(d, 4, dt)) ��, MIN(DECODE(d, 5, dt)) ��, MIN(DECODE(d, 6, dt)) ��, MIN(DECODE(d, 7, dt)) ��
FROM
    (SELECT 
            TO_DATE(:yyyymm, 'YYYYMM') - (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') - 1) +(LEVEL -1) dt,
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') - (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') - 1) + (LEVEL - 1), 'D') d,
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') - (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') - 1) + (LEVEL), 'IW') iw
    FROM dual
    CONNECT BY LEVEL <= (SELECT ldt - fdt + 1
                        FROM
                        (SELECT LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) dt,
                        
                        LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) + 
                        7 - TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'D') ldt,
                        
                        TO_DATE(:yyyymm, 'YYYYMM') -
                        (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') - 1) fdt
                        
                        FROM dual)))
GROUP BY dt - (d - 1)
ORDER BY dt - (d - 1);

-- �������� ����
SELECT dept_h.*, LEVEL, LPAD(' ', (LEVEL - 1) * 3) || deptnm
FROM dept_h
START WITH deptcd = 'dept0' --�������� deptcd = 'dept0' --> XXȸ��(�ֻ������) ����.
CONNECT BY PRIOR deptcd = p_deptcd;

SELECT LPAD('XXȸ��', 15, '*'),
        LPAD('XXȸ��', 15)
FROM dual;
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
*/

--  �������� ( �ǽ� h_2 )
SELECT LEVEL AS LV, deptcd, deptnm, LPAD(' ', (LEVEL - 1) * 3) || deptnm AS P_DEPTCD
FROM dept_h
START WITH deptcd = 'dept0_02'
CONNECT BY PRIOR deptcd = p_deptcd;

-- ��������(dept0_00_0)�� �������� ����� �������� �ۼ�
--�ڱ� �μ��� �θ� �μ��� ������ �Ѵ�.
-- ��������
-- �����
-- PRIOR�� �ѹ��� ���� �ʾƵ��ȴ�.
-- CONNECT BY �ڿ� �� PRIOR �� ���ʿ�� ����.
SELECT dept_h.*, LEVEL
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY deptcd = PRIOR p_deptcd AND PRIOR deptnm LIKE '������%'; -- �䷱��ĵ� ����

-- �����ϱ�
-- ���� ������ ���÷����� ���밡���Ѱ�?
SELECT *
FROM tab a, tab_b
WHERE tab_a.a = tab_b.a
AND tab_a.b = tab_b.b;

-- �������� ( ����� �ǽ� h_3 )
SELECT deptcd, LPAD(' ', (LEVEL - 1) * 4) || deptnm AS deptnm, p_deptcd
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY deptcd = PRIOR p_deptcd;

-- �������� ( �ǽ� h_4 )
-- ���������� ����.sql�� �̿��Ͽ� ���̺��� �����ϰ� ������ ����
-- ����� �������� ������ �ۼ� �Ͻÿ�
-- s.id : ��� ���̵�
-- ps_id : �θ� ��� ���̵�
-- value : ��尪
SELECT LPAD(' ', (LEVEL -1) * 4) || s_id AS s_id, value
FROM h_sum
START WITH s_id = '0'
CONNECT BY PRIOR s_id = ps_id;

-- �������� ( �ǽ� h_5 )
-- ���������� ��ũ��Ʈ.sql�� �̿��Ͽ� ���̺��� �����ϰ� ������ ����
-- ����� �������� ������ �ۼ� �Ͻÿ�
-- org_cd : �μ��ڵ�
-- parent_org_cd : �θ� �μ��ڵ�
-- no_emp : �μ� �ο���
select * from no_emp;

SELECT LPAD(' ', (LEVEL-1) * 4) || ORG_CD AS ORG_CD, NO_EMP
FROM no_emp
START WITH ORG_CD = 'XXȸ��'
CONNECT BY PRIOR ORG_CD = PARENT_ORG_CD;

-- pruning branch (����ġ��)
-- ���� ������ �������
-- FROM --> START WITH ~ CONNECT BY --> WHERE
-- ������ CONNECT BY ���� ����� ���
-- . ���ǿ� ���� ���� ROW�� ������ �ȵǰ� ����
-- ������ WHERE ���� ����� ���
-- . START WITH ~ CONNECT DY ���� ���� �������� ���� �����
-- WHERE ���� ����� ��� ���� �ش��ϴ� �����͸� ��ȸ

-- �ֻ��� ��忡�� ��������� Ž��
SELECT *
FROM dept_h
WHERE deptcd = 'dept0';

-- CONNECT BY���� deptnm != '������ȹ��' ������ ����� ���
SELECT *
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = P_deptcd AND deptnm != '������ȹ��';


-- WHERE ���� deptnm != '������ȹ��' ������ ����� ���
-- ���������� �����ϰ��� ���� ����� WHERE �� ������ ����
SELECT *
FROM dept_h
WHERE deptnm != '������ȹ��'
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = P_deptcd;

--���� �������� ��� ������ Ư�� �Լ�
-- CONNECT_BY_ROOT(col) ���� �ֻ��� row�� col ���� �� ��ȸ
-- SYS_CONNECT_BY_PATH(col, ������) : �ֻ��� row���� ���� row���� col����
-- �����ڷ� �������� ���ڿ� (EX : XXȸ�� - �����κε�������)
-- CONNECT_BY_ISLEAF : �ش� ROW�� ������ �������
-- leaf node : 1, node : 0
SELECT deptcd, LPAD(' ', (LEVEL - 1) * 4) || deptnm,
    CONNECT_BY_ROOT(deptnm) c_root,
    LTRIM(SYS_CONNECT_BY_PATH(deptnm, '-'), '-') sys_path,
    CONNECT_BY_ISLEAF isleaf
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = P_deptcd;

-- �������� ( �Խñ� ���������� ���� �ڷ�.sql, �ǽ� h6 )
-- �Խñ��� �����ϴ� board_test ���̺��� �̿��Ͽ� ���� ������ �ۼ� �Ͻÿ�.
select * from board_test;

SELECT seq, LPAD(' ', (LEVEL - 1) * 4) || title title
FROM board_test
START WITH PARENT_SEQ is null
CONNECT BY PRIOR seq = parent_seq;

-- �������� ( �Խñ� ���������� ���� �ڷ�.sql, �ǽ� h7 )
select * from board_test;

SELECT SEQ, LPAD(' ', (LEVEL - 1) * 4) || title AS title
FROM board_test
START WITH PARENT_SEQ is null
CONNECT BY PRIOR seq = parent_seq
ORDER BY seq desc;

-- �������� ( �Խñ� ���������� ���� �ڷ�.sql, �ǽ� h8)
-- �ԽǱ��� ���� �ֽű��� �ֻ����� �´�. ���� �ֽű��� ������ ���� �Ͻÿ�
SELECT seq, LPAD(' ', (LEVEL - 1) * 4) || title AS title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY seq DESC;
