-- �м��Լ� / window �Լ� ( �׷쳻 �� ���� - �����غ���, �ǽ� no_ana 3 )
-- ��� ����� ���� �����ȣ, ����̸�, �Ի�����, �޿��� �޿��� ����������
-- ��ȸ �غ���. �޿��� ������ ��� �����ȣ�� ��������� �켱������ ����
-- �켱������ ���� ���� ������� ���� ������ �޿� ���� ���ο� �÷����� ����
-- window (�м��Լ�) ���� ����

SELECT a.empno, a.ename, a.sal, b.sal
FROM
(SELECT empno, ename, sal, rownum
FROM emp
ORDER BY sal)a,
(SELECT empno,ename, sal, rownum
FROM emp
ORDER BY sal)b
WHERE a.ename = b.ename;

