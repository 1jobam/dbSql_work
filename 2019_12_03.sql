-- (outer join 실습 outerjoin 1)
select * from buyprod;
select * from prod;

-- (oracle 방식)
SELECT a.buy_date, a.buy_prod, b.prod_id, b.prod_name, a.buy_qty
FROM buyprod a, prod b
WHERE a.buy_prod(+) = b.prod_id
AND a.buy_date(+) = to_date('20050125', 'yyyymmdd');

-- (outer join 실습 outerjoin 2)
--(ANSI 방식)
SELECT c.* FROM(SELECT NVL(a.buy_date, '2005/01/25'), a.buy_prod, b.prod_id, b.prod_name, a.buy_qty
FROM buyprod a RIGHT OUTER JOIN prod b ON a.buy_prod = b.prod_id
AND TO_DATE(TO_CHAR(a.buy_date, 'YY/MM/DD'), 'YY/MM/DD') = '20050125')c;

-- oracle 방식
SELECT TO_DATE('20050125', 'yyyymmdd'), buydate, buyprod.buy_prod, prod.prod_id, prod.prod_name, buyprod.buy_qty
FROM buyprod, prod
WHERE buyprod.buy_date(+) = TO_DATE(yyyymmdd, 'yyyymmdd')
AND prod.prod_id = buyprod.buy_prod(+);

-- (outer join 실습 outerjoin 3)

--(ANSI 방식)
SELECT c.* FROM(SELECT NVL(a.buy_date, '2005/01/25'), a.buy_prod, b.prod_id, b.prod_name, NVL(a.buy_qty, 0)
FROM buyprod a RIGHT OUTER JOIN prod b ON a.buy_prod = b.prod_id
AND TO_DATE(TO_CHAR(a.buy_date, 'YY/MM/DD'), 'YY/MM/DD') = '20050125')c;

-- (outer join 실습 outerjoin 4)
select * from cycle;
select * from product;

--(ANSI 방식)
SELECT b.pid, b.pnm, NVL(a.cid, 1) cid, NVL(a.day, 0) day, NVL(a.cnt, 0) cnt 
FROM cycle a RIGHT OUTER JOIN product b ON a.pid = b.pid AND a.cid = 1;

--oracle 방식
SELECT  product.pid, product.pnm, :cid cid, NVL(cycle.day, 0) day, NVL(cycle.cnt, 0) cnt
FROM cycle, product
WHERE cycle.cid(+) = 1
AND cycle.pid(+) = product.pid;

-- (outer join 실습 outerjoin 5)
select * from cycle;
select * from product;
select * from customer;

--(ANSI 방식)
SELECT b.pid, b.pnm, NVL(a.cid, 1) cid, NVL(c.cnm, 'brown') cnm, NVL(a.day, 0) day, NVL(a.cnt, 0) cnt 
FROM cycle a RIGHT OUTER JOIN product b ON a.pid = b.pid AND a.cid = 1 LEFT OUTER JOIN customer c ON a.cid = c.cid ORDER BY b.pid desc;


--(cross join 실습 crossjoin1)
--ORACLE SQL
SELECT *
FROM customer, product;

--ANSI SQL
SELECT *
FROM customer CROSS JOIN product;

--도시발전지수
select *
from fastfood
WHERE sido = '대전광역시';

--도시발전지수가 높은 순으로 나열
--도시발전지수 = (버거킹개수 + KFC개수 + 맥도날드 개수) / 롯데리아 개수
--순위 / 시도 / 시군구 / 도시발전지수 (소수점 둘째 짜리에서 반올림)
-- 1 / 서울특별시 / 서초구 / 7.5
-- 2 / 서울특별시 / 강남구 / 7.2
select * from fastfood;
select * from fastfood where sigungu like '%서구%' AND gb like '맥도%';

--해당 시도, 시군구별 프렌차이즈별 건수가 필요
SELECT ROWNUM rn, sido, sigungu, 도시발전지수
FROM
(SELECT a.sido, a.sigungu, round(a.cnt/b.cnt, 1) 도시발전지수
FROM
(SELECT sido, sigungu, count(*) cnt --버거킹, KFC, 맥도날드 건수
FROM fastfood
WHERE gb IN ('KFC', '버거킹', '맥도날드')
GROUP BY sido, sigungu)a,
(SELECT sido, sigungu, count(*) cnt --롯데리아 건수
FROM fastfood
WHERE gb IN ('롯데리아')
GROUP BY sido, sigungu)b
WHERE a.sido = b.sido
AND a.sigungu = b.sigungu
ORDER BY 도시발전지수 desc) c;



--하나의 SQL로 작성하지 마세요
--fastfood 테이블을 이용하여 여러번의 sql 실행 결과를
--손으로 계산해서 도시 발전지수를 계산
--대전시 유성구 10/3 = 3.3
--대전시 동구 4/8 = 0.5
--대전시 서구 17/12 = 1.4
--대전시 중구 7/6 = 1.2
--대전시 대덕구 2/7 = 0.3

select rownum "갯수", a.*from
(select sido 시도, sigungu 시군구, gb 명칭, count(gb) 점
from fastfood 
WHERE sido = '대전광역시'
AND sigungu = '동구'
AND gb not in('맘스터치', '파파이스') 
GROUP BY sido, sigungu, gb
ORDER BY gb desc) a;