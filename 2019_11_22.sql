-- GITHUB�� ������ �Ǿ� �ִ� ����
--1. github���� ����� clone
--2. ��Ŭ���� - ����� �߰�(git repositories)
--3. ��Ŭ���� - �߰��� ����� ����,
            -- ��Ŭ�� projects import
--4. package / project explorer
--   �ش� ������Ʈ ��Ŭ�� - configure
--                       convert faceted form ����


-- emp ���̺��� �μ���ȣ�� 10���� �ƴϰ� �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ������ ���� ��ȸ �ϼ���.
--(IN, NOT IN ������ ������)
select * from emp where deptno != 10 and hiredate > to_date('19810601','yyyymmdd');  -- �ƴϴ� <> , !=

-- emp ���̺��� �μ���ȣ�� 10���� �ƴϰ� �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ������ ���� ��ȸ�ϼ���.
select * from emp where deptno not in (10) and hiredate > to_date('19810601','yyyymmdd');

-- emp ���̺��� �μ���ȣ�� 10���� �ƴϰ� �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ������ ���� ��ȸ �ϼ���.
--(�μ��� 10, 20, 30 �� �ִٰ� �����ϰ� IN �����ڸ� ���)
select * from emp where deptno in(20, 30) and hiredate > to_date('19810601', 'yyyymmdd');

-- emp ���̺��� job�� SALESMAN�̰ų� �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ������ ���� ��ȸ �ϼ���.
select * from emp where job = 'SALESMAN' or hiredate > to_date('19810601', 'yyyymmdd');

-- emp ���̺��� job�� SALESMAN�̰ų� �����ȣ�� 78�� �����ϴ� ������ ������ ������ ���� ��ȸ �ϼ���.
select * from emp where job = 'SALESMAN' or empno like '78%';

--emp ���̺��� job�� SALESMAN �̰ų� �����ȣ�� 78�� �����ϴ� ������ ������ ������ ���� ��ȸ �ϼ���.
--(like �����ڸ� ������� ������.)
select * from emp where job = 'SALESMAN' or (empno >= 7800 and empno > 8000);
select * from emp where job = 'SALESMAN' or empno between 7800 and 7999;

-- ������ �켱���� (AND > OR)
-- ���� �̸��� SMITH �̰ų�, ���� �̸��� ALLEN�̸鼭 ������ SALESMAN�� ����
select * from emp where ename = 'SMITH' or (ename = 'ALLEN' and job = 'SALESMAN');

--���� �̸��� SMTIH �̰ų� ALLEN �̸鼭 ������ SALESMAN�� ���
select * from emp where (ename = 'SMTIH' or ename = 'ALLEN') and job = 'SALESMAN';

--emp ���̺��� job�� SALESMAN �̰ų� �����ȣ�� 78�� �����ϸ鼭 �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ������ ���� ��ȸ�ϼ���.
select * from emp where job = 'SALESMAN' or (empno like '78%' and hiredate > to_date('19810601','yyyymmdd'));

-- ������ ����
-- 10, 5, 3, 2, 1
-- �������� : 1, 2, 3, 5, 10 // -- �������� : 10, 5, 3, 2, 1

--�������� : ASC (ǥ�⸦ ���Ұ�� �⺻��)
--�������� : DESC (���������� �ݵ�� ǥ��)

/*
    SELECT col1, col2, ......
    FROM ���̺��
    WHERE col1 = '��'
    ORDER BY ���ı����÷�1 [ASC / DESC], ���ı����÷�2.... [ASC / DESC]
*/

--���(emp) ���̺��� ������ ������ ���� �̸����� �������� ����
select * from emp order by ename;
select * from emp order by ename; -- ���ı����� �ۼ��ϱ� ���� ��� ��������[ASC]�� �ȴ�. ���� ����

--���(emp) ���̺��� ������ ������ ���� �̸�(ename) ���� �������� ����
select * from emp order by ename desc;

--���(emp) ���̺��� ������ ������ �μ���ȣ�� �������� �����ϰ�
-- �μ���ȣ�� ���� ���� sal �������� ����
-- �޿���(sal)�� �������� �̸����� �������� �����Ѵ�.
select * from emp order by deptno, sal desc, ename;

--���� �÷��� allas�� ǥ��
select deptno, sal, ename nm from emp order by nm;

--��ȸ�ϴ� �÷��� ��ġ �ε����� ǥ�� ����
select deptno, sal, ename nm from emp order by 3; -- ��õ ���� ������ �÷��� �߰��ɶ��� ����Ͽ� ��������� ǥ�� �Ұ�.. (�÷� �߰��� �ǵ����� ���� ����� ���� �� ����)

-- dept ���̺��� ��� ������ �μ��̸����� �������� ���ķ� ��ȸ�ǵ��� ������ �ۼ��ϼ���.
-- dept ���̺��� ��� ������ �μ���ġ�� �������� ���ķ� ��ȸ�ǵ��� ������ �ۼ��ϼ���.
select * from dept order by dname;
select * from dept order by loc desc;

-- emp ���̺��� ��(comm) ������ �ִ� ����鸸 ��ȸ�ϰ�, ��(comm)�� ���� �޴� ����鸸 ��ȸ�ϰ�,
-- ��(comm)�� ���� �޴� ����� ���� ��ȸ�ǵ��� �ϰ�, �󿩰� ���� �ܿ� ������� �������� �����ϼ���.
select * from emp where comm is not null order by comm desc, empno;
select * from emp where comm is not null and comm != 0 order by comm desc, empno;

-- emp ���̺��� �����ڰ� �ִ� ����鸸 ��ȸ�ϰ�, ����(job) ������ �������� �����ϰ�,
-- ������ ���� ��� ����� ū ����� ���� ��ȸ�ǵ��� ������ �ۼ��ϼ���.
select * from emp where mgr is not null order by job, empno desc;

-- emp ���̺��� 10�� �μ�(deptno) Ȥ�� 30�� �μ��� ���ϴ� �����
-- �޿�(sal)�� 1500�� �Ѵ� ����鸸 ��ȸ�ϰ� �̸����� �������� ���ĵǵ��� ������ �ۼ��ϼ���.
select * from emp where deptno in('10','30') and sal > 1500 order by ename desc;

-- �ο� �÷� �� �߰��ϴ� Ű���� rownum
select rownum ����, empno, ename from emp;
 al �񱳴� 1�� ����
select rownum, empno, ename from emp where rownum  <= 10; -- ROWNUM�� 1���� ���������� ��ȸ�ϴ� ���� ����
select rownum, empno, ename from emp where rownum between 1 and 20;

--select ���� order by ������ �������
--select -> rownum -> order by �������
select rownum, empno, ename from emp order by ename;

-- INLINE VIEW�� ���� ���� ���� �����ϰ�, �ش� ����� rownum�� ����
-- select ���� * ����ϰ�, �ٸ� �÷� | ǥ������ ���� ��� *�տ� ���̺���̳�, ���̺� ��Ī�� ����
select rownum, a.* from (select empno, ename from emp order by ename) a; 
select rownum, emp.* from emp;

-- emp ���̺��� rownum ���� 1~10�� ���� ��ȸ�ϴ� ������ �ۼ��غ�����.
--(���ľ��� �����ϼ���, ����� ȭ��� �ٸ��� �ֽ��ϴ�)
select rownum rn, empno, ename from emp where rownum <= 10;

-- rownum ���� 11~20(11~14)�� ���� ��ȸ�ϴ� ������ �ۼ��غ�����.
select e.* from (select rownum rn, empno, ename from emp) e where rn between 11 and 14;

-- row_3 ���� ���� ����
-- emp ���̺��� ename���� ������ ����� 11��° ~ 14��° �ุ ��ȸ�ϴ� ������ �ۼ��ϼ���.
-- (empno, ename �ö��� ���ȣ�� ��ȸ)
-- select c.*, a.* from(select c.* from(select rownum rn, empno, ename from emp)c )a where order by rn where rn betwenn 11 and 14;
select * from(select rownum rn,a.* from(select empno, ename from emp order by ename)a) where rn between 11 and 14;



