-- �м��Լ� / window �Լ� ( �׷쳻 �� ���� - �����غ���, �ǽ� no_ana 3 )
-- ��� ����� ���� �����ȣ, ����̸�, �Ի�����, �޿��� �޿��� ����������
-- ��ȸ �غ���. �޿��� ������ ��� �����ȣ�� ��������� �켱������ ����
-- �켱������ ���� ���� ������� ���� ������ �޿� ���� ���ο� �÷����� ����
-- window (�м��Լ�) ���� ����

SELECT c.empno, c.ename, c.sal, sum(c.sal) c_sum
FROM
(SELECT a.*, rownum rn
FROM
(SELECT empno, ename, sal
FROM emp
ORDER BY sal)a,
(SELECT empno,ename, sal
FROM emp
ORDER BY sal)b
WHERE a.ename = b.ename)c,
(SELECT a.*, rownum rn
FROM
(SELECT empno, ename, sal
FROM emp
ORDER BY sal)a,
(SELECT empno,ename, sal
FROM emp
ORDER BY sal)b
WHERE a.ename = b.ename)d
WHERE c.rn >= d.rn
GROUP BY c.empno, c.ename, c.sal
ORDER BY sal;


select a.empno, a.ename, a.sal1,sum(sal2) as c_sum
from
(select empno,ename,rownum as rn1, sal1
from 
(select empno, ename,sal as sal1
from emp
order by sal)) a,
(select rownum as rn2, sal as sal2
from 
(select sal
from emp
order by sal)) b
where a.rn1 >= b.rn2
group by a.empno, a.ename, a.sal1
order by c_sum;
