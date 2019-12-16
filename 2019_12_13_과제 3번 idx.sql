-- DDL (INDEX �ǽ� idx4) ���� ����

--1��
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = :empno;


--2��
EXPLAIN PLAN FOR
SELECT *
FROM dept
WHERE deptno = :deptno;


--3��
EXPLAIN PLAN FOR
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.deptno = :deptno
AND emp.deptno LIKE :deptno || '%';


--4��
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE sal BETWEEN : st_sal AND :ed_sal
AND deptno = :deptno;


--5��
EXPLAIN PLAN FOR
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.deptno = :deptno
AND dept.loc = :loc;


--���̺� ���� ��ȸ
SELECT * FROM TABLE(dbms_xplan.display);

--�ε��� �׽�Ʈ ����
DROP INDEX idx_emp_01;
DROP INDEX idx_dept_01;

-- emp ���̺� �ε���
CREATE INDEX idx_emp_01 ON emp (sal, empno, deptno);

-- dept ���̺� �ε���
CREATE INDEX idx_dept_01 ON dept (deptno);