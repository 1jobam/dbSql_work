-- col IN (value1, values2...)
-- col의 값이 IN 연산자 안에 나열된 값중에 포함될 때 참으로 판정

--RDBMS - 집합개념
--1. 집합에는 순서가 없다.
-- {1, 5, 7}, {5, 1, 7}
--2. 집합에는 중복이 없다.
-- {1, 1, 5, 7}, {5, 1, 7} 동일하다
select * from emp where deptno IN (10 , 20); --emp 테이블의 직원의 소속 부서가 10 이거나 20인 직원 정보만 조회 하시오.

--이거나 --> OR (또는)
--이고 --> AND (그리고)

-- IN --> OR
-- BETWEEN AND --> AND + 산술비교

SELECT * FROM emp where deptno = 10 or deptno = 20;

--users 테이블에서 userid가 brown, cony, sally인 데이터를 다음과 같이 조회 하시오.
--(IN 연산자 사용)
--유형 확인 desc users;

select userid 아이디, usernm 이름, alias 별명 from users 
where userid in('brown', 'cony', 'sally');

-- LIKE 연산자 : 문자열 매칭 연산
-- % : 여러 문자(문자가 없을 수도 있다.)
-- _ : 하나의 문자

-- where3
--emp 테이블에서 사원 이름이 s로 시작하는 사원 정보만 조회
select * from emp
where ename like 'S%';

-- SMAITH
-- SCOTT
-- 첫글자는 S로 시작하고 4번째 글자는 T
-- 두번째, 세번째, 다섯번째 문자는 어떤 문자든 올 수 있다.
select * from emp
where ename like 'S__T_';
where ename like 'S%T_'; -- 'STE', 'STTTT', 'STESTS'


-- where4
-- member 테이블에서 회원의 성이 [신]씨인 사람의 mem_id, mem_name 을 조회하는 쿼리를 작성하시오.
select mem_id, mem_name from member
where mem_name like '신%';

-- where5
-- member 테이블에서 회원의 이름에 글자[이]가 들어가는 모든 사람의 mem_id, mem_name을 조회하는 쿼리를 작성하시오.
select mem_id, mem_name from member
where mem_name like '%이%'; --% _ 

--컬럼 값이 NULL인 데이터 찾기
--emp 테이블에 보면 MGR 컬럼이 NULL 데이터가 존재
select * from emp
where MGR IS NULL; -- NULL값 확인에는 IS NULL 연산자를 사용
where MGR = 7698; --MGR 컬럼 값이 7698인 사원 정보조회
where MGR = NULL; --MGR 컬럼 값이 NULL인 사원 정보조회 (조회 되지 않음)

--where6
--emp 테이블에서 상여(comm)가 있는 회원의 정보를 다음과 같이 조회되도록 쿼리를 작성하시오
select * from emp
where COMM is not null;

-- and : 조건을 도시에 만족
-- or : 조건을 한개만 충족하면 만족
-- emp 테이블에서 mgr가 7698 사번이고(and), 급여가 1000보다 큰 사람
select * from emp
where mgr = 7698
and sal > 1000;

-- emp 테이블에서 mgr가 7698 이거나(OR), 급여가 1000보다 큰 사람
select * from emp
where mgr = 7698
or sal > 1000;

--emp 테이블에서 관리자 사번이 7698, 7839가 아닌 직원 정보조회
select * from emp
where MGR not in ( 7698, 7839 )
or mgr is null;

desc emp;

--where 7
-- emp 테이블에서 job이 SALESMAN 이고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회 하세요.
select * from emp
where JOB = 'SALESMAN'
and HIREDATE >= to_date('19810601','yyyymmdd');
