--OUTER join : ���� ���ῡ ���� �ϴ��� ������ �Ǵ� ���̺��� �����ʹ� �������� �ϴ� join
-- LEFT OUTER JOIN : ���̺�1 LEFT OUTER JOIN ���̺�2
-- ���̺� 1�� ���̺�2�� join�Ҷ� join�� �����ϴ��� ���̺�1�� �����ʹ� ��ȸ�� �ǵ��� �Ѵ�.
-- join�� ������ �࿡�� ���̺�2�� �÷����� �������� �����Ƿ� NULL�� ǥ�� �ȴ�.

--ANSI
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m
--FROM emp e JOIN emp m
            ON e.mgr = m.empno;
            
--
SELECT e.empno, e.ename, e.deptno, m.empno, m.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m
            ON e.mgr = m.empno AND m.deptno=10;
            
SELECT e.empno, e.ename, e.deptno, m.empno, m.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m
            ON e.mgr = m.empno WHERE m.deptno=10;
            
--ORACLE outer join syntax
--�Ϲ����ΰ� �������� �÷��m�� (+) ǥ��
-- (+) ǥ�� : �����Ͱ� �������� �ʴµ� ���;� �ϴ� ���̺��� �÷�
-- ���� LEFT OUTER JOIN �Ŵ���
--  ON(����.�ų�����ȣ = �Ŵ���.������ȣ)
-- ORACLE OUTER
-- WHERE ����.�Ŵ�����ȣ = �Ŵ���.������ȣ(+) --�Ŵ����� �����Ͱ� �������� ����
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+);


--�Ŵ��� �μ���ȣ ����
--ANSI SQL ���� WHERE ���� ����� ����
-- --> OUTER ������ ������� ���� ��Ȳ
-- �ƿ��� ������ ����Ǿ�� �Ǵ� ���̺��� ��� �÷��� (+)�� �پ�� �ȴ�. -- > ORACLE ����������
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno = 10;

--ANSI SQL�� on���� ����� ���� ����
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno(+) = 10;

--emp ���̺��� 14���� ������ �ְ� 14���� 10, 20, 30 �μ��߿� �� �μ��� ���Ѵ�
-- ������ dept ���̺��� 10, 20, 30, 40�� �μ��� ����
-- �μ���ȣ, �μ���, �ش�μ��� ���� �������� �������� ������ �ۼ�
select *
from emp;

-- ORACLE SQL ���
SELECT dept.deptno, dept.dname, NVL(emp_cnt.cnt, 0) cnt FROM dept,
(SELECT deptno, count(*) cnt FROM emp GROUP BY deptno) emp_cnt
WHERE dept.deptno = emp_cnt.deptno(+)
ORDER BY dept.deptno;

-- ANSI SQL ���
SELECT dept.deptno, dept.dname, NVL(emp_cnt.cnt, 0) cnt
FROM dept LEFT OUTER JOIN
(SELECT deptno, count(*) cnt FROM emp GROUP BY deptno) emp_cnt
ON(dept.deptno = emp_cnt.deptno);

-- ORACLE SQL ���
SELECT dept.deptno, dept.dname, count(emp.deptno) cnt
--count(*) cnt, count(dept.deptno) cnt
FROM emp, dept
WHERE emp.deptno(+) = dept.deptno
GROUP BY dept.deptno, dept.dname
ORDER BY dept.deptno;

-- ���⼺�� ����
--
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m
            ON e.mgr = m.empno;
            
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e RIGHT OUTER JOIN emp m
            ON e.mgr = m.empno;
            
--FULL OUTER : LEFT OUTER + RIGHT OUTER - �ߺ������� �ѰǸ� �����

-- (outer join �ǽ� outerjoin 1)
select * from buyprod;
select * from prod;

-- (oracle ���)
SELECT a.buy_date, a.buy_prod, b.prod_id, b.prod_name, a.buy_qty
FROM buyprod a, prod b
WHERE a.buy_prod(+) = b.prod_id
AND a.buy_date(+) = to_date('20050125', 'yyyymmdd');

-- (ANSI ���)
SELECT a.buy_date, a.buy_prod, b.prod_id, b.prod_name, a.buy_qty
FROM buyprod a RIGHT OUTER JOIN prod b ON a.buy_prod = b.prod_id 
AND a.buy_date = to_date('20050125', 'yyyymmdd');

-- (outer join �ǽ� outerjoin 2)

--(ANSI ���)
SELECT c.* FROM(SELECT NVL(a.buy_date, '2005/01/25'), a.buy_prod, b.prod_id, b.prod_name, a.buy_qty
FROM buyprod a RIGHT OUTER JOIN prod b ON a.buy_prod = b.prod_id
AND TO_DATE(TO_CHAR(a.buy_date, 'YY/MM/DD'), 'YY/MM/DD') = '20050125')c;

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

-- (outer join �ǽ� outerjoin 5)
select * from cycle;
select * from product;
select * from customer;

--(ANSI ���)
SELECT b.pid, b.pnm, NVL(a.cid, 1) cid, NVL(c.cnm, 'brown') cnm, NVL(a.day, 0) day, NVL(a.cnt, 0) cnt 
FROM cycle a RIGHT OUTER JOIN product b ON a.pid = b.pid AND a.cid = 1 LEFT OUTER JOIN customer c ON a.cid = c.cid ORDER BY b.pid desc;

-- oracle ���
SELECT a.pid, a.pnm, a.cid, customer.cnm, a.day, a.cnt FROM
(SELECT product.pid, product.pnm,
        :cid cid, NVL(cycle.day, 0) day, NVL(cycle.cnt, 0) cnt
        FROM cycle, product
        WHERE cycle.cid(+) = :cid
        AND cycle.pid(+) = product.pid) a, customer
WHERE a.cid = customer.cid;