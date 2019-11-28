-- emp 테이블, dept 테이블 조인

EXPLAIN PLAN FOR;
SELECT ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno != dept.deptno -- 연결고리
AND emp.deptno = 10;

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

-- 자식 - 부모 - 0 순서

SELECT ename, deptno
FROM emp;

SELECT deptno, dname
FROM dept;

-- natural join : 조인 테이블간 같은 타입, 같은이름의 컬럼으로
--                  같은 값을 갖을 경우 조인

DESC emp;
DESC dept;

SELECT *
FROM emp NATURAL JOIN dept;

--ANSI SQL
SELECT deptno, emp.empno, ename
FROM emp NATURAL JOIN dept;

--oracle 문법
SELECT emp.deptno, emp.empno, ename
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--별칭 주는것도가능
SELECT a.deptno, empno, ename
FROM emp a, dept b
WHERE a.deptno = b.deptno;

-- JOIN USINC
-- join 하려고하는 테이블간 동일한 이름의 컬럼이 두개 이상일 때
-- join 컬럼을 하나만 사용하고 싶을 때

--ANSI SQL
SELECT *
FROM emp JOIN dept USING (deptno);

--ORACLE SQL
SELECT *
FROM emp a, dept b
WHERE a.deptno = b.deptno;


-- 모든 가능의 수 를 조회
SELECT *
FROM emp, dept;

SELECT *
FROM emp, dept
WHERE 1 = 1;

--ANSI JOIN with ON
--조인 하고자 하는 테이블의 컬럼 이름이 다를 때
--개발자가 조인 조건을 직접 제어할 때

SELECT *
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

--oracle
SELECT *
FROM emp a, dept b
WHERE a.deptno = b.deptno;

-- SELF JOIN : 같은 테이블간 조인
-- emp 테이블간 조인 할만한 사항 : 직원의 관리자 정보 조회
-- 직원의 관리자 정보를 조회
-- 직원이름, 관리자이름

-- ANSI
SELECT e.ename, m.ename
FROM emp e JOIN emp m ON(e.mgr = m.empno);

-- ORACLE
SELECT e.ename, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;


--직원 이름, 직원의 상급자 이름, 직원의 상급자의 상급자 이름, 직원의 상급자의 상급자의 상급자 이름
--ANSI SQL
SELECT e.ename, m.ename, t.ename, k.ename
FROM emp e JOIN emp m ON(e.mgr = m.empno)
    JOIN emp t ON (m.mgr = t.empno)
        JOIN emp k ON (t.mgr = k.empno);

-- ORACLE 
SELECT e.ename, m.ename, d.ename, nvlt.ename
FROM emp e, emp m, emp d, emp t
WHERE e.mgr = m.empno
AND m.mgr = d.empno
AND d.mgr = t.empno;

SELECT e.ename, m.ename, d.ename, t.ename
FROM emp e, emp m, emp d, emp t
WHERE e.mgr = m.empno
AND m.mgr = d.empno
AND d.mgr = t.empno;

-- dept 4 * 4 * 4 =
SELECT * 
FROM dept a, dept s, dept d;

-- 직원의 이름과, 해당 직원의 관리자 이름을 조회한다.
-- 단 직원의 사번이 7369~7698인 직원을 대상으로 조회
-- ANSI SQL
SELECT a.ename, b.ename
FROM emp a JOIN emp b ON (a.mgr = b.empno)
WHERE a.empno BETWEEN 7369 AND 7698;

--oarcle sql

SELECT s.ename, m.ename
FROM emp s, emp m
WHERE s.empno BETWEEN 7369 AND 7698
AND s.mgr = m.empno;

-- NON-EQUI JOIN : 조인 조건이 = (equal)이 아닌 JOIN
-- != , BETWEEN AND

SELECT *
FROM salgrade;

SELECT empno, ename, sal /* 급여 grade */
FROM emp;

--oracle  
SELECT b.grade, a.ename, a.sal, b.losal, b.hisal
FROM emp a, salgrade b
where a.sal BETWEEN losal and hisal;

--ANSI SQL
SELECT a.grade, a.losal, a.hisal, b.ename, b.sal
FROM emp b JOIN salgrade a ON b.sal BETWEEN a.losal AND a.hisal;

-- 실습 ( join 0)
-- emp, dept 테이블을 이용하여 다음과 같이 조회되도록 쿼리를 작성하세요.
--oracle 방식
SELECT empno, ename, s.deptno, dname
FROM emp a, dept s
where a.deptno = s.deptno
ORDER BY a.deptno;

-ANSI SQL 방식
SELECT a.empno, a.ename, a.deptno, b.dname
FROM emp a JOIN dept b ON b.deptno = a.deptno ORDER BY a.deptno;

-- 실습 (join 0_1)
--emp, dept 테이블을 이용하여 다음과 같이 조회되도록 쿼리를 작성하세요.
--oracle 방식
SELECT empno, ename, s.deptno, dname
FROM emp a, dept s
WHERE a.deptno = s.deptno
AND a.deptno in(10, 30);

--ANSI SQL 방식
SELECT a.empno, a.ename, a.deptno, b.dname
FROM emp a JOIN dept b ON b.deptno = a.deptno AND a.deptno in(10, 30);

-- 실습 (join 0_2)
-- emp, dept 테이블을 이용하여 다음과 같이 조회되도록 쿼리를 작성하세요. (급여가 2500 초과)
--oracle 방식
SELECT empno, ename, sal, s.deptno, dname
FROM emp a, dept s
WHERE a.deptno = s.deptno
AND sal > 2500
ORDER BY deptno;

--ANSI SQL 방식
SELECT a.empno, a.ename, a.deptno, b.dname
FROM emp a JOIN dept b ON b.deptno = a.deptno AND sal > 2500 ORDER BY deptno;

-- 실습 (join 0_3)
-- emp, dept 테이블을 이용하여 다음과 같이 조회되도록 쿼리를 작성하세요 (급여 2500초과, 사번이 7600보다 큰 직원)
--oracle 방식
SELECT empno, ename, sal, s.deptno, dname
FROM emp a, dept s
WHERE a.deptno = s.deptno
AND empno > 7600
AND sal > 2500
ORDER BY deptno;

--ANSI SQL 방식
SELECT a.empno, a.ename, sal, a.deptno, b.dname
FROM emp a JOIN dept b ON b.deptno = a.deptno AND empno > 7600 AND sal > 2500 ORDER BY deptno;

-- 실습 (join 0_4)
-- emp, dept 테이블을 이용하여 다음과 같이 조회되도록 쿼리를 작성하세요.
--(급여 2500초과, 사번이 7600보다 크고 부서명이 RESEARCH인 부서에 속한 직원)
--oracle 방식
SELECT empno, ename, sal, s.deptno, dname
FROM emp a, dept s
WHERE a.deptno = s.deptno
AND empno > 7600
AND sal > 2500
AND dname = 'RESEARCH'
ORDER BY deptno;

--ANSI SQL 방식
SELECT a.empno, a.ename, sal, a.deptno, b.dname
FROM emp a JOIN dept b ON b.deptno = a.deptno AND empno > 7600 AND sal > 2500 AND dname ='RESEARCH' ORDER BY deptno;

-- (base_tables.sql, 실습 join1)

--ANSI SQL 방식
SELECT lprod_gu, lprod_nm, prod_id, prod_name
FROM prod JOIN lprod ON prod_lgu = lprod_gu order by prod_id;