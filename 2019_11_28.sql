-- emp ���̺�, dept ���̺� ����

EXPLAIN PLAN FOR;
SELECT ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno != dept.deptno -- �����
AND emp.deptno = 10;

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

-- �ڽ� - �θ� - 0 ����

SELECT ename, deptno
FROM emp;

SELECT deptno, dname
FROM dept;

-- natural join : ���� ���̺� ���� Ÿ��, �����̸��� �÷�����
--                  ���� ���� ���� ��� ����

DESC emp;
DESC dept;

SELECT *
FROM emp NATURAL JOIN dept;

--ANSI SQL
SELECT deptno, emp.empno, ename
FROM emp NATURAL JOIN dept;

--oracle ����
SELECT emp.deptno, emp.empno, ename
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--��Ī �ִ°͵�����
SELECT a.deptno, empno, ename
FROM emp a, dept b
WHERE a.deptno = b.deptno;

-- JOIN USINC
-- join �Ϸ����ϴ� ���̺� ������ �̸��� �÷��� �ΰ� �̻��� ��
-- join �÷��� �ϳ��� ����ϰ� ���� ��

--ANSI SQL
SELECT *
FROM emp JOIN dept USING (deptno);

--ORACLE SQL
SELECT *
FROM emp a, dept b
WHERE a.deptno = b.deptno;


-- ��� ������ �� �� ��ȸ
SELECT *
FROM emp, dept;

SELECT *
FROM emp, dept
WHERE 1 = 1;

--ANSI JOIN with ON
--���� �ϰ��� �ϴ� ���̺��� �÷� �̸��� �ٸ� ��
--�����ڰ� ���� ������ ���� ������ ��

SELECT *
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

--oracle
SELECT *
FROM emp a, dept b
WHERE a.deptno = b.deptno;

-- SELF JOIN : ���� ���̺� ����
-- emp ���̺� ���� �Ҹ��� ���� : ������ ������ ���� ��ȸ
-- ������ ������ ������ ��ȸ
-- �����̸�, �������̸�

-- ANSI
SELECT e.ename, m.ename
FROM emp e JOIN emp m ON(e.mgr = m.empno);

-- ORACLE
SELECT e.ename, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;


--���� �̸�, ������ ����� �̸�, ������ ������� ����� �̸�, ������ ������� ������� ����� �̸�
--ANSI SQL
SELECT e.ename, m.ename, t.ename, k.ename
FROM emp e JOIN emp m ON(e.mgr = m.empno)
    JOIN emp t ON (m.mgr = t.empno)
        JOIN emp k ON (t.mgr = k.empno);

-- ORACLE 
SELECT e.ename, m.ename, d.ename, nvlt.ename
FROM emp e, emp m, emp d, emp t
WHERE e.mgr = m.empno
AND m.mgr = d.empno
AND d.mgr = t.empno;

SELECT e.ename, m.ename, d.ename, t.ename
FROM emp e, emp m, emp d, emp t
WHERE e.mgr = m.empno
AND m.mgr = d.empno
AND d.mgr = t.empno;

-- dept 4 * 4 * 4 =
SELECT * 
FROM dept a, dept s, dept d;

-- ������ �̸���, �ش� ������ ������ �̸��� ��ȸ�Ѵ�.
-- �� ������ ����� 7369~7698�� ������ ������� ��ȸ
-- ANSI SQL
SELECT a.ename, b.ename
FROM emp a JOIN emp b ON (a.mgr = b.empno)
WHERE a.empno BETWEEN 7369 AND 7698;

--oarcle sql

SELECT s.ename, m.ename
FROM emp s, emp m
WHERE s.empno BETWEEN 7369 AND 7698
AND s.mgr = m.empno;

-- NON-EQUI JOIN : ���� ������ = (equal)�� �ƴ� JOIN
-- != , BETWEEN AND

SELECT *
FROM salgrade;

SELECT empno, ename, sal /* �޿� grade */
FROM emp;

--oracle  
SELECT b.grade, a.ename, a.sal, b.losal, b.hisal
FROM emp a, salgrade b
where a.sal BETWEEN losal and hisal;

--ANSI SQL
SELECT a.grade, a.losal, a.hisal, b.ename, b.sal
FROM emp b JOIN salgrade a ON b.sal BETWEEN a.losal AND a.hisal;

-- �ǽ� ( join 0)
-- emp, dept ���̺��� �̿��Ͽ� ������ ���� ��ȸ�ǵ��� ������ �ۼ��ϼ���.
--oracle ���
SELECT empno, ename, s.deptno, dname
FROM emp a, dept s
where a.deptno = s.deptno
ORDER BY a.deptno;

-ANSI SQL ���
SELECT a.empno, a.ename, a.deptno, b.dname
FROM emp a JOIN dept b ON b.deptno = a.deptno ORDER BY a.deptno;

-- �ǽ� (join 0_1)
--emp, dept ���̺��� �̿��Ͽ� ������ ���� ��ȸ�ǵ��� ������ �ۼ��ϼ���.
--oracle ���
SELECT empno, ename, s.deptno, dname
FROM emp a, dept s
WHERE a.deptno = s.deptno
AND a.deptno in(10, 30);

--ANSI SQL ���
SELECT a.empno, a.ename, a.deptno, b.dname
FROM emp a JOIN dept b ON b.deptno = a.deptno AND a.deptno in(10, 30);

-- �ǽ� (join 0_2)
-- emp, dept ���̺��� �̿��Ͽ� ������ ���� ��ȸ�ǵ��� ������ �ۼ��ϼ���. (�޿��� 2500 �ʰ�)
--oracle ���
SELECT empno, ename, sal, s.deptno, dname
FROM emp a, dept s
WHERE a.deptno = s.deptno
AND sal > 2500
ORDER BY deptno;

--ANSI SQL ���
SELECT a.empno, a.ename, a.deptno, b.dname
FROM emp a JOIN dept b ON b.deptno = a.deptno AND sal > 2500 ORDER BY deptno;

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