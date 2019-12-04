-- 1. tax ���̺��� �̿� �õ�/�ñ����� �δ� �������� �Ű�� ���ϱ�
-- 2. �Ű���� ���� ������ ��ŷ �ο��ϱ�
-- ��ŷ(1) �õ�(2) �ñ���(3) �δ翬������Ű��(4)- �Ҽ��� ��°�ڸ����� �ݿø�
-- 1  ����Ư���� ���ʱ� 7000
-- 2  ����Ư����  ������ 6800

select * from tax;

SELECT ROWNUM rn, sido, sigungu, cal_sal
FROM
(SELECT sido, sigungu, sal, people, round(sal/people, 1) cal_sal
FROM tax
ORDER BY cal_sal desc);

--------------------------------------------------------------------------
-- OUTER JOIN Ȱ�� --
select * from fastfood;
select * from tax;

SELECT * FROM

(SELECT ROWNUM rn, c.*
FROM
(SELECT a.sido, a.sigungu, round(a.cnt/b.cnt, 1) ����
FROM
(SELECT sido, sigungu, count(*) cnt
FROM fastfood
WHERE gb IN('KFC', '�Ƶ�����', '����ŷ')
GROUP BY sido, sigungu)a,
(SELECT sido, sigungu, count(*) cnt
FROM fastfood
WHERE gb IN('�Ե�����')
GROUP BY sido, sigungu)b
WHERE a.sido = b.sido
AND a.sigungu = b.sigungu
ORDER BY ���� desc)c)q,

(SELECT ROWNUM rn, sido, sigungu, cal_sal
FROM
(SELECT sido, sigungu, sal, people, round(sal/people, 1) cal_sal
FROM tax
ORDER BY cal_sal desc))w

WHERE q.rn(+) = w.rn
ORDER BY w.rn;


-- ���ù������� �õ�, �ñ����� ���� ���� ���� �ݾ��� �õ�, �ñ�����
-- ���� �������� ����
-- ���ļ����� tax ���̺��� id �÷� ������ ����
-- 1 ����Ư���� ������ 5.6 ����Ư���� ������ 70.3
SELECT * FROM tax;
select * from fastfood;



SELECT w.id, q.sido, q.sigungu, q.����, w.sido, w.sigungu, w.cal_sal FROM

(SELECT ROWNUM rn, c.*
FROM
(SELECT a.sido, a.sigungu, round(a.cnt/b.cnt, 1) ����
FROM
(SELECT sido, sigungu, count(*) cnt
FROM fastfood
WHERE gb IN('KFC', '�Ƶ�����', '����ŷ')
GROUP BY sido, sigungu)a,
(SELECT sido, sigungu, count(*) cnt
FROM fastfood
WHERE gb IN('�Ե�����')
GROUP BY sido, sigungu)b
WHERE a.sido = b.sido
AND a.sigungu = b.sigungu
ORDER BY ���� desc)c)q,

(SELECT ROWNUM rn, sido, sigungu, cal_sal, id
FROM
(SELECT sido, sigungu, sal, people, round(sal/people, 1) cal_sal, id
FROM tax
ORDER BY cal_sal desc))w

WHERE q.sido(+) = w.sido
AND q.sigungu(+) = w.sigungu
ORDER BY w.id;


-- SMITH�� ���� �μ� ã��
SELECT deptno 
FROM emp
WHERE ename = 'SMITH';

SELECT * 
FROM emp
WHERE deptno = (SELECT deptno 
                FROM emp
                WHERE ename = 'SMITH');
                
SELECT * 
FROM emp
WHERE deptno IN (SELECT deptno 
                FROM emp);
                
SELECT empno, ename, deptno,
    (SELECT dname FROM dept WHERE dept.deptno = emp.deptno) dname
FROM emp;

--scalar subquery
--SELECT ���� ǥ���� ���� ����
--�� ��, �� COLUMN�� ��ȸ�ؾ� �Ѵ�.
SELECT empno, ename, deptno,
    (SELECT dname FROM dept) dname
FROM emp;

--INLINE VIEW
--FROM���� ���Ǵ� ���� ����

--SUBQUERY
--WHERE�� ���Ǵ� ��������

-- �������� ( �ǽ� sub 1 )
-- ��� �޿����� ���� �޿��� �޴� ������ ���� ��ȸ�ϼ���.
select * from emp;

SELECT count(sal) cnt
FROM emp
WHERE sal > (SELECT AVG(sal) FROM emp);

--�������� ( �ǽ� sub2 )
-- ��� �޿����� ���� �޿��� �޴� ������ ������ ��ȸ�ϼ���.
select * from emp;

SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal) FROM emp);

--�������� ( �ǽ� sub3 )
-- SMITH�� WARD ����� ���� �μ��� ��� ��� ������ ��ȸ�ϴ� ������ ������ ���� �ۼ��ϼ���.
select * from emp;

SELECT deptno
FROM emp
WHERE ename IN ('SMITH', 'WARD');

SELECT *
FROM emp
WHERE deptno IN ( 20, 30 );

SELECT *
FROM emp
WHERE deptno IN (SELECT deptno FROM emp WHERE ename IN ('SMITH', 'WARD'));

--SMITH Ȥ�� WARD ���� �޿��� ���� �޴� ���� ��ȸ
SELECT *
FROM emp
WHERE sal < ANY (SELECT sal --> ANY �� 1250���� ��������� �ȴ� �ᱹ �����ϳ��� ���� �����ϸ� �Ǳ⶧����
                FROM emp 
                where ename in('SMITH', 'WARD'));
                
SELECT *
FROM emp
WHERE sal < ALL (SELECT sal --> ALL�� �������� �����ؾߵǱ� ������ 800���� ������� �̵ȴ�
                FROM emp 
                where ename in('SMITH', 'WARD'));
                
-- ������ ��Ȱ�� ���� �ʴ� ��� ���� ��ȸ

--�����ڰ� �ƴ� ���
--NOT IN ������ ���� NULL�� �����Ϳ� �������� �ʾƾ� ���� ���� �Ѵ�.
SELECT *
FROM emp -- ��� ���� ��ȸ --> ������ ��Ȱ�� ���� �ʴ�
WHERE empno NOT IN
            (SELECT NVL(mgr, -1) -- NULL ���� �������� �������� �����ͷ� ġȯ
                FROM emp);
                
SELECT *
FROM emp -- ��� ���� ��ȸ --> ������ ��Ȱ�� ���� �ʴ�
WHERE empno NOT IN
            (SELECT mgr -- NULL ���� �������� �������� �����ͷ� ġȯ
                FROM emp WHERE mgr is not null);
--�������� ���
SELECT *
FROM emp 
WHERE empno IN
            (SELECT mgr
                FROM emp);

--prairwise (���� �÷��� ���� ���ÿ� ���� �ؾ��ϴ� ���)
--ALLEN, CLARK�� �Ŵ����� �μ���ȣ�� ���ÿ� ���� ��� ���� ��ȸ
-- (7698, 30)
-- (7839, 10)
SELECT *
FROM emp
WHERE (mgr, deptno) IN
                    (SELECT mgr, deptno FROM emp WHERE empno IN ( 7499, 7782));

SELECT * 
FROM emp 
WHERE empno IN (7499, 7782);


-- �Ŵ����� 7698 �̰ų� 7839 �̸鼭 �ҼӺμ��� 10�� �̰ų� 30���� ���� ���� ��ȸ
--7698, 10
--7698, 30
--7839, 10
--7839, 30
SELECT *
FROM emp
WHERE mgr IN
            (SELECT mgr FROM emp WHERE empno IN ( 7499, 7782))
AND deptno IN
            (SELECT deptno FROM emp WHERE empno IN ( 7499, 7782));

--���ȣ ���� ���� ����
--���������� �÷��� ������������ ������� �ʴ� ������ ���� ����

--���ȣ ���� ���������� ��� ������������ ����ϴ� ���̺�, �������� ��ȸ ������
--���������� ������ ������ �Ǵ��Ͽ� ������ ���� �Ѵ�.
--���������� emp ���̺��� ���� �������� �ְ�, ���������� emp ���̺���
--���� ���� ���� �ִ�.

--���ȣ ���� ������������ ���������� ���̺��� ���� ���� ����
--���������� ������ ������ �ߴ� ��� �� �������� ǥ��

--���ȣ ���� ������������ ���������� ���̺��� ���߿� ���� ����
--���������� Ȯ���� ��Ȱ�� �ߴ� ��� �� �������� ǥ��

--������ �޿� ��պ��� ���� �޿��� �޴� ���� ���� ��ȸ
-- ������ �޿� ���
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal) FROM emp);

-- ��ȣ���� ��������
--�ش������� ���� �μ��� �޿� ��� ���� ���� �޿��� �޴� ���� ��ȸ
SELECT * 
FROM emp m
WHERE sal > (SELECT AVG(sal)
            FROM emp 
            WHERE deptno = m.deptno);

--10�� �μ��� �޿����
SELECT AVG(sal)
FROM emp
WHERE deptno = 10;