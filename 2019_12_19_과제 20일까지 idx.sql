-- �м��Լ� / window �Լ� ( �׷쳻 �� ���� - �����غ���, �ǽ� no_ana 3 )
-- ��� ����� ���� �����ȣ, ����̸�, �Ի�����, �޿��� �޿��� ����������
-- ��ȸ �غ���. �޿��� ������ ��� �����ȣ�� ��������� �켱������ ����
-- �켱������ ���� ���� ������� ���� ������ �޿� ���� ���ο� �÷����� ����
-- window (�м��Լ�) ���� ����


SELECT b.empno, b.ename, b.sal, sum(b.sal) c_sum
FROM
(SELECT sal, rownum rn
FROM
(SELECT empno, ename, sal
FROM emp
ORDER BY sal))a,

(SELECT b.empno, b.ename, b.sal, rownum rn
FROM
(SELECT sal
FROM emp
ORDER BY sal))b

WHERE a.rn >= b.rn
GROUP BY b.empno, b.ename, b.sal;


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
