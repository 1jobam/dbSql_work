--INDEX만 조회하여 사용자의 요구사항에 만족하는 데이터를 만들어 낼 수 있는 경우
SELECT * FROM emp;

SELECT empno, rowid
FROM emp
ORDER BY empno;

--emp 테이블의 모든 컬럼을 조회
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7369;

SELECT * FROM TABLE (dbms_xplan.display);

--emp 테이블의 empno 컬럼을 조회
EXPLAIN PLAN FOR
SELECT empno
FROM emp
WHERE empno = 7369;

SELECT * FROM TABLE (dbms_xplan.display);


--기존 인덱스 제거
--pk_emp 제약조건 삭제 --> unique 제약 삭제 --> pk_emp 인덱스 삭제)

--INDEX 종류 (컬럼 중복 여부)
--UNIQUE INDEX : 인덱스 컬럼의 값이 중복될 수 없는 인덱스(emp.empno, dept.deptno)
--NON-UNIQUE INDEX(default)  : 인덱스 컬럼의 값이 중복될 수 있는 인덱스 (emp.job)
ALTER TABLE emp DROP CONSTRAINT pk_emp;

--CREATE UNIQUE INDEX idx_n_emp_01 ON emp (empno);

--위쪽 상황이랑 다르게
--UNIQUE -> NON-UNIQUE 인덱스로 변경됨
CREATE INDEX idx_n_emp_01 ON emp (empno);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT * FROM TABLE (dbms_xplan.display);
 
--7782
INSERT INTO emp (empno, ename) VALUES (7782, 'brown');
SELECT * FROM emp;

--DEPT 테이블에는 PK_DEPT (PRIMARY KEY 제약 조건이 설정됨)
--PK_DEPT : deptno
SELECT *
FROM dept;

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'DEPT';

SELECT *
FROM USER_CONS_COLUMNS
WHERE TABLE_NAME = 'DEPT';

--emp 테이블에 job 컬럼으로 non-unique 인덱스 생성
--인덱스명 : idx_n_emp_02
CREATE INDEX idx_n_emp_02 ON emp (job);

EXPLAIN PLAN FOR
SELECT job, rowid
FROM emp, dept
ORDER BY job;
  
SELECT * FROM TABLE(dbms_xplan.display);

-- emp 테이블에는 인덱스가 2개 존재
--1. empno
--2. job

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE sal > 500;

select * from table(dbms_xplan.display);

EXPLAIN PLAN FOR
--IDX_02 인덱스
-- emp 테이블에는 인덱스가 2개 존재
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
-- emp 테이블의 job, ename 컬럼으로 non-unique 인덱스 생성
CREATE INDEX idx_n_emp_03 ON emp (job,ename);

SELECT job, ename, rowid
FROM emp
ORDER BY job, ename;

-- idx_n_emp_04
-- ename, job 컬럼으로 emp 테이블에 non-unique 인덱스 생성
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

-- JOIN 쿼리에서의 인덱스
-- emp 테이블은 empno컬럼으로 PRIMARY KEY 제약조건이 존재
-- dept 테이블은 deptno 컬럼으로 PRIMARY KEY 제약조건이 존재
-- emp 테이블은 PRIMARY KEY 제약을 삭제한 상태이므로 재생성
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);

EXPLAIN PLAN FOR
SELECT ename, dname, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.empno = 7788;

SELECT * FROM table(dbms_xplan.display);

--DDL ( index 실습 idx1 )
--CREATE TABLE DEPT_TEST AS SELECT * FROM DEPT WHERE 1 = 1
--구문으로 DEPT_TEST 테이블 생성후 다음 조건에 맞는 인덱스를 생성하세요.
CREATE TABLE dept_test AS
SELECT * FROM dept where 1 = 1;
--deptno 컬럼을 기준으로 unique 인덱스 생성
CREATE UNIQUE INDEX idx_dt_01 ON dept_test (deptno);
--dname 컬럼을 기준으로 non-unique 인덱스 생성
CREATE INDEX idx_dt_02 ON dept_test (dname);
--deptno, dname 컬럼을 기준으로 non-unique 인덱스 생성
CREATE INDEX idx_dt_03 ON dept_test (deptno, dname);

--DDL ( index 실습 idx2 )
-- 실습 idx1 에서 생성한 인덱스를 삭제하는 DDL 문을 작성하세요.
DROP INDEX idx_dt_01;
DROP INDEX idx_dt_02;
DROP INDEX idx_dt_03;