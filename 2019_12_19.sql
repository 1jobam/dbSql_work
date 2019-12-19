-- 사원이름, 사원번호, 전체직원건수
SELECT ename, empno, COUNT(*), SUM(sal)
FROM emp
GROUP BY ename, empno;

-- (도전해보기 실습 ana0)
-- 사원의 부서별 급여(sql)별 순위 구하기
-- emp 테이블 사용
SELECT a.ename, a.sal, a.deptno, b.rn
FROM 
(SELECT ename, sal, deptno, ROWNUM j_rn
    FROM
    (SELECT ename, sal, deptno
     FROM emp
     ORDER BY deptno, sal DESC)) a,

(SELECT rn, ROWNUM j_rn
FROM
    (SELECT b.*, a.rn
    FROM 
    (SELECT ROWNUM rn
     FROM dual
     CONNECT BY level <= (SELECT COUNT(*) FROM emp)) a,
    
    (SELECT deptno, COUNT(*) cnt
     FROM emp
     GROUP BY deptno) b
    WHERE b.cnt >= a.rn
    ORDER BY b.deptno, a.rn )) b
WHERE a.j_rn = b.j_rn;

-- ana 0을 분석함수로
SELECT ename, sal, deptno,
    RANK() OVER (PARTITION BY deptno ORDER BY sal DESC) rn
FROM emp;

-- 각 window 함수별 분석
SELECT ename, sal, deptno,
    RANK() OVER(PARTITION BY deptno ORDER BY sal) sal_rank,
    DENSE_RANK() OVER (PARTITION BY deptno ORDER BY sal) sal_dense_rank,
    ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal) sal_row_numbe
FROM emp;


-- 분석함수 / window  함수 (실습 ana1)
-- 사원의 전체 급여 순위를 rank, dense_rank, row_number를 이용하여 구하세요.
-- 단 급여가 동일한 경우 사버닝 빠른 사람이 높은 순위가 되도록 작성하세요.
SELECT empno, ename, sal, deptno,
    RANK() OVER(ORDER BY sal DESC, empno) sal_rank,
    DENSE_RANK() OVER(ORDER BY sal DESC, empno) sal_dense_rank,
    ROW_NUMBER() OVER(ORDER BY sal DESC, empno) sal_row_number
FROM emp;

-- 분석함수 / window 함수 ( 실습 no_ana1 )
-- 기존의 배운 내용을 활용하여.
-- 모든 사원에 대해 사원번호, 사원이름, 해당 사원이 속한 부서의 사원 수를
-- 조회하는 쿼리를 작성하세요.
SELECT b.empno, b.ename, b.deptno, a.cdept FROM
(SELECT deptno, COUNT(deptno) cdept
FROM emp
GROUP BY deptno) a,
(SELECT empno, ename, deptno
FROM emp) b
WHERE a.deptno = b.deptno
ORDER BY deptno;

-- 사원번호, 사원이름, 부서번호, 부서의 직원수
SELECT empno, ename, deptno,
    COUNT(*) OVER (PARTITION BY deptno) cnt
FROM emp;

-- 분석함수 / window 함수 ( 실습 ana2 )
-- window function을 이용하여 모든 사원에 대해 사원번호, 사원이름, 본인
-- 급여, 부서번호와 해당 사원이 속한 부서의 급여 평균을 조회 하는 쿼리를 작성하세요
-- (급여 평균은 소수점 둘째 자리까지 구한다)
SELECT empno, ename, sal, deptno,
    ROUND(AVG(sal) OVER (PARTITION BY deptno), 2) sal_avg
FROM emp;

-- 분석함수 / window 함수 ( 실습 ana3 )
-- window function을 이용하여 모든 사원에 대해 사원번호, 사원이름, 본인,
-- 급여, 부서번호와 해당 사원이 속한 부서의 가장 높은 급여를 조회하는 쿼리를 작성하세요.
SELECT empno, ename, sal, deptno,
    MAX(sal) OVER (PARTITION BY deptno) max_sal
FROM emp;

-- 분석함수 / window 함수 ( 실습 ana4 )
-- window function을 이용하여 모든 사원에 대해 사원번호, 사원이름, 본인
-- 급여, 부서번호와 해당 사원이 속한 부서의 가장 낮은 급여를 조회하는 쿼리를 작성하세요.
SELECT empno, ename, sal, deptno,
    MIN(sal) OVER (PARTITION BY deptno) min_sal
FROM emp;

-- 전체사원을 대상으로 급여순위가 자신보다 한단계 낮은 사람의 급여
-- (급여가 같을경우 입사일자가 빠른 사람이 높은 순위)
SELECT empno, ename, hiredate, sal,
    LEAD(sal) OVER (ORDER BY SAL DESC, hiredate) lead_sal
FROM emp;

--분석함수 / window 함수 (그룹내 행 순서 실습 ana5)
--window function을 이용하여 모든 사원에 대해 사원번호, 사원이름,
--입사일자, 급여, 전체 사원중 급여 순위가 1단계 높은 사람의 급여를 조회하는 쿼리를 작성하세요.
--(급여가 같을 경우 입사일이 빠른 사람이 높은순위)
SELECT empno, ename, hiredate, sal,
    LAG(sal) OVER (ORDER BY sal DESC, hiredate) lag_sal
FROM emp;

--분석함수 / window 함수 (그룹내 행 순서 실습 ana6)
--window function을 이용하여 모든 사원에 대해 사원번호, 사원이름,
--입사일자, 직군(job), 급여 정보와 담당업무(JOB) 별 급여 순위가 1단계 높은
--사람의 급여를 조회하는 쿼리를 작성하세요
--(급여가 같을 경우 입사일이 빠른 사람이 높은순위)
SELECT empno, ename, hiredate, job, sal,
    LAG(sal) OVER (PARTITION BY job ORDER BY sal DESC, hiredate) lag_sal
FROM emp;