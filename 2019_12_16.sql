--GROUPING SETS(col1, col2)
--������ ����� ����
--�����ڰ� GROUP BY�� ������ ���� ����Ѵ�.
--ROLLUP�� �޸� ���⼺�� ���� �ʴ´�.
--GROUPING SETS(col1, col2) = GROUPING SETS(col2, col1)

-- GROUP BY col1
--UNION ALL
--GROUP BY col2

--emp ���̺��� ������ job(����)�� �޿�(sal) + ��(comm)��,
--                    deptno(�μ�)  �޿�(sal) + ��(comm)��,
--���� ���(GROUP FUNCTION) : 2 ���� SQL �ۼ� �ʿ�(UNION / UNION ALL)
SELECT job, null deptno, sum(sal + nvl(comm, 0)) sal_comm_sum
FROM emp
GROUP BY job
UNION ALL
SELECT null job, deptno, sum(sal + nvl(comm,0)) sal_comm_sum
FROM emp
GROUP BY deptno;

--GROUPING SETS ������ �̿��Ͽ� ���� SQL�� ���տ����� ������� �ʰ�
--���̺��� �ѹ� �о ó��
SELECT job, deptno, SUM(sal + nvl(comm, 0)) sal_comm_sum
FROM emp
GROUP BY GROUPING SETS (job, deptno);

--job, deptno�� �׷����� �� sal+comm ��
--mgr�� �׷����� �� sal + comm ��
--����������� �ϸ� �Ʒ�����
-- GROUP BY job, deptno
-- UNION ALL
-- GROUP BY mgr
SELECT job, null mgr, deptno, SUM(sal + nvl(comm, 0)) sal
FROM emp
GROUP BY job, deptno
UNION ALL
SELECT null job, mgr, null deptno, SUM(sal + nvl(comm, 0)) sal
FROM emp
GROUP BY mgr;
-- �׷��� ������ ����� �Ʒ�����
-- --> GROUPING SETS((job, deptno), mgr)
SELECT job, deptno, mgr, SUM(sal + nvl(comm, 0)) sal_comm_sum,
    GROUPING(job), GROUPING(deptno), GROUPING(mgr)
FROM emp
GROUP BY GROUPING SETS((job, deptno), mgr);

--CUBE (col1, col2 ...)
-- ������ �÷��� ��� ������ �������� GROUP BY subset�� �����
--CUBE�� ������ �÷��� 2���� ��� : ������ ���� 4��
--CUBE�� ������ �÷��� 3���� ��� : ������ ���� 8��
--CUBE�� ������ �÷����� 2�� ������ �� ����� ������ ���� ������ �ȴ� (2^n)
--�÷��� ���ݸ� �������� ������ ������ ���ϱ޼������� �þ� ���� ������
--���� ��������� �ʴ´�

-- job, deptno�� �̿��Ͽ� CUBE ����
SELECT job, deptno, SUM(sal + nvl(comm, 0)) sal_comm_sum
FROM emp
GROUP BY CUBE(job, deptno);
--job, deptno
--1,   1     --> GROUP BY job, deptno
--1,   0     --> GROUP BY job
--0,   1     --> GROUP BY deptno
--0,   0     --> GROUP BY --emp ���̺��� ����࿡ ���� GROUP BY

-- GROUP BY ����
-- GROUP BY, ROLLUP, CUBE�� ���� ����ϱ�
-- ������ ������ �����غ��� ���� ����� ������ �� �ִ�.
-- GROUP BY job , rollup(detpno), cube(mgr)

SELECT job, deptno, mgr, SUM(sal + nvl(comm, 0)) sal
FROM emp
GROUP BY job, ROLLUP(deptno), CUBE(mgr); 

SELECT job, SUM(sal)
FROM emp
GROUP BY job;

-- �������� ADVANCED ( correlated subquery update - �ǽ� sub_a1)
-- dept���̺��� �̿��Ͽ� dept_test ���̺� ����
-- dept_test ���̺� empcnt (number) �÷� �߰�
-- subquery�� �̿��Ͽ� dept_test ���̺��� empcnt �÷��� �ش� �μ��� ���� update������ �ۼ��ϼ���.
select * from dept_test;

-- 1
CREATE TABLE dept_test AS
SELECT * FROM dept WHERE 1 = 1;

-- 2
ALTER TABLE dept_test ADD (empcnt NUMBER);

-- 3
UPDATE dept_test
SET empcnt = (SELECT COUNT(deptno)
                FROM emp
                WHERE emp.deptno = dept_test.deptno);
                
    
--�׽�Ʈ
SELECT dept.deptno, COUNT(dept.deptno)
FROM emp, dept 
WHERE emp.deptno = dept.deptno
GROUP BY dept.deptno;


-- �������� ADVANCED ( correlated subquery delete - �ǽ� sub_a2 )
-- dept ���̺��� �̿��Ͽ� dept_test ���̺� ����
-- dpet_test ���̺� �ű� ������ 2�� �߰�
-- emp ���̺��� �������� ������ ���� �μ� ���� �����ϴ� ������
-- ���������� �̿��Ͽ� �ۼ��ϼ���.
DROP TABLE dept_test;

-- 1
CREATE TABLE dept_test AS 
SELECT * FROM dept WHERE 1 = 1;

-- 2
INSERT INTO dept_test values(99, 'it1', 'daejeon');
INSERT INTO dept_test values(98, 'it2', 'daejeon');

-- 3
select * from dept_test;
select * from emp;

DELETE FROM dept_test
WHERE deptno NOT IN (SELECT deptno
                    FROM emp
                    WHERE emp.deptno = dept_test.deptno);

-- �׽�Ʈ
SELECT emp.deptno, dept_test.deptno
FROM emp, dept_test
WHERE emp.deptno = dept_test.deptno;


-- �������� ADVANCED ( correlated subquery delete - �ǽ� sub_a3 )
-- EMP ���̺��� �̿��Ͽ� EMP_TEST ���̺� ����
-- SUBQUERY�� �̿��Ͽ� emp_test ���̺��� ������ ���� �μ��� 
-- (SAL)��� �޿����� �޿��� ���� ������ �޿��� �� �޿����� 200��
-- �߰��ؼ� ������Ʈ �ϴ� ������ �ۼ��ϼ���.

DROP TABLE emp_test;
SELECT * FROM emp_test;
--1
CREATE TABLE emp_test AS
SELECT * FROM emp WHERE 1 = 1;


--2
SELECT * FROM emp_test;
ROLLBACK;

--����
UPDATE emp_test 
SET sal = sal + 200
WHERE sal < (SELECT ROUND(AVG(sal), 0) FROM emp_test);

--����
UPDATE emp_test 
SET sal = sal + 200
WHERE sal < (SELECT ROUND(AVG(sal), 2)
                FROM emp
                WHERE deptno = emp_test.deptno);


--�׽�Ʈ
SELECT emp_test.deptno, ROUND(AVG(emp_test.sal), 2) sal
FROM emp_test, emp
WHERE emp_test.deptno = emp.deptno
GROUP BY emp_test.deptno;


-- MERGE ������ �̿��� ������Ʈ
SELECT deptno, AVG(sal)
FROM emp_test
GROUP BY deptno;


MERGE INTO emp_test a
USING (SELECT deptno, AVG(sal) avg_sal
        FROM emp_test
        GROUP BY deptno) b
ON (a.deptno = b.deptno)
WHEN MATCHED THEN
    UPDATE SET sal = sal + 200
    WHERE a.sal < avg_sal;

ROLLBACK;

SELECT * FROM emp_test;

MERGE INTO emp_test a
USING (SELECT deptno, AVG(sal) avg_sal
        FROM emp_test
        GROUP BY deptno) b
ON (a.deptno = b.deptno)
WHEN MATCHED THEN
    UPDATE SET sal = CASE 
                        WHEN a.sal < b.avg_sal THEN sal + 200
                        ELSE a.sal
                      END;








