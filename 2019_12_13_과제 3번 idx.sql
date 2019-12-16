-- DDL (INDEX 실습 idx4) 과제 진행

--1번
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = :empno;


--2번
EXPLAIN PLAN FOR
SELECT *
FROM dept
WHERE deptno = :deptno;


--3번
EXPLAIN PLAN FOR
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.deptno = :deptno
AND emp.deptno LIKE :deptno || '%';


--4번
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE sal BETWEEN : st_sal AND :ed_sal
AND deptno = :deptno;


--5번
EXPLAIN PLAN FOR
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.deptno = :deptno
AND dept.loc = :loc;


--테이블 설명 조회
SELECT * FROM TABLE(dbms_xplan.display);

--인덱스 테스트 삭제
DROP INDEX idx_emp_01;
DROP INDEX idx_dept_01;

-- emp 테이블 인덱스
CREATE INDEX idx_emp_01 ON emp (sal, empno, deptno);

-- dept 테이블 인덱스
CREATE INDEX idx_dept_01 ON dept (deptno);