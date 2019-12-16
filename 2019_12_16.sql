--GROUPING SETS(col1, col2)
--다음과 결과가 동일
--개발자가 GROUP BY의 기준을 직접 명시한다.
--ROLLUP과 달리 방향성을 갖지 않는다.
--GROUPING SETS(col1, col2) = GROUPING SETS(col2, col1)

-- GROUP BY col1
--UNION ALL
--GROUP BY col2

--emp 테이블에서 직원의 job(업무)별 급여(sal) + 상여(comm)합,
--                    deptno(부서)  급여(sal) + 상여(comm)합,
--기존 방식(GROUP FUNCTION) : 2 번의 SQL 작성 필요(UNION / UNION ALL)
SELECT job, null deptno, sum(sal + nvl(comm, 0)) sal_comm_sum
FROM emp
GROUP BY job
UNION ALL
SELECT null job, deptno, sum(sal + nvl(comm,0)) sal_comm_sum
FROM emp
GROUP BY deptno;

--GROUPING SETS 구문을 이용하여 위의 SQL을 집합연산을 사용하지 않고
--테이블을 한번 읽어서 처리
SELECT job, deptno, SUM(sal + nvl(comm, 0)) sal_comm_sum
FROM emp
GROUP BY GROUPING SETS (job, deptno);

--job, deptno를 그룹으로 한 sal+comm 합
--mgr를 그룹으로 한 sal + comm 합
--기존방식으로 하면 아래사항
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
-- 그룹핑 셋츠로 변경시 아래사항
-- --> GROUPING SETS((job, deptno), mgr)
SELECT job, deptno, mgr, SUM(sal + nvl(comm, 0)) sal_comm_sum,
    GROUPING(job), GROUPING(deptno), GROUPING(mgr)
FROM emp
GROUP BY GROUPING SETS((job, deptno), mgr);

--CUBE (col1, col2 ...)
-- 나열된 컬럼의 모든 가능한 조합으로 GROUP BY subset을 만든다
--CUBE에 나열된 컬럼이 2개인 경우 : 가능한 조합 4개
--CUBE에 나열된 컬럼이 3개인 경우 : 가능한 조합 8개
--CUBE에 나열된 컬럼수를 2의 제곱승 한 결과의 가능한 조합 개수가 된다 (2^n)
--컬럼이 조금만 많아져도 가능한 조합이 기하급수적으로 늘어 나기 때문에
--많이 사용하지는 않는다

-- job, deptno를 이용하여 CUBE 적용
SELECT job, deptno, SUM(sal + nvl(comm, 0)) sal_comm_sum
FROM emp
GROUP BY CUBE(job, deptno);
--job, deptno
--1,   1     --> GROUP BY job, deptno
--1,   0     --> GROUP BY job
--0,   1     --> GROUP BY deptno
--0,   0     --> GROUP BY --emp 테이블의 모든행에 대해 GROUP BY

-- GROUP BY 응용
-- GROUP BY, ROLLUP, CUBE를 섞어 사용하기
-- 가능한 조합을 생각해보면 쉽게 결과를 예측할 수 있다.
-- GROUP BY job , rollup(detpno), cube(mgr)

SELECT job, deptno, mgr, SUM(sal + nvl(comm, 0)) sal
FROM emp
GROUP BY job, ROLLUP(deptno), CUBE(mgr); 

SELECT job, SUM(sal)
FROM emp
GROUP BY job;

-- 서브쿼리 ADVANCED ( correlated subquery update - 실습 sub_a1)
-- dept테이블을 이용하여 dept_test 테이블 생성
-- dept_test 테이블에 empcnt (number) 컬럼 추가
-- subquery를 이용하여 dept_test 테이블의 empcnt 컬럼에 해당 부서원 수를 update쿼리를 작성하세요.
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
                
    
--테스트
SELECT dept.deptno, COUNT(dept.deptno)
FROM emp, dept 
WHERE emp.deptno = dept.deptno
GROUP BY dept.deptno;


-- 서브쿼리 ADVANCED ( correlated subquery delete - 실습 sub_a2 )
-- dept 테이블을 이용하여 dept_test 테이블 생성
-- dpet_test 테이블에 신규 데이터 2건 추가
-- emp 테이블의 직원들이 속하지 않은 부서 정보 삭제하는 쿼리를
-- 서브쿼리를 이용하여 작성하세요.
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

-- 테스트
SELECT emp.deptno, dept_test.deptno
FROM emp, dept_test
WHERE emp.deptno = dept_test.deptno;


-- 서브쿼리 ADVANCED ( correlated subquery delete - 실습 sub_a3 )
-- EMP 테이블을 이용하여 EMP_TEST 테이블 생성
-- SUBQUERY를 이용하여 emp_test 테이블에서 본인이 속한 부서의 
-- (SAL)평균 급여보다 급여가 작은 직원의 급여를 현 급여에서 200을
-- 추가해서 업데이트 하는 쿼리를 작성하세요.

DROP TABLE emp_test;
SELECT * FROM emp_test;
--1
CREATE TABLE emp_test AS
SELECT * FROM emp WHERE 1 = 1;


--2
SELECT * FROM emp_test;
ROLLBACK;

--시험
UPDATE emp_test 
SET sal = sal + 200
WHERE sal < (SELECT ROUND(AVG(sal), 0) FROM emp_test);

--정답
UPDATE emp_test 
SET sal = sal + 200
WHERE sal < (SELECT ROUND(AVG(sal), 2)
                FROM emp
                WHERE deptno = emp_test.deptno);


--테스트
SELECT emp_test.deptno, ROUND(AVG(emp_test.sal), 2) sal
FROM emp_test, emp
WHERE emp_test.deptno = emp.deptno
GROUP BY emp_test.deptno;


-- MERGE 구문을 이용한 업데이트
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








