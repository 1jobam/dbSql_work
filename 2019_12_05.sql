-- 실습 sub4 실습
-- dept 테이블에는 신규 등록된 99번 부서에 속한 사람은 없음 직원이 속하지 않은 부서를 조회하는 쿼리를 작성해보세요.
select * from dept;
select * from emp;

--직원이 존재하지 않는 정보
SELECT deptno, dname, loc
FROM dept
WHERE deptno NOT IN(SELECT deptno FROM emp);

-- 직원이 존재하는 정보
SELECT *
FROM dept
WHERE deptno IN (SELECT deptno FROM emp);

-- 실습 sub5
-- cycle, product 테이블을 이용하여 cid = 1인 고객이 애음하지 않는 제품을 조회하는 쿼리를 작성하세요.
select * from cycle;
select * from product;

SELECT pid, pnm
FROM product
WHERE pid NOT IN (SELECT pid FROM cycle WHERE cid = 1);

-- 실습 sub6
-- cucle 테이블을 이용하여 cid = 2인 고객이 애음하는 제품중 cid = 1인 고객도 애음하는 제품의 애음정보를 조회하는 쿼리를 작성하세요.
select * from cycle;

SELECT *
FROM cycle
WHERE pid IN (SELECT pid FROM cycle WHERE cid = 2)
AND cid = 1;

SELECT *
FROM cycle
WHERE cid = 1
AND pid IN (SELECT pid
            FROM cycle
            WHERE cid = 2);


-- 실습 sub7
--customer, cycle, product 테이블을 이용하여 cid = 2 인 고객이 애음하는 제품중 cid =1 인 고객도 애음하는 제품의
--애음정보를 조회하고 고객명과 제품명까지 포함하는 쿼리를 작성하세요
select * from customer;
select * from cycle;
select * from product;

SELECT a.cid, a.cnm, b.pid, c.pnm, b.day, b.cnt
FROM customer a, cycle b, product c
WHERE b.pid IN 
                (SELECT pid FROM cycle WHERE cid = 2) -- 옆에분이 알려주심 굳이 AS 줄필요는 없다.
AND a.cid = 1
AND a.cid = b.cid
AND b.pid = c.pid;

--매니저가 존재하는 직원 정보 조회
select * from emp;

SELECT *
FROM emp e
WHERE EXISTS (SELECT 1
                FROM emp m
                WHERE m.empno = e.mgr);
                
-- 서브쿼리 (EXISTS 연산자 - 실습 sub 8)
-- 아래 쿼리를 subquery를 사용하지 않고 작성하세요.
select * from emp;

SELECT a.* 
FROM emp a, emp b
WHERE b.empno = a.mgr;

SELECT * 
FROM emp
WHERE mgr IS NOT NULL;

-- 매니저가 없는 사람들
SELECT * 
FROM emp
WHERE mgr IS NULL;

-- 서브쿼리 (실습 sub 9)
select * from cycle;
select * from product;

--애음하는 제품
SELECT *
FROM product a
WHERE EXISTS (SELECT 'x' FROM cycle b WHERE a.pid = b.pid AND b.cid = 1);

--서브쿼리 (실습 sub 10)
--애음하지 않는 제품
SELECT *
FROM product a
WHERE NOT EXISTS (SELECT 'x' FROM cycle b WHERE a.pid = b.pid AND b.cid = 1);

-- 집합연산
--UNION : 합집합, 두 집합의 중복건은 제거한다.
--담당업무가 SALESMAN인 직원의 직원번호, 직원 이름 조회
--우 아래 결과셋이 동일하기 때문에 합집합 연산을 하게 될경우
--중복되는 데이터는 한번만 표현한다.
SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN'

UNION

SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN';

--서로 다른 집합의 합집합
SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN'

UNION

SELECT empno, ename
FROM emp
WHERE job = 'CLERK';

--UNION ALL
--합집합 연산시 중복 제거를 하지 않는다.
--위아래 결과 셋을 붙여 주기만 한다.
SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN'

UNION ALL

SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN';

--집합연산시 집합셋의 컬럼이 동일 해야한다.
--컬럼의 개수가 다를경우 임의의 값을 넣는 방식으로 개수를 맞춰준다.
SELECT empno, ename, ''
FROM emp
WHERE job = 'SALESMAN'

UNION ALL

SELECT empno, ename, job
FROM emp
WHERE job = 'SALESMAN';

-- INTERSECT : 교집합
--두 집합간 공통적인 데이터만 조회
SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN', 'CLERK')

INTERSECT

SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN');

--MINUS
--차집합 : 위, 아래 집합의 교집합을 위 집합에서 제거한 집합을 조회
--차집합의 경우 합집합, 교집합과 다르게 집합의 선언 순서가 결과 집합에 영향을 준다.
SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN', 'CLERK')

MINUS

SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN');

--ORDER BY 설정

SELECT empno, ename
FROM

(SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN', 'CLERK')
ORDER BY job)

UNION ALL

SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN')
ORDER BY ename;

-- DML
-- INSERT : 테이블에 새로운 데이터를 입력
select * from dept;

--INSERT 시 컬럼을 나열한 경우
--나열한 컬럼에 맞춰 입력할 값을 동일한 순서로 기술한다.
--INSERT INTO 테이블명 (컬럼1, 컬럼2....)
--              VALUES (값1, 값2....)
--dept 테이블에 99번 부서번호, ddit 조직명, daejoen 이라는 지역명을 갖는 데이터를 입력해보자.
select * from dept;
INSERT INTO dept (deptno, dname, loc)
            VALUES (99, 'ddit', 'daejeon');

--컬럼을 기술할 경우 테이블의 컬럼 정의 순서와 다르게 나열해도 상관이 없다.
--dept 테이블의 컬럼 순서 : deptno, dname, location
INSERT INTO dept (loc, deptno, dname)
            VALUES ('daejeon', '99', 'ddit');
            
--컬럼을 기술하지 않는경우 : 테이블의 컬럼 정의 순서에 맞춰 값을 기술한다.
desc dept;
INSERT INTO dept VALUES (99, 'ddit', 'daejeon');
            
--날짜 값 입력하기
--1. SYSDATE
--2. 사용자로 부터 받은 문자열을 DATE 타입으로 변경하여 입력
desc emp;
INSERT INTO emp VALUES (9998, 'sally', 'SALESMAN', NULL, SYSDATE, 500, NULL, NULL);
select * from emp WHERE empno = 9998;

--2019년 12월 2일 입사
INSERT INTO emp VALUES (9997, 'james', 'CLERK', NULL, TO_DATE('20191202', 'yyyymmdd'), 500, NULL, NULL);
select * from emp WHERE empno = 9997;

--여러건의 데이터를 한번에 입력
--SELECT 결과를 테이블에 입력 할 수 있다.
-- 유니온활용하여 INSERT 할수도 있음.
INSERT INTO emp
SELECT 9998, 'sally', 'SALESMAN', NULL, SYSDATE, 500, NULL, NULL 
FROM dual
UNION ALL
SELECT 9997, 'james', 'CLERK', NULL, TO_DATE('20191202', 'yyyymmdd'), 500, NULL, NULL
FROM dual;

select * from emp where empno in(9998, 9997);


