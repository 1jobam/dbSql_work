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

-- ORACLE 방식

SELECT lprod_gu, lprod_nm, prod_id, prod_name
FROM prod, lprod
WHERE lprod_gu = prod_lgu
ORDER BY prod_id;

-- ( 실습 join2 )
-- erd 다이어그램을 참고하여 buyer, prod 테이블을 조인하여 buyer별 담당하는 제품 정보를 다음과 같은 결과가 나오도록 쿼리를 작성해보세요.
select * from buyer;
select * from prod;

--ANSI SQL 방식
SELECT buyer_id, buyer_name, prod_id, prod_name
FROM buyer JOIN prod ON buyer_id = prod_buyer ORDER BY prod_id;

--ORACLE SQL 방식
SELECT buyer_id, buyer_name, prod_id, prod_name
FROM buyer, prod
where buyer_id = prod_buyer
ORDER BY prod_id;

-- 실습 join3
-- erd 다이어그램을 참고하여 member, cart, prod 테이블을 조인하여 회원별 장바구니에 담은 제품 정보를 다음과 같은 결과가 나오는 쿼리 작성하기.

--ANSI SQL 방식
select * from member; 
select * from cart;
select * from prod;


--ANSI SQL 방식
SELECT c.mem_id, c.mem_name, a.prod_id, a.prod_name, b.cart_qty 
FROM prod a JOIN cart b ON prod_id = cart_prod JOIN member c ON c.mem_id = b.cart_member;


--ORACLE SQL 방식
SELECT mem_id, mem_name, prod_id, prod_name, cart_qty 
FROM member,prod, cart 
where prod_id = cart_prod and mem_id = cart_member;

-- ( 실습 join 4)
-- erd 다이어그램을 참고하여 customer, cycle 테이블을 조인하여 고객별 애음 제품, 애음요일, 개수를 다음과 같은 결과가 나오도록 쿼리를 작성해보세요.
-- (고객명이 brwon, sally인 고객만 조회)
select * from customer;
select * from cycle;

--oracle sql 방식
SELECT a.cid, a.cnm, b.pid, b.day, b.cnt
FROM customer a, cycle b
where a.cid = b.cid
and cnm in('brown', 'sally');

--ansi sql 방식
SELECT a.cid, a.cnm, b.pid, b.day, b.cnt
FROM customer a JOIN cycle b ON a.cid = b.cid WHERE cnm IN ('brown', 'sally');

-- (실습 join 5)
-- erd 다이어그램을 참고하여 customer, cycle, product 테이블을 조인하여 고객별 애음 제품, 애음요일, 개수, 제품명을 다음과 같은 결과가
-- 나오도록 쿼리를 작성해보세요(고객명이 brown, sally인 고객만 조회)
select * from customer;
select * from cycle;
select * from product;

--oracle sql 방식
SELECT a.cid, a.cnm, b.pid, c.pnm, b.day, b.cnt 
FROM customer a, cycle b, product c
WHERE a.cid = b.cid AND b.pid = c.pid AND a.cnm IN('brown', 'sally');

--ansi sql 방식
SELECT a.cid, a.cnm, b.pid, c.pnm, b.day, b.cnt
FROM customer a JOIN cycle b ON a.cid = b.cid JOIN product c ON b.pid = c.pid;

-- (실습 join 6)
select * from customer;
select * from cycle;
select * from product;

--oracle sql 방식
SELECT a.cid, a.cnm, b.pid, c.pnm, SUM(b.cnt) cnt
FROM customer a, cycle b, product c
WHERE a.cid = b.cid AND b.pid = c.pid
GROUP BY b.pid, a.cid, a.cnm, c.pnm, cnt;

--ansi sql 방식 -- 혼종
SELECT a.cid, a.cnm, b.pid, c.pnm, sum(b.cnt) 
FROM product c, customer a 
JOIN cycle b ON a.cid = b.cid 
WHERE b.pid = c.pid
GROUP BY a.cid, a.cnm, b.pid, c.pnm;

-- (실습 join 7)
-- erd 다이어그램을 참고하여 cycle, product 테이블을 이용하여 제품별, 개수의 합과, 제품명을 다음과 같은 결과가 나오도록 쿼리를 작성해보세요.
-- oracle sql 방식
SELECT a.pid, b.pnm, SUM(a.cnt)
FROM cycle a, product b
WHERE a.pid = b.pid
GROUP BY a.pid, b.pnm;

SELECT a.pid, b.pnm, sum(a.cnt) cnt
FROM product b
JOIN cycle a ON a.pid = b.pid
GROUP BY a.pid, b.pnm;




















