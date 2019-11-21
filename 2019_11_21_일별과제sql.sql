-- ** ���� **

-- (�ǽ� where 3)
-- users ���̺��� userid�� brown, cony, sally�� �����͸� ������ ���� ��ȸ�Ͻÿ�
-- (IN ������ ���)
select * from users where userid in ('brown', 'cony', 'sally');

-- (�ǽ� where 4)
-- member ���̺��� ȸ���� ���� [��]���� ����� mem_id, mem_name �� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�
select mem_id, mem_name from member where mem_name like '��%';

-- (�ǽ� where 5)
-- member ���̺��� ȸ���� �̸��� ����[��]�� ���� ��� ����� mem_id, mem_name�� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�
select mem_id, mem_name from member where mem_name like '%��%';

-- (�ǽ� where 6)
-- emp ���̺��� ��(comm)�� �ִ� ȸ���� ������ ������ ���� ��ȸ�ǵ��� ������ �ۼ��Ͻÿ�.
select * from emp where comm is not null;

-- (�ǽ� where 7)
-- emp ���̺��� job�� salesman �̰� �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ������ ���� ��ȸ �ϼ���.
select * from emp where job = 'SALESMAN' and hiredate >= to_date('19810601', 'yyyymmdd');

-- (���� where 8)
-- emp ���̺��� �μ���ȣ�� 10���� �ƴϰ� �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ������ ���� ��ȸ �ϼ���.
select * from emp where deptno not like '10' and hiredate >= to_date('19810601','yyyymmdd');

-- (���� where 9)
-- emp ���̺��� �μ���ȣ�� 10���� �ƴϰ� �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ������ ���� ��ȸ �ϼ���.
select * from emp where deptno not in '10' and hiredate >= to_date('19810601','yyyymmdd');

-- (���� where 10)
-- emp ���̺��� �μ���ȣ�� 10���� �ƴϰ� �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ������ ���� ��ȸ �ϼ���.
select * from emp where deptno in('20','30') and hiredate >= to_date('19810601','yyyymmdd');

-- (���� where 11)
-- emp ���̺��� job�� salesman �̰ų� �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ������ ���� ��ȸ �ϼ���.
select * from emp where job like 'SAL%' or hiredate >= to_date('19810601','yyyymmdd');

-- (���� where 12)
-- emp ���̺��� job�� salesman �̰ų� �����ȣ�� 78�� �����ϴ� ������ ������ ������ ���� ��ȸ �ϼ���.
select * from emp where job = 'SALESMAN' or EMPNO like '78%';

-- (���� where 13)
--emp ���̺��� job�� SALESMAN �̰ų� �����ȣ�� 78�� �����ϴ� ������ ������ ������ ���� ��ȸ �ϼ���.
--(like �����ڸ� ������� ������)


-- (���� where 14)
--emp ���̺��� job�� SALESMAN �̰ų� �����ȣ�� 78�� �����ϸ鼭 �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ������ ���� ��ȸ �ϼ���.
select * from emp where job = 'SALESMAN' or empno like '78%' and hiredate >= to_date('19810601','yyyymmdd');