-- ** 과제 **

-- (실습 where 3)
-- users 테이블에서 userid가 brown, cony, sally인 데이터를 다음과 같이 조회하시오
-- (IN 연산자 사용)
select * from users where userid in ('brown', 'cony', 'sally');

-- (실습 where 4)
-- member 테이블에서 회원의 성이 [신]씨인 사람의 mem_id, mem_name 을 조회하는 쿼리를 작성하시오
select mem_id, mem_name from member where mem_name like '신%';

-- (실습 where 5)
-- member 테이블에서 회원의 이름에 글자[이]가 들어가는 모든 사람의 mem_id, mem_name을 조회하는 쿼리를 작성하시오
select mem_id, mem_name from member where mem_name like '%이%';

-- (실습 where 6)
-- emp 테이블에서 상여(comm)가 있는 회원의 정보를 다음과 같이 조회되도록 쿼리를 작성하시오.
select * from emp where comm is not null;

-- (실습 where 7)
-- emp 테이블에서 job이 salesman 이고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회 하세요.
select * from emp where job = 'SALESMAN' and hiredate >= to_date('19810601', 'yyyymmdd');

-- (예습 where 8)
-- emp 테이블에서 부서번호가 10번이 아니고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회 하세요.
select * from emp where deptno not like '10' and hiredate >= to_date('19810601','yyyymmdd');

-- (예습 where 9)
-- emp 테이블에서 부서번호가 10번이 아니고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회 하세요.
select * from emp where deptno not in '10' and hiredate >= to_date('19810601','yyyymmdd');

-- (예습 where 10)
-- emp 테이블에서 부서번호가 10번이 아니고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회 하세요.
select * from emp where deptno in('20','30') and hiredate >= to_date('19810601','yyyymmdd');

-- (예습 where 11)
-- emp 테이블에서 job이 salesman 이거나 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회 하세요.
select * from emp where job like 'SAL%' or hiredate >= to_date('19810601','yyyymmdd');

-- (예습 where 12)
-- emp 테이블에서 job이 salesman 이거나 사원번호가 78로 시작하는 직원의 정보를 다음과 같이 조회 하세요.
select * from emp where job = 'SALESMAN' or EMPNO like '78%';

-- (예습 where 13)
--emp 테이블에서 job이 SALESMAN 이거나 사원번호가 78로 시작하는 직원의 정보를 다음과 같이 조회 하세요.
--(like 연산자를 사용하지 마세요)


-- (예습 where 14)
--emp 테이블에서 job이 SALESMAN 이거나 사원번호가 78로 시작하면서 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회 하세요.
select * from emp where job = 'SALESMAN' or empno like '78%' and hiredate >= to_date('19810601','yyyymmdd');