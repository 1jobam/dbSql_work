-- ** 과제 **

-- (실습 select 1)
select * from lprod;

select buyer_id, buyer_name from buyer;

select * from cart;

select mem_id, mem_pass, mem_name from member;

-- (실습 select 2)
select prod_id id, prod_name name from prod;

select lprod_gu as gu, lprod_nm as nm from lprod;

select buyer_id as 바이어아이디, buyer_name 이름 from buyer;

-- (실습 sel_con1)
select 'select * from ' || table_name || ';' as querry from user_tables;