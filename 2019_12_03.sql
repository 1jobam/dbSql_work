-- (outer join �ǽ� outerjoin 1)
select * from buyprod;
select * from prod;

-- (oracle ���)
SELECT a.buy_date, a.buy_prod, b.prod_id, b.prod_name, a.buy_qty
FROM buyprod a, prod b
WHERE a.buy_prod(+) = b.prod_id
AND a.buy_date(+) = to_date('20050125', 'yyyymmdd');

-- (outer join �ǽ� outerjoin 2)
--(ANSI ���)
SELECT c.* FROM(SELECT NVL(a.buy_date, '2005/01/25'), a.buy_prod, b.prod_id, b.prod_name, a.buy_qty
FROM buyprod a RIGHT OUTER JOIN prod b ON a.buy_prod = b.prod_id
AND TO_DATE(TO_CHAR(a.buy_date, 'YY/MM/DD'), 'YY/MM/DD') = '20050125')c;

-- oracle ���
SELECT TO_DATE('20050125', 'yyyymmdd'), buydate, buyprod.buy_prod, prod.prod_id, prod.prod_name, buyprod.buy_qty
FROM buyprod, prod
WHERE buyprod.buy_date(+) = TO_DATE(yyyymmdd, 'yyyymmdd')
AND prod.prod_id = buyprod.buy_prod(+);

-- (outer join �ǽ� outerjoin 3)

--(ANSI ���)
SELECT c.* FROM(SELECT NVL(a.buy_date, '2005/01/25'), a.buy_prod, b.prod_id, b.prod_name, NVL(a.buy_qty, 0)
FROM buyprod a RIGHT OUTER JOIN prod b ON a.buy_prod = b.prod_id
AND TO_DATE(TO_CHAR(a.buy_date, 'YY/MM/DD'), 'YY/MM/DD') = '20050125')c;

-- (outer join �ǽ� outerjoin 4)
select * from cycle;
select * from product;

--(ANSI ���)
SELECT b.pid, b.pnm, NVL(a.cid, 1) cid, NVL(a.day, 0) day, NVL(a.cnt, 0) cnt 
FROM cycle a RIGHT OUTER JOIN product b ON a.pid = b.pid AND a.cid = 1;

--oracle ���
SELECT  product.pid, product.pnm, :cid cid, NVL(cycle.day, 0) day, NVL(cycle.cnt, 0) cnt
FROM cycle, product
WHERE cycle.cid(+) = 1
AND cycle.pid(+) = product.pid;

-- (outer join �ǽ� outerjoin 5)
select * from cycle;
select * from product;
select * from customer;

--(ANSI ���)
SELECT b.pid, b.pnm, NVL(a.cid, 1) cid, NVL(c.cnm, 'brown') cnm, NVL(a.day, 0) day, NVL(a.cnt, 0) cnt 
FROM cycle a RIGHT OUTER JOIN product b ON a.pid = b.pid AND a.cid = 1 LEFT OUTER JOIN customer c ON a.cid = c.cid ORDER BY b.pid desc;


--(cross join �ǽ� crossjoin1)
--ORACLE SQL
SELECT *
FROM customer, product;

--ANSI SQL
SELECT *
FROM customer CROSS JOIN product;

--���ù�������
select *
from fastfood
WHERE sido = '����������';

--���ù��������� ���� ������ ����
--���ù������� = (����ŷ���� + KFC���� + �Ƶ����� ����) / �Ե����� ����
--���� / �õ� / �ñ��� / ���ù������� (�Ҽ��� ��° ¥������ �ݿø�)
-- 1 / ����Ư���� / ���ʱ� / 7.5
-- 2 / ����Ư���� / ������ / 7.2
select * from fastfood;
select * from fastfood where sigungu like '%����%' AND gb like '�Ƶ�%';

--�ش� �õ�, �ñ����� ��������� �Ǽ��� �ʿ�
SELECT ROWNUM rn, sido, sigungu, ���ù�������
FROM
(SELECT a.sido, a.sigungu, round(a.cnt/b.cnt, 1) ���ù�������
FROM
(SELECT sido, sigungu, count(*) cnt --����ŷ, KFC, �Ƶ����� �Ǽ�
FROM fastfood
WHERE gb IN ('KFC', '����ŷ', '�Ƶ�����')
GROUP BY sido, sigungu)a,
(SELECT sido, sigungu, count(*) cnt --�Ե����� �Ǽ�
FROM fastfood
WHERE gb IN ('�Ե�����')
GROUP BY sido, sigungu)b
WHERE a.sido = b.sido
AND a.sigungu = b.sigungu
ORDER BY ���ù������� desc) c;



--�ϳ��� SQL�� �ۼ����� ������
--fastfood ���̺��� �̿��Ͽ� �������� sql ���� �����
--������ ����ؼ� ���� ���������� ���
--������ ������ 10/3 = 3.3
--������ ���� 4/8 = 0.5
--������ ���� 17/12 = 1.4
--������ �߱� 7/6 = 1.2
--������ ����� 2/7 = 0.3

select rownum "����", a.*from
(select sido �õ�, sigungu �ñ���, gb ��Ī, count(gb) ��
from fastfood 
WHERE sido = '����������'
AND sigungu = '����'
AND gb not in('������ġ', '�����̽�') 
GROUP BY sido, sigungu, gb
ORDER BY gb desc) a;