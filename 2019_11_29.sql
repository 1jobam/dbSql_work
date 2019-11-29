-- �ǽ� (join 0_3)
-- emp, dept ���̺��� �̿��Ͽ� ������ ���� ��ȸ�ǵ��� ������ �ۼ��ϼ��� (�޿� 2500�ʰ�, ����� 7600���� ū ����)
--oracle ���
SELECT empno, ename, sal, s.deptno, dname
FROM emp a, dept s
WHERE a.deptno = s.deptno
AND empno > 7600
AND sal > 2500
ORDER BY deptno;

--ANSI SQL ���
SELECT a.empno, a.ename, sal, a.deptno, b.dname
FROM emp a JOIN dept b ON b.deptno = a.deptno AND empno > 7600 AND sal > 2500 ORDER BY deptno;

-- �ǽ� (join 0_4)
-- emp, dept ���̺��� �̿��Ͽ� ������ ���� ��ȸ�ǵ��� ������ �ۼ��ϼ���.
--(�޿� 2500�ʰ�, ����� 7600���� ũ�� �μ����� RESEARCH�� �μ��� ���� ����)
--oracle ���
SELECT empno, ename, sal, s.deptno, dname
FROM emp a, dept s
WHERE a.deptno = s.deptno
AND empno > 7600
AND sal > 2500
AND dname = 'RESEARCH'
ORDER BY deptno;

--ANSI SQL ���
SELECT a.empno, a.ename, sal, a.deptno, b.dname
FROM emp a JOIN dept b ON b.deptno = a.deptno AND empno > 7600 AND sal > 2500 AND dname ='RESEARCH' ORDER BY deptno;

-- (base_tables.sql, �ǽ� join1)

--ANSI SQL ���
SELECT lprod_gu, lprod_nm, prod_id, prod_name
FROM prod JOIN lprod ON prod_lgu = lprod_gu order by prod_id;

-- ORACLE ���

SELECT lprod_gu, lprod_nm, prod_id, prod_name
FROM prod, lprod
WHERE lprod_gu = prod_lgu
ORDER BY prod_id;

-- ( �ǽ� join2 )
-- erd ���̾�׷��� �����Ͽ� buyer, prod ���̺��� �����Ͽ� buyer�� ����ϴ� ��ǰ ������ ������ ���� ����� �������� ������ �ۼ��غ�����.
select * from buyer;
select * from prod;

--ANSI SQL ���
SELECT buyer_id, buyer_name, prod_id, prod_name
FROM buyer JOIN prod ON buyer_id = prod_buyer ORDER BY prod_id;

--ORACLE SQL ���
SELECT buyer_id, buyer_name, prod_id, prod_name
FROM buyer, prod
where buyer_id = prod_buyer
ORDER BY prod_id;

-- �ǽ� join3
-- erd ���̾�׷��� �����Ͽ� member, cart, prod ���̺��� �����Ͽ� ȸ���� ��ٱ��Ͽ� ���� ��ǰ ������ ������ ���� ����� ������ ���� �ۼ��ϱ�.

--ANSI SQL ���
select * from member; 
select * from cart;
select * from prod;


--ANSI SQL ���
SELECT c.mem_id, c.mem_name, a.prod_id, a.prod_name, b.cart_qty 
FROM prod a JOIN cart b ON prod_id = cart_prod JOIN member c ON c.mem_id = b.cart_member;


--ORACLE SQL ���
SELECT mem_id, mem_name, prod_id, prod_name, cart_qty 
FROM member,prod, cart 
where prod_id = cart_prod and mem_id = cart_member;

-- ( �ǽ� join 4)
-- erd ���̾�׷��� �����Ͽ� customer, cycle ���̺��� �����Ͽ� ���� ���� ��ǰ, ��������, ������ ������ ���� ����� �������� ������ �ۼ��غ�����.
-- (������ brwon, sally�� ���� ��ȸ)
select * from customer;
select * from cycle;

--oracle sql ���
SELECT a.cid, a.cnm, b.pid, b.day, b.cnt
FROM customer a, cycle b
where a.cid = b.cid
and cnm in('brown', 'sally');

--ansi sql ���
SELECT a.cid, a.cnm, b.pid, b.day, b.cnt
FROM customer a JOIN cycle b ON a.cid = b.cid WHERE cnm IN ('brown', 'sally');

-- (�ǽ� join 5)
-- erd ���̾�׷��� �����Ͽ� customer, cycle, product ���̺��� �����Ͽ� ���� ���� ��ǰ, ��������, ����, ��ǰ���� ������ ���� �����
-- �������� ������ �ۼ��غ�����(������ brown, sally�� ���� ��ȸ)
select * from customer;
select * from cycle;
select * from product;

--oracle sql ���
SELECT a.cid, a.cnm, b.pid, c.pnm, b.day, b.cnt 
FROM customer a, cycle b, product c
WHERE a.cid = b.cid AND b.pid = c.pid AND a.cnm IN('brown', 'sally');

--ansi sql ���
SELECT a.cid, a.cnm, b.pid, c.pnm, b.day, b.cnt
FROM customer a JOIN cycle b ON a.cid = b.cid JOIN product c ON b.pid = c.pid;

-- (�ǽ� join 6)
select * from customer;
select * from cycle;
select * from product;

--oracle sql ���
SELECT a.cid, a.cnm, b.pid, c.pnm, SUM(b.cnt) cnt
FROM customer a, cycle b, product c
WHERE a.cid = b.cid AND b.pid = c.pid
GROUP BY b.pid, a.cid, a.cnm, c.pnm, cnt;

--ansi sql ��� -- ȥ��
SELECT a.cid, a.cnm, b.pid, c.pnm, sum(b.cnt) 
FROM product c, customer a 
JOIN cycle b ON a.cid = b.cid 
WHERE b.pid = c.pid
GROUP BY a.cid, a.cnm, b.pid, c.pnm;

-- (�ǽ� join 7)
-- erd ���̾�׷��� �����Ͽ� cycle, product ���̺��� �̿��Ͽ� ��ǰ��, ������ �հ�, ��ǰ���� ������ ���� ����� �������� ������ �ۼ��غ�����.
-- oracle sql ���
SELECT a.pid, b.pnm, SUM(a.cnt)
FROM cycle a, product b
WHERE a.pid = b.pid
GROUP BY a.pid, b.pnm;

SELECT a.pid, b.pnm, sum(a.cnt) cnt
FROM product b
JOIN cycle a ON a.pid = b.pid
GROUP BY a.pid, b.pnm;




















