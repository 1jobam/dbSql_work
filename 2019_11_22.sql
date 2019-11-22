-- GITHUB에 공유가 되어 있는 상태
--1. github에서 저장소 clone
--2. 이클립스 - 저장소 추가(git repositories)
--3. 이클립스 - 추가된 저장소 선택,
            -- 우클릭 projects import
--4. package / project explorer
--   해당 프로젝트 우클릭 - configure
--                       convert faceted form 설정


-- emp 테이블에서 부서번호가 10번이 아니고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회 하세요.
--(IN, NOT IN 연산자 사용금지)
select * from emp where deptno != 10 and hiredate > to_date('19810601','yyyymmdd');  -- 아니다 <> , !=

-- emp 테이블에서 부서번호가 10번이 아니고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회하세요.
select * from emp where deptno not in (10) and hiredate > to_date('19810601','yyyymmdd');

-- emp 테이블에서 부서번호가 10번이 아니고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회 하세요.
--(부서는 10, 20, 30 만 있다고 가정하고 IN 연산자를 사용)
select * from emp where deptno in(20, 30) and hiredate > to_date('19810601', 'yyyymmdd');

-- emp 테이블에서 job이 SALESMAN이거나 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회 하세요.
select * from emp where job = 'SALESMAN' or hiredate > to_date('19810601', 'yyyymmdd');

-- emp 테이블에서 job이 SALESMAN이거나 사원번호가 78로 시작하는 직원의 정보를 다음과 같이 조회 하세요.
select * from emp where job = 'SALESMAN' or empno like '78%';

--emp 테이블에서 job이 SALESMAN 이거나 사원번호가 78로 시작하는 직원의 정보를 다음과 같이 조회 하세요.
--(like 연산자를 사용하지 마세요.)
select * from emp where job = 'SALESMAN' or (empno >= 7800 and empno > 8000);
select * from emp where job = 'SALESMAN' or empno between 7800 and 7999;

-- 연산자 우선순위 (AND > OR)
-- 직원 이름이 SMITH 이거나, 직원 이름이 ALLEN이면서 역할이 SALESMAN인 직원
select * from emp where ename = 'SMITH' or (ename = 'ALLEN' and job = 'SALESMAN');

--직원 이름이 SMTIH 이거나 ALLEN 이면서 역할이 SALESMAN인 사람
select * from emp where (ename = 'SMTIH' or ename = 'ALLEN') and job = 'SALESMAN';

--emp 테이블에서 job이 SALESMAN 이거나 사원번호가 78로 시작하면서 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회하세요.
select * from emp where job = 'SALESMAN' or (empno like '78%' and hiredate > to_date('19810601','yyyymmdd'));

-- 데이터 정렬
-- 10, 5, 3, 2, 1
-- 오름차순 : 1, 2, 3, 5, 10 // -- 내림차순 : 10, 5, 3, 2, 1

--오름차순 : ASC (표기를 안할경우 기본값)
--내림차순 : DESC (내림차순시 반드시 표기)

/*
    SELECT col1, col2, ......
    FROM 테이블명
    WHERE col1 = '값'
    ORDER BY 정렬기준컬럼1 [ASC / DESC], 정렬기준컬럼2.... [ASC / DESC]
*/

--사원(emp) 테이블에서 직원의 정보를 직원 이름으로 오름차순 정렬
select * from emp order by ename;
select * from emp order by ename; -- 정렬기준을 작성하기 않을 경우 오름차순[ASC]가 된다. 위와 동일

--사원(emp) 테이블에서 직원의 정보를 직원 이름(ename) 으로 내림차순 정렬
select * from emp order by ename desc;

--사원(emp) 테이블에서 직원의 정보를 부서번호로 오름차순 정렬하고
-- 부서번호가 같을 때는 sal 내림차순 정렬
-- 급여가(sal)가 같을때는 이름으로 오름차순 정렬한다.
select * from emp order by deptno, sal desc, ename;

--정렬 컬럼을 allas로 표현
select deptno, sal, ename nm from emp order by nm;

--조회하는 컬럼의 위치 인덱스를 표현 가능
select deptno, sal, ename nm from emp order by 3; -- 추천 하지 않으며 컬럼이 추가될때를 대비하여 명시적으로 표현 할것.. (컬럼 추가시 의도하지 않은 결과가 나올 수 있음)

-- dept 테이블의 모든 정보를 부서이름으로 오름차순 정렬로 조회되도록 쿼리를 작성하세요.
-- dept 테이블의 모든 정보를 부서위치로 내림차순 정렬로 조회되도록 쿼리를 작성하세요.
select * from dept order by dname;
select * from dept order by loc desc;

-- emp 테이블에서 상여(comm) 정보가 있는 사람들만 조회하고, 상여(comm)를 많이 받는 사람들만 조회하고,
-- 상여(comm)를 많이 받는 사람이 먼저 조회되도록 하고, 상여가 있을 겨우 사번으로 오름차순 정렬하세요.
select * from emp where comm is not null order by comm desc, empno;
select * from emp where comm is not null and comm != 0 order by comm desc, empno;

-- emp 테이블에서 관리자가 있는 사람들만 조회하고, 직군(job) 순으로 오름차순 정렬하고,
-- 직업이 같을 경우 사번이 큰 사원이 먼저 조회되도록 쿼리를 작성하세요.
select * from emp where mgr is not null order by job, empno desc;

-- emp 테이블에서 10번 부서(deptno) 혹은 30번 부서에 속하는 사람중
-- 급여(sal)가 1500이 넘는 사람들만 조회하고 이름으로 내림차순 정렬되도록 쿼리를 작성하세요.
select * from emp where deptno in('10','30') and sal > 1500 order by ename desc;

-- 로우 컬럼 을 추가하는 키워드 rownum
select rownum 순서, empno, ename from emp;
 al 비교는 1만 가능
select rownum, empno, ename from emp where rownum  <= 10; -- ROWNUM을 1부터 순차적으로 조회하는 경우는 가능
select rownum, empno, ename from emp where rownum between 1 and 20;

--select 절과 order by 구문의 실행순서
--select -> rownum -> order by 실행순서
select rownum, empno, ename from emp order by ename;

-- INLINE VIEW를 통해 정렬 먼저 실행하고, 해당 결과에 rownum을 적용
-- select 절에 * 사용하고, 다른 컬럼 | 표현식을 썻을 경우 *앞에 테이블명이나, 테이블 별칭을 적용
select rownum, a.* from (select empno, ename from emp order by ename) a; 
select rownum, emp.* from emp;

-- emp 테이블에서 rownum 값이 1~10인 값만 조회하는 쿼리를 작성해보세요.
--(정렬없이 진행하세요, 결과는 화면과 다를수 있습니다)
select rownum rn, empno, ename from emp where rownum <= 10;

-- rownum 값이 11~20(11~14)인 값만 조회하는 쿼리를 작성해보세요.
select e.* from (select rownum rn, empno, ename from emp) e where rn between 11 and 14;

-- row_3 쌤이 만든 문제
-- emp 테이블에서 ename으로 정렬한 결과에 11번째 ~ 14번째 행만 조회하는 쿼리를 작성하세요.
-- (empno, ename 컬람과 행번호만 조회)
-- select c.*, a.* from(select c.* from(select rownum rn, empno, ename from emp)c )a where order by rn where rn betwenn 11 and 14;
select * from(select rownum rn,a.* from(select empno, ename from emp order by ename)a) where rn between 11 and 14;



