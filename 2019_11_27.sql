za-- ( condition �ǽ� cond 3)
-- users ���̺��� �̿��Ͽ� reg_dt�� ���� ���� �ǰ����� ���� ��������� ��ȸ�ϴ� ������ �ۼ��ϼ���.
-- ( ������ �������� �ϳ� ���⼭�� reg_dt�� �������� �Ѵ�.)

SELECT a.userid, a.usernm, a.liias,
        DECODE( mod(a.yyyy, 2), mod(a.this_YYYY, 2), '�ǰ��������', '�ǰ����� ����') contacttotocdotr
FROM 
(SELECT userid, usernm, alias, TO_CHAR(reg_dt, 'YYYY') yyyy,
    TO_CHAR(sysdate, 'yyyy') this_yyyy
FROM users;) a;

-- GROUP FUNCTION
-- Ư�� �÷��̳�, ǥ���� �������� �������� ���� ������ ����� ����
-- count - �Ǽ�, sum - �հ�, avg - ���, max - �ִ밪, min - �ּҰ�
-- ��ü ������ ������� (14���� -> 1��)
-- ���� ���� �޿�
desc emp;
SELECT MAX(sal) max_sal -- ���� ���� �޿�
    , MIN(sal) min_sal -- ���� ���� �޿�
    , ROUND(AVG(sal), 2) avg_sal  -- �� ������ �޿� ���
    , SUM(sal) sum_sal -- �� ������ �޿� �հ�
    , COUNT(sal) count_sal -- �޿� �Ǽ�(null�� �ƴ� ���̸� 1��)
    , COUNT(mgr) count_mgr -- ������ ������ �Ǽ�(KING�� ��� MGR�� ����)
    , COUNT(*) count_row -- Ư�� �÷��� �Ǽ��� �ƴ϶� ���� ������ �˰� ������
FROM emp;

SELECT *
FROM emp;

-- �μ���ȣ �� �׷��Լ� ����
SELECT deptno
    , MAX(sal) max_sal -- �μ����� ���� ���� �޿�
    , MIN(sal) min_sal -- �μ����� ���� ���� �޿�
    , ROUND(AVG(sal), 2) avg_sal  -- �μ����� �� ������ �޿� ���
    , SUM(sal) sum_sal -- �μ����� �� ������ �޿� �հ�
    , COUNT(sal) count_sal -- �μ��� �޿� �Ǽ�(null�� �ƴ� ���̸� 1��)
    , COUNT(mgr) count_mgr -- �μ� ������ ������ �Ǽ�(KING�� ��� MGR�� ����)
    , COUNT(*) count_row -- �μ��� �������� (Ư�� �÷��� �Ǽ��� �ƴ϶� ���� ������ �˰� ������)
FROM emp
GROUP BY deptno;

SELECT deptno, ename
    , MAX(sal) max_sal -- �μ����� ���� ���� �޿�
    , MIN(sal) min_sal -- �μ����� ���� ���� �޿�
    , ROUND(AVG(sal), 2) avg_sal  -- �μ����� �� ������ �޿� ���
    , SUM(sal) sum_sal -- �μ����� �� ������ �޿� �հ�
    , COUNT(sal) count_sal -- �μ��� �޿� �Ǽ�(null�� �ƴ� ���̸� 1��)
    , COUNT(mgr) count_mgr -- �μ� ������ ������ �Ǽ�(KING�� ��� MGR�� ����)
    , COUNT(*) count_row -- �μ��� �������� (Ư�� �÷��� �Ǽ��� �ƴ϶� ���� ������ �˰� ������)
FROM emp
GROUP BY deptno, ename;


--SELECT ������ GROUP BY ���� ǥ���� �÷� �̿��� �÷��� �� �� ����.
--�������� ������ ���� ����(�������� ���� ������ �Ѱ��� �����ͷ� �׷���)
--�� ���������� ��������� SELECT ���� ǥ���� ����
SELECT deptno, 'te', 1
    , MAX(sal) max_sal -- �μ����� ���� ���� �޿�
    , MIN(sal) min_sal -- �μ����� ���� ���� �޿�
    , ROUND(AVG(sal), 2) avg_sal  -- �μ����� �� ������ �޿� ���
    , SUM(sal) sum_sal -- �μ����� �� ������ �޿� �հ�
    , COUNT(sal) count_sal -- �μ��� �޿� �Ǽ�(null�� �ƴ� ���̸� 1��)
    , COUNT(mgr) count_mgr -- �μ� ������ ������ �Ǽ�(KING�� ��� MGR�� ����)
    , COUNT(*) count_row -- �μ��� �������� (Ư�� �÷��� �Ǽ��� �ƴ϶� ���� ������ �˰� ������)
FROM emp
GROUP BY deptno;

-- �׷��Լ������� NULL �÷��� ��꿡�� ���ܵȴ�.
-- emp ���̺��� comm�÷��� null�� �ƴ� �����ʹ� 4���� ����, 9���� NULL)
SELECT COUNT(comm) count_comm, -- NULL�� �ƴѰ��� ���� 4
        SUM(sal + comm) tot_sal_sum,
        SUM(sal + NVL(comm, 0)) tot_sal_sum2,
        SUM(comm) sum_comm, -- NULL���� ����, 300 + 500 + 1400 + 0 = 2200
        SUM(sal) sum_sal
FROM emp;

--WHERE ������ GROUP �Լ��� ǥ�� �� �� ����.
--1. �μ��� �ִ� �޿�
--2. �μ��� �ִ� �޿� ���� 3000�� �Ѵ� �ุ ���ϱ�
--deptno, �ִ�޿�
SELECT 
    deptno,
    MAX(SAL) m_sal --ORA-00934 WHERE ������ GROUP �Լ��� �� �� ����.
FROM emp
GROUP BY deptno
HAVING MAX(sal) >= 3000;

-- group function �ǽ� grp 1)
-- emp ���̺��� �̿��Ͽ� ������ ���Ͻÿ�
-- 1. ������ ���� ���� �޿�
-- 2. ������ ���� ���� �޿�
-- 3. ������ �޿� ���
-- 4. ������ �޿� ��
-- 5. ������ �޿��� �ִ� ������ ��(null����)
-- 6. ������ ����ڰ� �ִ� ������ ��(null����)
-- 7. ��ü ������ ��

SELECT 
    MAX(sal) max_sal,
    MIN(sal) min_sal,
    ROUND(AVG(sal), 2) avg_sal,
    SUM(sal) sum_sal,
    count(sal) count_sal,
    count(mgr) count_mgr,
    count(*) count_all
FROM emp;

-- (group function �ǽ� grp 2)
--emp ���̺��� �̿��Ͽ� ������ ���Ͻÿ�
-- �μ����� ������ ���� ���� �޿�
-- �μ����� ������ ���� ���� �޿�
-- �μ����� ������ �޿� ���(�Ҽ��� 2�ڸ�����)
-- �μ����� ������ �޿� ��
-- �μ��� ������ �޿��� �ִ� ������ ��(null ����)
-- �μ��� ������ ����ڰ� �ִ� ������ ��(null ����)
-- �μ��� �����Ǽ�
SELECT 
    MAX(sal) max_sal,
    MIN(sal) min_sal,
    ROUND(AVG(sal), 2) avg_sal,
    SUM(sal) sum_sal,
    COUNT(sal) count_sal,
    COUNT(mgr) count_mgr,
    COUNT (*) count_all
FROM emp
GROUP BY deptno;

-- (group function �ǽ� grp 3)
-- emp ���̺��� �̿��Ͽ� ������ ���Ͻÿ�.
-- grp2���� �ۼ��� ������ Ȱ���Ͽ�
-- deptno ��� �μ����� ���ü� �ֵ��� �����Ͻÿ�.

select * from emp;

SELECT 
    decode(deptno, 10, 'ACCOUNTING', 20, 'RESEARCH', 30, 'SALSE') DNAME,
    MAX(sal) max_sal,
    MIN(sal) min_sal,
    ROUND(AVG(sal), 2) avg_sal,
    SUM(sal) sum_sal,
    COUNT(sal) count_sal,
    COUNT(mgr) count_mgr,
    COUNT (*) count_all
FROM emp
GROUP BY deptno
order by deptno;

-- ( Group funtion �ǽ� grp4 )
-- emp ���̺��� �̿��Ͽ� ������ ���Ͻÿ�
-- ������ �Ի� ������� ����� ������ �Ի��ߴ��� ��ȸ�ϴ� ������ �ۼ��ϼ���.

SELECT TO_CHAR(hiredate, 'yyyymm') HIRE_YYYYMM, count(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'yyyymm');

SELECT hire_yyyymm, count(*) FROM
(SELECT TO_CHAR(hiredate, 'yyyymm') hire_yyyymm FROM emp)
GROUP BY hire_yyyymm;

-- ( group function �ǽ� grp 5 )
-- emp���̺��� �̿��Ͽ� ������ ���Ͻÿ�
-- ������ �Ի� �⺰�� ����� ������ �Ի��ߴ��� ��ȸ�ϴ� ������ �ۼ��ϼ���
SELECT TO_CHAR(hiredate, 'yyyy') hire_yyyy, count(*) cnt
FROM emp
group by TO_CHAR(hiredate, 'yyyy');

--grp 6
-- ( group function �ǽ� grp 6 )
-- ȸ�翡 �����ϴ� �μ��� ������ ����� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�
SELECT count(*) cnt
FROM dept;

--grp 7
-- ( group function �ǽ� grp 7 )
-- ������ ���� �μ��� ������ ��ȸ�ϴ� ������ �ۼ��Ͻÿ�
-- (emp ���̺� ���)
SELECT count(deptno) cnt FROM (SELECT deptno FROM emp GROUP BY deptno)a;

SELECT count(count(*)) cnt FROM emp GROUP BY deptno;

SELECT COUNT(DISTINCT deptno) cnt FROM emp;


-- JOIN
-- 1. ���̺� �������� (�÷� �߰�)
-- 2. �߰��� �÷��� ���� update
--dname �÷��� emp ���̺� �߰�
desc emp;
desc dept;
-- �÷��߰�(dname, varchar2 (14))
ALTER TABLE emp ADD (dname VARCHAR2(14));
desc emp;

SELECT * FROM emp;

update emp SET dname = 
    CASE
        WHEN deptno = 10 THEN 'ACCOUNTING'
        WHEN deptno = 20 THEN 'RESEARCH'
        WHEN deptno = 30 THEN 'SALES'
    END
where dname is null;

commit;

-- SAES --> MARKET SALES
-- �� 6���� ������ ������ �ʿ��ϴ�.
-- ���� �ߺ��� �ִ� ����(����������)
UPDATE emp SET dname = 'MARKET SALES'
where DNAME = 'SALES';

select * from emp;

-- emp ���̺�, dept ���̺� ����
SELECT ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;