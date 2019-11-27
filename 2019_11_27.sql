za-- ( condition 실습 cond 3)
-- users 테이블을 이용하여 reg_dt에 따라 올해 건강보험 검진 대상자인지 조회하는 쿼리를 작성하세요.
-- ( 생년을 기준으로 하나 여기서는 reg_dt를 기준으로 한다.)

SELECT a.userid, a.usernm, a.liias,
        DECODE( mod(a.yyyy, 2), mod(a.this_YYYY, 2), '건강검진대상', '건강검진 비대상') contacttotocdotr
FROM 
(SELECT userid, usernm, alias, TO_CHAR(reg_dt, 'YYYY') yyyy,
    TO_CHAR(sysdate, 'yyyy') this_yyyy
FROM users;) a;

-- GROUP FUNCTION
-- 특정 컬럼이나, 표현을 기준으로 여러행의 값을 한행의 결과로 생성
-- count - 건수, sum - 합계, avg - 평균, max - 최대값, min - 최소값
-- 전체 직원을 대상으로 (14건의 -> 1건)
-- 가장 높은 급여
desc emp;
SELECT MAX(sal) max_sal -- 가장 높은 급여
    , MIN(sal) min_sal -- 가장 낮은 급여
    , ROUND(AVG(sal), 2) avg_sal  -- 전 직원의 급여 평균
    , SUM(sal) sum_sal -- 전 직원의 급여 합계
    , COUNT(sal) count_sal -- 급여 건수(null이 아닌 값이면 1건)
    , COUNT(mgr) count_mgr -- 직원의 관리자 건수(KING의 경우 MGR가 없다)
    , COUNT(*) count_row -- 특정 컬럼의 건수가 아니라 행의 개수를 알고 싶을때
FROM emp;

SELECT *
FROM emp;

-- 부서번호 별 그룹함수 적용
SELECT deptno
    , MAX(sal) max_sal -- 부서에서 가장 높은 급여
    , MIN(sal) min_sal -- 부서에서 가장 낮은 급여
    , ROUND(AVG(sal), 2) avg_sal  -- 부서에서 전 직원의 급여 평균
    , SUM(sal) sum_sal -- 부서에서 전 직원의 급여 합계
    , COUNT(sal) count_sal -- 부서의 급여 건수(null이 아닌 값이면 1건)
    , COUNT(mgr) count_mgr -- 부서 직원의 관리자 건수(KING의 경우 MGR가 없다)
    , COUNT(*) count_row -- 부서의 조직원수 (특정 컬럼의 건수가 아니라 행의 개수를 알고 싶을때)
FROM emp
GROUP BY deptno;

SELECT deptno, ename
    , MAX(sal) max_sal -- 부서에서 가장 높은 급여
    , MIN(sal) min_sal -- 부서에서 가장 낮은 급여
    , ROUND(AVG(sal), 2) avg_sal  -- 부서에서 전 직원의 급여 평균
    , SUM(sal) sum_sal -- 부서에서 전 직원의 급여 합계
    , COUNT(sal) count_sal -- 부서의 급여 건수(null이 아닌 값이면 1건)
    , COUNT(mgr) count_mgr -- 부서 직원의 관리자 건수(KING의 경우 MGR가 없다)
    , COUNT(*) count_row -- 부서의 조직원수 (특정 컬럼의 건수가 아니라 행의 개수를 알고 싶을때)
FROM emp
GROUP BY deptno, ename;


--SELECT 절에는 GROUP BY 절에 표현된 컬럼 이외의 컬럼이 올 수 없다.
--논리적으로 성립이 되지 않음(여러명의 직원 정보로 한건의 데이터로 그루핑)
--단 예외적으로 상수값들은 SELECT 절에 표현이 가능
SELECT deptno, 'te', 1
    , MAX(sal) max_sal -- 부서에서 가장 높은 급여
    , MIN(sal) min_sal -- 부서에서 가장 낮은 급여
    , ROUND(AVG(sal), 2) avg_sal  -- 부서에서 전 직원의 급여 평균
    , SUM(sal) sum_sal -- 부서에서 전 직원의 급여 합계
    , COUNT(sal) count_sal -- 부서의 급여 건수(null이 아닌 값이면 1건)
    , COUNT(mgr) count_mgr -- 부서 직원의 관리자 건수(KING의 경우 MGR가 없다)
    , COUNT(*) count_row -- 부서의 조직원수 (특정 컬럼의 건수가 아니라 행의 개수를 알고 싶을때)
FROM emp
GROUP BY deptno;

-- 그룹함수에서는 NULL 컬럼은 계산에서 제외된다.
-- emp 테이블에서 comm컬럼이 null이 아닌 데이터는 4건이 존재, 9건은 NULL)
SELECT COUNT(comm) count_comm, -- NULL이 아닌값의 개수 4
        SUM(sal + comm) tot_sal_sum,
        SUM(sal + NVL(comm, 0)) tot_sal_sum2,
        SUM(comm) sum_comm, -- NULL값을 제외, 300 + 500 + 1400 + 0 = 2200
        SUM(sal) sum_sal
FROM emp;

--WHERE 절에는 GROUP 함수를 표현 할 수 없다.
--1. 부서별 최대 급여
--2. 부서별 최대 급여 값이 3000이 넘는 행만 구하기
--deptno, 최대급여
SELECT 
    deptno,
    MAX(SAL) m_sal --ORA-00934 WHERE 절에는 GROUP 함수가 올 수 없다.
FROM emp
GROUP BY deptno
HAVING MAX(sal) >= 3000;

-- group function 실습 grp 1)
-- emp 테이블을 이용하여 다음을 구하시오
-- 1. 직원중 가장 높은 급여
-- 2. 직원중 가장 낮은 급여
-- 3. 직원의 급여 평균
-- 4. 직원의 급여 합
-- 5. 직원중 급여가 있는 직원의 수(null제외)
-- 6. 직원중 상급자가 있는 직원의 수(null제외)
-- 7. 전체 직원의 수

SELECT 
    MAX(sal) max_sal,
    MIN(sal) min_sal,
    ROUND(AVG(sal), 2) avg_sal,
    SUM(sal) sum_sal,
    count(sal) count_sal,
    count(mgr) count_mgr,
    count(*) count_all
FROM emp;

-- (group function 실습 grp 2)
--emp 테이블을 이용하여 다음을 구하시오
-- 부서기준 직원중 가장 높은 급여
-- 부서기준 직원중 가장 낮은 급여
-- 부서기준 직원의 급여 평균(소수점 2자리까지)
-- 부서기준 직원의 급여 합
-- 부서의 직원중 급여가 있는 직원의 수(null 제외)
-- 부서의 직원중 상급자가 있는 직원의 수(null 제외)
-- 부서의 직원의수
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

-- (group function 실습 grp 3)
-- emp 테이블을 이용하여 다음을 구하시오.
-- grp2에서 작성한 쿼리를 활용하여
-- deptno 대신 부서명이 나올수 있도록 수정하시오.

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

-- ( Group funtion 실습 grp4 )
-- emp 테이블을 이용하여 다음을 구하시오
-- 직원의 입사 년월별로 몇명의 직원이 입사했는지 조회하는 쿼리를 작성하세요.

SELECT TO_CHAR(hiredate, 'yyyymm') HIRE_YYYYMM, count(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'yyyymm');

SELECT hire_yyyymm, count(*) FROM
(SELECT TO_CHAR(hiredate, 'yyyymm') hire_yyyymm FROM emp)
GROUP BY hire_yyyymm;

-- ( group function 실습 grp 5 )
-- emp테이블을 이용하여 다음을 구하시오
-- 직원의 입사 년별로 몇명의 직원이 입사했는지 조회하는 쿼리를 작성하세요
SELECT TO_CHAR(hiredate, 'yyyy') hire_yyyy, count(*) cnt
FROM emp
group by TO_CHAR(hiredate, 'yyyy');

--grp 6
-- ( group function 실습 grp 6 )
-- 회사에 존재하는 부서의 개수는 몇개인지 조회하는 쿼리를 작성하시오
SELECT count(*) cnt
FROM dept;

--grp 7
-- ( group function 실습 grp 7 )
-- 직원이 속한 부서의 개수를 조회하는 쿼리를 작성하시오
-- (emp 테이블 사용)
SELECT count(deptno) cnt FROM (SELECT deptno FROM emp GROUP BY deptno)a;

SELECT count(count(*)) cnt FROM emp GROUP BY deptno;

SELECT COUNT(DISTINCT deptno) cnt FROM emp;


-- JOIN
-- 1. 테이블 구조변경 (컬럼 추가)
-- 2. 추가된 컬럼에 값을 update
--dname 컬럼을 emp 테이블에 추가
desc emp;
desc dept;
-- 컬럼추가(dname, varchar2 (14))
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
-- 총 6건의 데이터 변경이 필요하다.
-- 값의 중복이 있는 형태(반정형규형)
UPDATE emp SET dname = 'MARKET SALES'
where DNAME = 'SALES';

select * from emp;

-- emp 테이블, dept 테이블 조인
SELECT ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;