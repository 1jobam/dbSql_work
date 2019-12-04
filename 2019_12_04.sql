-- 1. tax 테이블을 이용 시도/시군구별 인당 연말정산 신고액 구하기
-- 2. 신고액이 많은 순서로 랭킹 부여하기
-- 랭킹(1) 시도(2) 시군구(3) 인당연말정산신고액(4)- 소수점 둘째자리에서 반올림
-- 1  서울특별시 서초구 7000
-- 2  서울특별시  강남구 6800

select * from tax;

SELECT ROWNUM rn, sido, sigungu, cal_sal
FROM
(SELECT sido, sigungu, sal, people, round(sal/people, 1) cal_sal
FROM tax
ORDER BY cal_sal desc);

--------------------------------------------------------------------------
-- OUTER JOIN 활욜 --
select * from fastfood;
select * from tax;

SELECT * FROM

(SELECT ROWNUM rn, c.*
FROM
(SELECT a.sido, a.sigungu, round(a.cnt/b.cnt, 1) 정렬
FROM
(SELECT sido, sigungu, count(*) cnt
FROM fastfood
WHERE gb IN('KFC', '맥도날드', '버거킹')
GROUP BY sido, sigungu)a,
(SELECT sido, sigungu, count(*) cnt
FROM fastfood
WHERE gb IN('롯데리아')
GROUP BY sido, sigungu)b
WHERE a.sido = b.sido
AND a.sigungu = b.sigungu
ORDER BY 정렬 desc)c)q,

(SELECT ROWNUM rn, sido, sigungu, cal_sal
FROM
(SELECT sido, sigungu, sal, people, round(sal/people, 1) cal_sal
FROM tax
ORDER BY cal_sal desc))w

WHERE q.rn(+) = w.rn
ORDER BY w.rn;


-- 도시발전지수 시도, 시군구와 연말 정산 납입 금액의 시도, 시군구가
-- 같은 지역끼리 조인
-- 정렬순서는 tax 테이블의 id 컬럼 순으로 정렬
-- 1 서울특별시 강남구 5.6 서울특별시 강남구 70.3
SELECT * FROM tax;
select * from fastfood;



SELECT w.id, q.sido, q.sigungu, q.순위, w.sido, w.sigungu, w.cal_sal FROM

(SELECT ROWNUM rn, c.*
FROM
(SELECT a.sido, a.sigungu, round(a.cnt/b.cnt, 1) 순위
FROM
(SELECT sido, sigungu, count(*) cnt
FROM fastfood
WHERE gb IN('KFC', '맥도날드', '버거킹')
GROUP BY sido, sigungu)a,
(SELECT sido, sigungu, count(*) cnt
FROM fastfood
WHERE gb IN('롯데리아')
GROUP BY sido, sigungu)b
WHERE a.sido = b.sido
AND a.sigungu = b.sigungu
ORDER BY 순위 desc)c)q,

(SELECT ROWNUM rn, sido, sigungu, cal_sal, id
FROM
(SELECT sido, sigungu, sal, people, round(sal/people, 1) cal_sal, id
FROM tax
ORDER BY cal_sal desc))w

WHERE q.sido(+) = w.sido
AND q.sigungu(+) = w.sigungu
ORDER BY w.id;


-- SMITH가 속한 부서 찾기
SELECT deptno 
FROM emp
WHERE ename = 'SMITH';

SELECT * 
FROM emp
WHERE deptno = (SELECT deptno 
                FROM emp
                WHERE ename = 'SMITH');
                
SELECT * 
FROM emp
WHERE deptno IN (SELECT deptno 
                FROM emp);
                
SELECT empno, ename, deptno,
    (SELECT dname FROM dept WHERE dept.deptno = emp.deptno) dname
FROM emp;

--scalar subquery
--SELECT 절에 표현된 서브 쿼리
--한 행, 한 COLUMN을 조회해야 한다.
SELECT empno, ename, deptno,
    (SELECT dname FROM dept) dname
FROM emp;

--INLINE VIEW
--FROM절에 사용되는 서브 쿼리

--SUBQUERY
--WHERE에 사용되는 서브쿼리

-- 서브쿼리 ( 실습 sub 1 )
-- 평균 급여보다 높은 급여를 받는 직원의 수를 조회하세요.
select * from emp;

SELECT count(sal) cnt
FROM emp
WHERE sal > (SELECT AVG(sal) FROM emp);

--서브쿼리 ( 실습 sub2 )
-- 평균 급여보다 높은 급여를 받는 직원의 정보를 조회하세요.
select * from emp;

SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal) FROM emp);

--서브쿼리 ( 실습 sub3 )
-- SMITH와 WARD 사원이 속한 부서의 모든 사원 정보를 조회하는 쿼리를 다음과 같이 작성하세요.
select * from emp;

SELECT deptno
FROM emp
WHERE ename IN ('SMITH', 'WARD');

SELECT *
FROM emp
WHERE deptno IN ( 20, 30 );

SELECT *
FROM emp
WHERE deptno IN (SELECT deptno FROM emp WHERE ename IN ('SMITH', 'WARD'));

--SMITH 혹은 WARD 보다 급여를 적게 받는 직원 조회
SELECT *
FROM emp
WHERE sal < ANY (SELECT sal --> ANY 는 1250보다 작은사람이 된다 결국 둘중하나의 값을 만족하면 되기때문에
                FROM emp 
                where ename in('SMITH', 'WARD'));
                
SELECT *
FROM emp
WHERE sal < ALL (SELECT sal --> ALL는 두조건을 만족해야되기 때문에 800보다 작은사람 이된다
                FROM emp 
                where ename in('SMITH', 'WARD'));
                
-- 관리자 역활을 하지 않는 사원 정보 조회

--관리자가 아닌 사원
--NOT IN 연산자 사용시 NULL이 데이터에 존재하지 않아야 정상 동작 한다.
SELECT *
FROM emp -- 사원 정보 조회 --> 관리자 역활을 하지 않는
WHERE empno NOT IN
            (SELECT NVL(mgr, -1) -- NULL 값을 존재하지 않을만한 데이터로 치환
                FROM emp);
                
SELECT *
FROM emp -- 사원 정보 조회 --> 관리자 역활을 하지 않는
WHERE empno NOT IN
            (SELECT mgr -- NULL 값을 존재하지 않을만한 데이터로 치환
                FROM emp WHERE mgr is not null);
--관리자인 사원
SELECT *
FROM emp 
WHERE empno IN
            (SELECT mgr
                FROM emp);

--prairwise (여러 컬럼의 값을 동시에 만족 해야하는 경우)
--ALLEN, CLARK의 매니저와 부서번호가 동시에 같은 사원 정보 조회
-- (7698, 30)
-- (7839, 10)
SELECT *
FROM emp
WHERE (mgr, deptno) IN
                    (SELECT mgr, deptno FROM emp WHERE empno IN ( 7499, 7782));

SELECT * 
FROM emp 
WHERE empno IN (7499, 7782);


-- 매니저가 7698 이거나 7839 이면서 소속부서가 10번 이거나 30번인 직원 정보 조회
--7698, 10
--7698, 30
--7839, 10
--7839, 30
SELECT *
FROM emp
WHERE mgr IN
            (SELECT mgr FROM emp WHERE empno IN ( 7499, 7782))
AND deptno IN
            (SELECT deptno FROM emp WHERE empno IN ( 7499, 7782));

--비상호 연관 서브 쿼리
--메인쿼리의 컬럼을 서브쿼리에서 사용하지 않는 형태의 서브 쿼리

--비상호 연관 서브쿼리의 경우 메인쿼리에서 사용하는 테이블, 서브쿼리 조회 순서를
--성능적으로 유리한 쪽으로 판단하여 순서를 결정 한다.
--메인쿼리의 emp 테이블을 먼저 읽을수도 있고, 서브쿼리의 emp 테이블을
--먼저 읽을 수도 있다.

--비상호 연관 서브쿼리에서 서브쿼리쪽 테이블을 먼저 읽을 때는
--서브쿼리가 제공자 역할을 했다 라고 모 도서에서 표현

--비상호 연관 서브쿼리에서 서브쿼리쪽 테이블을 나중에 읽을 때는
--서브쿼리가 확인자 역활을 했다 라고 모 도서에서 표현

--직원의 급여 평균보다 높은 급여를 받는 직원 정보 조회
-- 직원의 급여 평균
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal) FROM emp);

-- 상호연관 서브쿼리
--해당직원이 속한 부서의 급여 평균 보다 높은 급여를 받는 직원 조회
SELECT * 
FROM emp m
WHERE sal > (SELECT AVG(sal)
            FROM emp 
            WHERE deptno = m.deptno);

--10번 부서의 급여평균
SELECT AVG(sal)
FROM emp
WHERE deptno = 10;