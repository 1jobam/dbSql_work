--INDEX�� ��ȸ�Ͽ� ������� �䱸���׿� �����ϴ� �����͸� ����� �� �� �ִ� ���
SELECT * FROM emp;

SELECT empno, rowid
FROM emp
ORDER BY empno;

--emp ���̺��� ��� �÷��� ��ȸ
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7369;

SELECT * FROM TABLE (dbms_xplan.display);

--emp ���̺��� empno �÷��� ��ȸ
EXPLAIN PLAN FOR
SELECT empno
FROM emp
WHERE empno = 7369;

SELECT * FROM TABLE (dbms_xplan.display);


--���� �ε��� ����
--pk_emp �������� ���� --> unique ���� ���� --> pk_emp �ε��� ����)

--INDEX ���� (�÷� �ߺ� ����)
--UNIQUE INDEX : �ε��� �÷��� ���� �ߺ��� �� ���� �ε���(emp.empno, dept.deptno)
--NON-UNIQUE INDEX(default)  : �ε��� �÷��� ���� �ߺ��� �� �ִ� �ε��� (emp.job)
ALTER TABLE emp DROP CONSTRAINT pk_emp;

--CREATE UNIQUE INDEX idx_n_emp_01 ON emp (empno);

--���� ��Ȳ�̶� �ٸ���
--UNIQUE -> NON-UNIQUE �ε����� �����
CREATE INDEX idx_n_emp_01 ON emp (empno);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT * FROM TABLE (dbms_xplan.display);
 
--7782
INSERT INTO emp (empno, ename) VALUES (7782, 'brown');
SELECT * FROM emp;

--DEPT ���̺��� PK_DEPT (PRIMARY KEY ���� ������ ������)
--PK_DEPT : deptno
SELECT *
FROM dept;

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'DEPT';

SELECT *
FROM USER_CONS_COLUMNS
WHERE TABLE_NAME = 'DEPT';

--emp ���̺� job �÷����� non-unique �ε��� ����
--�ε����� : idx_n_emp_02
CREATE INDEX idx_n_emp_02 ON emp (job);

EXPLAIN PLAN FOR
SELECT job, rowid
FROM emp, dept
ORDER BY job;
  
SELECT * FROM TABLE(dbms_xplan.display);

-- emp ���̺��� �ε����� 2�� ����
--1. empno
--2. job

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE sal > 500;

select * from table(dbms_xplan.display);

EXPLAIN PLAN FOR
--IDX_02 �ε���
-- emp ���̺��� �ε����� 2�� ����
-- 1. empno
-- 2. job
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';

select * from table(dbms_xplan.display);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7369;

select * from table(dbms_xplan.display);

--idx_n_emp_03
-- emp ���̺��� job, ename �÷����� non-unique �ε��� ����
CREATE INDEX idx_n_emp_03 ON emp (job,ename);

SELECT job, ename, rowid
FROM emp
ORDER BY job, ename;

-- idx_n_emp_04
-- ename, job �÷����� emp ���̺� non-unique �ε��� ����
CREATE INDEX idx_n_emp_04 ON emp (ename, job);

SELECT ename, job, rowid
FROM emp
ORDER BY ename, job;


EXPLAIN PLAN FOR
SELECT * FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'J%';

EXPLAIN PLAN FOR
SELECT * FROM emp
WHERE job = 'MANAGER' AND ename LIKE 'J%';

EXPLAIN PLAN FOR
SELECT * FROM emp
WHERE ename LIKE 'C%' AND job = 'MANAGER';

SELECT * FROM table(dbms_xplan.display);

-- JOIN ���������� �ε���
-- emp ���̺��� empno�÷����� PRIMARY KEY ���������� ����
-- dept ���̺��� deptno �÷����� PRIMARY KEY ���������� ����
-- emp ���̺��� PRIMARY KEY ������ ������ �����̹Ƿ� �����
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);

EXPLAIN PLAN FOR
SELECT ename, dname, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.empno = 7788;

SELECT * FROM table(dbms_xplan.display);

--DDL ( index �ǽ� idx1 )
--CREATE TABLE DEPT_TEST AS SELECT * FROM DEPT WHERE 1 = 1
--�������� DEPT_TEST ���̺� ������ ���� ���ǿ� �´� �ε����� �����ϼ���.
CREATE TABLE dept_test AS
SELECT * FROM dept where 1 = 1;
--deptno �÷��� �������� unique �ε��� ����
CREATE UNIQUE INDEX idx_dt_01 ON dept_test (deptno);
--dname �÷��� �������� non-unique �ε��� ����
CREATE INDEX idx_dt_02 ON dept_test (dname);
--deptno, dname �÷��� �������� non-unique �ε��� ����
CREATE INDEX idx_dt_03 ON dept_test (deptno, dname);

--DDL ( index �ǽ� idx2 )
-- �ǽ� idx1 ���� ������ �ε����� �����ϴ� DDL ���� �ۼ��ϼ���.
DROP INDEX idx_dt_01;
DROP INDEX idx_dt_02;
DROP INDEX idx_dt_03;