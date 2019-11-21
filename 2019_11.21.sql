-- col IN (value1, values2...)
-- col�� ���� IN ������ �ȿ� ������ ���߿� ���Ե� �� ������ ����

--RDBMS - ���հ���
--1. ���տ��� ������ ����.
-- {1, 5, 7}, {5, 1, 7}
--2. ���տ��� �ߺ��� ����.
-- {1, 1, 5, 7}, {5, 1, 7} �����ϴ�
select * from emp where deptno IN (10 , 20); --emp ���̺��� ������ �Ҽ� �μ��� 10 �̰ų� 20�� ���� ������ ��ȸ �Ͻÿ�.

--�̰ų� --> OR (�Ǵ�)
--�̰� --> AND (�׸���)

-- IN --> OR
-- BETWEEN AND --> AND + �����

SELECT * FROM emp where deptno = 10 or deptno = 20;

--users ���̺��� userid�� brown, cony, sally�� �����͸� ������ ���� ��ȸ �Ͻÿ�.
--(IN ������ ���)
--���� Ȯ�� desc users;

select userid ���̵�, usernm �̸�, alias ���� from users 
where userid in('brown', 'cony', 'sally');

-- LIKE ������ : ���ڿ� ��Ī ����
-- % : ���� ����(���ڰ� ���� ���� �ִ�.)
-- _ : �ϳ��� ����

-- where3
--emp ���̺��� ��� �̸��� s�� �����ϴ� ��� ������ ��ȸ
select * from emp
where ename like 'S%';

-- SMAITH
-- SCOTT
-- ù���ڴ� S�� �����ϰ� 4��° ���ڴ� T
-- �ι�°, ����°, �ټ���° ���ڴ� � ���ڵ� �� �� �ִ�.
select * from emp
where ename like 'S__T_';
where ename like 'S%T_'; -- 'STE', 'STTTT', 'STESTS'


-- where4
-- member ���̺��� ȸ���� ���� [��]���� ����� mem_id, mem_name �� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�.
select mem_id, mem_name from member
where mem_name like '��%';

-- where5
-- member ���̺��� ȸ���� �̸��� ����[��]�� ���� ��� ����� mem_id, mem_name�� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�.
select mem_id, mem_name from member
where mem_name like '%��%'; --% _ 

--�÷� ���� NULL�� ������ ã��
--emp ���̺� ���� MGR �÷��� NULL �����Ͱ� ����
select * from emp
where MGR IS NULL; -- NULL�� Ȯ�ο��� IS NULL �����ڸ� ���
where MGR = 7698; --MGR �÷� ���� 7698�� ��� ������ȸ
where MGR = NULL; --MGR �÷� ���� NULL�� ��� ������ȸ (��ȸ ���� ����)

--where6
--emp ���̺��� ��(comm)�� �ִ� ȸ���� ������ ������ ���� ��ȸ�ǵ��� ������ �ۼ��Ͻÿ�
select * from emp
where COMM is not null;

-- and : ������ ���ÿ� ����
-- or : ������ �Ѱ��� �����ϸ� ����
-- emp ���̺��� mgr�� 7698 ����̰�(and), �޿��� 1000���� ū ���
select * from emp
where mgr = 7698
and sal > 1000;

-- emp ���̺��� mgr�� 7698 �̰ų�(OR), �޿��� 1000���� ū ���
select * from emp
where mgr = 7698
or sal > 1000;

--emp ���̺��� ������ ����� 7698, 7839�� �ƴ� ���� ������ȸ
select * from emp
where MGR not in ( 7698, 7839 )
or mgr is null;

desc emp;

--where 7
-- emp ���̺��� job�� SALESMAN �̰� �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ������ ���� ��ȸ �ϼ���.
select * from emp
where JOB = 'SALESMAN'
and HIREDATE >= to_date('19810601','yyyymmdd');
