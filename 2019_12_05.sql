-- �ǽ� sub4 �ǽ�
-- dept ���̺��� �ű� ��ϵ� 99�� �μ��� ���� ����� ���� ������ ������ ���� �μ��� ��ȸ�ϴ� ������ �ۼ��غ�����.
select * from dept;
select * from emp;

--������ �������� �ʴ� ����
SELECT deptno, dname, loc
FROM dept
WHERE deptno NOT IN(SELECT deptno FROM emp);

-- ������ �����ϴ� ����
SELECT *
FROM dept
WHERE deptno IN (SELECT deptno FROM emp);

-- �ǽ� sub5
-- cycle, product ���̺��� �̿��Ͽ� cid = 1�� ���� �������� �ʴ� ��ǰ�� ��ȸ�ϴ� ������ �ۼ��ϼ���.
select * from cycle;
select * from product;

SELECT pid, pnm
FROM product
WHERE pid NOT IN (SELECT pid FROM cycle WHERE cid = 1);

-- �ǽ� sub6
-- cucle ���̺��� �̿��Ͽ� cid = 2�� ���� �����ϴ� ��ǰ�� cid = 1�� ���� �����ϴ� ��ǰ�� ���������� ��ȸ�ϴ� ������ �ۼ��ϼ���.
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


-- �ǽ� sub7
--customer, cycle, product ���̺��� �̿��Ͽ� cid = 2 �� ���� �����ϴ� ��ǰ�� cid =1 �� ���� �����ϴ� ��ǰ��
--���������� ��ȸ�ϰ� ����� ��ǰ����� �����ϴ� ������ �ۼ��ϼ���
select * from customer;
select * from cycle;
select * from product;

SELECT a.cid, a.cnm, b.pid, c.pnm, b.day, b.cnt
FROM customer a, cycle b, product c
WHERE b.pid IN 
                (SELECT pid FROM cycle WHERE cid = 2) -- �������� �˷��ֽ� ���� AS ���ʿ�� ����.
AND a.cid = 1
AND a.cid = b.cid
AND b.pid = c.pid;

--�Ŵ����� �����ϴ� ���� ���� ��ȸ
select * from emp;

SELECT *
FROM emp e
WHERE EXISTS (SELECT 1
                FROM emp m
                WHERE m.empno = e.mgr);
                
-- �������� (EXISTS ������ - �ǽ� sub 8)
-- �Ʒ� ������ subquery�� ������� �ʰ� �ۼ��ϼ���.
select * from emp;

SELECT a.* 
FROM emp a, emp b
WHERE b.empno = a.mgr;

SELECT * 
FROM emp
WHERE mgr IS NOT NULL;

-- �Ŵ����� ���� �����
SELECT * 
FROM emp
WHERE mgr IS NULL;

-- �������� (�ǽ� sub 9)
select * from cycle;
select * from product;

--�����ϴ� ��ǰ
SELECT *
FROM product a
WHERE EXISTS (SELECT 'x' FROM cycle b WHERE a.pid = b.pid AND b.cid = 1);

--�������� (�ǽ� sub 10)
--�������� �ʴ� ��ǰ
SELECT *
FROM product a
WHERE NOT EXISTS (SELECT 'x' FROM cycle b WHERE a.pid = b.pid AND b.cid = 1);

-- ���տ���
--UNION : ������, �� ������ �ߺ����� �����Ѵ�.
--�������� SALESMAN�� ������ ������ȣ, ���� �̸� ��ȸ
--�� �Ʒ� ������� �����ϱ� ������ ������ ������ �ϰ� �ɰ��
--�ߺ��Ǵ� �����ʹ� �ѹ��� ǥ���Ѵ�.
SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN'

UNION

SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN';

--���� �ٸ� ������ ������
SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN'

UNION

SELECT empno, ename
FROM emp
WHERE job = 'CLERK';

--UNION ALL
--������ ����� �ߺ� ���Ÿ� ���� �ʴ´�.
--���Ʒ� ��� ���� �ٿ� �ֱ⸸ �Ѵ�.
SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN'

UNION ALL

SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN';

--���տ���� ���ռ��� �÷��� ���� �ؾ��Ѵ�.
--�÷��� ������ �ٸ���� ������ ���� �ִ� ������� ������ �����ش�.
SELECT empno, ename, ''
FROM emp
WHERE job = 'SALESMAN'

UNION ALL

SELECT empno, ename, job
FROM emp
WHERE job = 'SALESMAN';

-- INTERSECT : ������
--�� ���հ� �������� �����͸� ��ȸ
SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN', 'CLERK')

INTERSECT

SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN');

--MINUS
--������ : ��, �Ʒ� ������ �������� �� ���տ��� ������ ������ ��ȸ
--�������� ��� ������, �����հ� �ٸ��� ������ ���� ������ ��� ���տ� ������ �ش�.
SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN', 'CLERK')

MINUS

SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN');

--ORDER BY ����

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
-- INSERT : ���̺� ���ο� �����͸� �Է�
select * from dept;

--INSERT �� �÷��� ������ ���
--������ �÷��� ���� �Է��� ���� ������ ������ ����Ѵ�.
--INSERT INTO ���̺�� (�÷�1, �÷�2....)
--              VALUES (��1, ��2....)
--dept ���̺� 99�� �μ���ȣ, ddit ������, daejoen �̶�� �������� ���� �����͸� �Է��غ���.
select * from dept;
INSERT INTO dept (deptno, dname, loc)
            VALUES (99, 'ddit', 'daejeon');

--�÷��� ����� ��� ���̺��� �÷� ���� ������ �ٸ��� �����ص� ����� ����.
--dept ���̺��� �÷� ���� : deptno, dname, location
INSERT INTO dept (loc, deptno, dname)
            VALUES ('daejeon', '99', 'ddit');
            
--�÷��� ������� �ʴ°�� : ���̺��� �÷� ���� ������ ���� ���� ����Ѵ�.
desc dept;
INSERT INTO dept VALUES (99, 'ddit', 'daejeon');
            
--��¥ �� �Է��ϱ�
--1. SYSDATE
--2. ����ڷ� ���� ���� ���ڿ��� DATE Ÿ������ �����Ͽ� �Է�
desc emp;
INSERT INTO emp VALUES (9998, 'sally', 'SALESMAN', NULL, SYSDATE, 500, NULL, NULL);
select * from emp WHERE empno = 9998;

--2019�� 12�� 2�� �Ի�
INSERT INTO emp VALUES (9997, 'james', 'CLERK', NULL, TO_DATE('20191202', 'yyyymmdd'), 500, NULL, NULL);
select * from emp WHERE empno = 9997;

--�������� �����͸� �ѹ��� �Է�
--SELECT ����� ���̺� �Է� �� �� �ִ�.
-- ���Ͽ�Ȱ���Ͽ� INSERT �Ҽ��� ����.
INSERT INTO emp
SELECT 9998, 'sally', 'SALESMAN', NULL, SYSDATE, 500, NULL, NULL 
FROM dual
UNION ALL
SELECT 9997, 'james', 'CLERK', NULL, TO_DATE('20191202', 'yyyymmdd'), 500, NULL, NULL
FROM dual;

select * from emp where empno in(9998, 9997);


