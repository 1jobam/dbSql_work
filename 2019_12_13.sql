SELECT *
FROM emp_test;

-- emp���̺� �����ϴ� �����͸� emp_test ���̺�� ����
-- ���� empno�� ������ �����Ͱ� �����ϸ�
-- ename update : ename || '_merge'
-- ����  empno�� ������ �����Ͱ� ���� ���� �������
-- emp���̺��� empno, ename emp_test �����ͷ� insert

--emp_test �����Ϳ��� ������ �����͸� ����
delete emp_test
WHERE empno >= 7788;


--emp ���̺��� 14���� �����Ͱ� ����
--emp_test ���̺��� ����� 7788���� ���� 7���� �����Ͱ� ����
--emp���̺��� �̿��Ͽ� emp_test ���̺��� merge�ϰ� �Ǹ�
--emp���̺��� �����ϴ� ���� (����� 7788���� ũ�ų� ���� ) 7��
--emp_test�� ���Ӱ� insert�� �� ���̰�
--emp, emp_test�� �����ȣ�� �����ϰ� �����ϴ� 7���� �����ʹ�
--(����� 7788���� ���� ����)ename�÷��� ename || '_modify'��
--������Ʈ�� �Ѵ�

/*
MERGE INTO ���̺��
USING ������� ���̺� | VIEW | SUBQUERY
ON * (���̺��� ��������� �������)
WHEN MATCHED THEN
    UPDATE .....
WHEN NOT MATCHED THEN
    INSERT .....
*/

MERGE INTO emp_test
USING emp
ON (emp.empno = emp_test.empno)
WHEN MATCHED THEN
    UPDATE SET ename = ename || '_mod'
WHEN NOT MATCHED THEN
    INSERT VALUES (emp.empno, emp.ename);
    
SELECT *
FROM emp_test;

-- emp_test ���̺� ����� 9999�� �����Ͱ� �����ϸ�
-- ename�� 'brown' ���� update
-- �������� ���� ��� empno, ename VALUES (9999, 'brown')���� insert
-- ���� �ó������� MERGE ������ Ȱ���Ͽ� �ѹ��� sql�� ����
-- :empno - 9999, :ename - 'brown'
MERGE INTO emp_test
USING dual
ON (emp_test.empno = :empno)
WHEN MATCHED THEN
    UPDATE SET ename = :ename || '_mod'
WHEN NOT MATCHED THEN
    INSERT VALUES (:empno, :ename);


SELECT *
FROM emp_test
WHERE empno = 9999;

-- ���� merge ������ ���ٸ� (** 2���� SQL�� �ʿ�)
-- 1. empno = 9999�� �����Ͱ� ���� �ϴ��� Ȯ��
-- 2-1. 1�����׿��� �����Ͱ� �����ϸ� UPDATE
-- 2-2. 1�����׿��� �����Ͱ� �������� ������ INSERT


-- �μ��� �հ�, ��ü�հ踦 ������ ���� ���Ϸ���?? (�ǽ� GROUP_AD1)
-- table:emp
SELECT deptno, SUM(sal) sal
FROM emp
GROUP BY deptno
UNION ALL
SELECT null, SUM(sal)
FROM emp;

--JOIN ������� Ǯ��
--emp ���̺��� 14�ǿ� �����͸� 28������ ����
-- ������(1 - 14, 2-14)�� �������� group by
-- ������ 1 : �μ���ȣ �������� 14 row
-- ������ 2 : ��ü 14 ROW
SELECT DECODE(b.rn, 1, emp.deptno, 2, null) deptno,
        SUM(emp.sal) sal
FROM emp, (SELECT ROWNUM rn
            FROM dept
            WHERE ROWNUM <= 2) b
GROUP BY DECODE(b.rn, 1, emp.deptno, 2, null)
ORDER BY DECODE(b.rn, 1, emp.deptno, 2, null);

-- Ǯ�� 2

SELECT DECODE(b.rn, 1, emp.deptno, 2, null) deptno,
        SUM(emp.sal) sal
FROM emp, (SELECT LEVEL rn FROM dual CONNECT BY LEVEL <= 2) b
GROUP BY DECODE(b.rn, 1, emp.deptno, 2, null)
ORDER BY DECODE(b.rn, 1, emp.deptno, 2, null);

--REPORT GROUP BY
--ROLLUP
--GROUP BY ROLLUP(col1 ....)
--ROLLUP ���� ����� �÷��� �����ʿ��� ���� ���� �����
--SUB GROUP�� �����Ͽ� �������� GROUP BY���� �ϳ��� SQL���� ���� �ǵ��� �Ѵ�
GROUP BY ROLLUP(job, deptno)
-- GROUP BY job, deptno
-- GROUP BY job
-- GROUP BY --> ��ü ���� ������� GROUP BY

--emp���̺��� �̿��Ͽ� �μ���ȣ��, ��ü ������ �޿����� ���ϴ� ������
--ROLLUP ����� �̿��Ͽ� �ۼ�
SELECT deptno, sum(sal) sal
FROM emp
GROUP BY ROLLUP (deptno);

-- EMP ���̺��� �̿��Ͽ� job, deptno �� sal+comm �հ�
--                      job �� sal_comm �հ�
--                      ��ü������ sal+comm �հ�
-- ROLLUP�� Ȱ���Ͽ� �ۼ�

SELECT job, deptno, sum(sal + NVL(comm, 0)) sal_sum
FROM emp
GROUP BY ROLLUP (job,deptno);
--GROUP BY job, deptno
--GROUP BY job
--GROUP BY --> ��ü  ROW���


--ROLLUP�� �÷� ������ ��ȸ ����� ������ ��ģ��.
GROUP BY ROLLUP (job,deptno);
--GROUP BY job, deptno
--GROUP BY job
--GROUP BY --> ��ü  ROW���

GROUP BY ROLLUP (job,deptno);
--GROUP BY deptno, job
--GROUP BY deptno
--GROUP BY --> ��ü  ROW���

-- ������ ����� �������� ������ �ۼ��Ͻÿ� ( �ǽ� GROUP_AD2 )
SELECT
    DECODE(GROUPING(job), 1, '�Ѱ�', job) job,
            deptno,
            SUM(sal + NVL(comm, 0)) sal
FROM emp
GROUP BY ROLLUP (job, deptno);

-- ������ ����� �������� ������ �ۼ��Ͻÿ� ( �ǽ� GROUP_AD2_1 )
-- 1���ذ�
SELECT
    DECODE(GROUPING(job), 1, '�Ѱ�', job) job,
            CASE
                WHEN deptno IS NULL AND job IS NULL THEN '��'
                WHEN deptno IS NULL AND job is NOT NULL THEN '�Ұ�'
                ELSE '' || deptno -- �Ǵ� TO_CHAR(deptno)
            END deptno,
            
            SUM(sal + NVL(comm, 0)) sal
FROM emp
GROUP BY ROLLUP (job, deptno);

-- ������ ����� �������� ������ �ۼ��Ͻÿ� ( �ǽ� GROUP_AD2_1 )
-- 2���ذ�
SELECT
    DECODE(GROUPING(job), 1, '�Ѱ�', job) job,
            DECODE(GROUPING(deptno), 1, DECODE(GROUPING(job), 1, '��', '�Ұ�'),deptno) deptno,
            SUM(sal + NVL(comm, 0)) sal
FROM emp
GROUP BY ROLLUP (job, deptno);

-- 3���ذ�
SELECT
    DECODE(GROUPING(job), 1, '�Ѱ�', job) job,
            DECODE(GROUPING(deptno) + GROUPING(job), 2, '��', 1, '�Ұ�', deptno) deptno,
            SUM(sal + NVL(comm, 0)) sal
FROM emp
GROUP BY ROLLUP (job, deptno);


-- �ǽ� GROUP_AD3
-- table : emp
-- ���� group by ���� �ѹ��� ���
SELECT deptno, job, SUM(sal + nvl(comm, 0)) sal
FROM emp
GROUP BY ROLLUP (deptno, job);

--UNION ALL�� ġȯ
SELECT deptno, job, SUM(sal + nvl(comm, 0)) sal
FROM emp
GROUP BY deptno, job
UNION ALL
SELECT deptno, null, SUM(sal + nvl(comm, 0)) sal
FROM emp
GROUP BY deptno
UNION ALL
SELECT null, null, SUM(sal + nvl(comm, 0)) sal
FROM emp
ORDER BY deptno;

-- �ǽ� GROUP_AD4
-- table : emp
-- ���� = ROLLUP ���
-- �μ���ȣ -> �μ���(dept ���̺�� join
select * from dept;
select * from emp;

SELECT dept.dname, emp.job, SUM(emp.sal + nvl(emp.comm, 0)) sal
FROM emp JOIN dept ON emp.deptno = dept.deptno
GROUP BY ROLLUP (dept.dname, emp.job)
ORDER BY dept.dname, sal desc;

-- �ǽ� GROUP_AD5
-- table : emp
-- ���� = ROLLUP ���
-- �μ���ȣ -> �μ���
-- ���� row�� ��� dname �÷��� "����"���� ǥ��

SELECT DECODE(GROUPING(dname), 1, '����', dname) dname, job, SUM(sal + nvl(comm, 0)) sal
FROM emp JOIN dept ON emp.deptno = dept.deptno
GROUP BY ROLLUP (dname, job)
ORDER BY dname, sal desc;

--���� 1
SELECT DECODE(GROUPING(dname), 1, '����', dname) dname, 
        DECODE(GROUPING(dname) + GROUPING(job), 2, '�Ѽ���', 1, '����', job)job, 
        SUM(sal + nvl(comm, 0)) sal
FROM emp JOIN dept ON emp.deptno = dept.deptno
GROUP BY ROLLUP (dname, job)
ORDER BY dname, sal desc;

--���� 2
SELECT DECODE(GROUPING(dname), 1, '����', dname) dname, 
            CASE
                WHEN dname IS NULL AND job IS NULL THEN '��'
                WHEN dname IS NULL AND job is NOT NULL THEN '��'
                ELSE '' || job -- �Ǵ� TO_CHAR(deptno)
            END job,
        SUM(sal + nvl(comm, 0)) sal
FROM emp JOIN dept ON emp.deptno = dept.deptno
GROUP BY ROLLUP (dname, job)
ORDER BY dname, sal desc;