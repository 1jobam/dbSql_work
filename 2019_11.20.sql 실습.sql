column alias (실습 select2)

-- prod 테이블에서 prod_id, prod_name 두 컬럼을 조회하는 쿼리를 작성하시오
--(단 prod_id -> id, prod_name -> name 으로 컬럼 별칭을 지정)
select prod_id id, prod_name name from prod;

-- lprod 테이블에서 lprod_gu, lprod_nm 두 컬럼을 조회하는 쿼리를 작성하시오.
--(단 lprod_gu -> gu, lprod_nm -> nm 으로 컬럼 별칭을 지정)
select lprod_gu gu, lprod_nm as nm from lprod;

-- buyer 테이블에서 buyer_id, buyer_name 두 컬럼을 조회하는 쿼리를 작성하시오.
--(단 buyer_id -> 바이어아이디, buyer_name -> 이름 으로 컬럼 별칭을 지정)
select buyer_id as 바이어아이디, buyer_name as 이름 from buyer;


