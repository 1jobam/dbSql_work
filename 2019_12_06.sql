SELECT *
FROM dept;
-- dept ���̺� �μ���ȣ 99, �μ��� ddit, ��ġ daejeon
insert into dept values ('99', 'ddit', 'daejeon');

--UPDATE : ���̺� ����� �÷��� ���� ����
--UPDATE ���̺�� SET �÷���1 = �����Ϸ����ϴ� ��1, �÷���2 = �����Ϸ����ϴ� ��2......
--[WHERE row ��ȸ ����] -- ��ȸ ���ǿ� �ش��ϴ� �����͸� ������Ʈ�� �ȴ�.

--�μ���ȣ�� 99���� �μ��� �μ����� ���IT��, ������ ���κ������� ����
select * from dept;

UPDATE dept SET dname = '���IT', LOC = '���κ���'
WHERE deptno = 99;

--������Ʈ������ ������Ʈ �Ϸ����ϴ� ���̺��� WHERE���� ����� �������� SELECT�� �Ͽ� ������Ʈ ��� ROW�� Ȯ���غ���.
SELECT *
FROM dept
WHERE deptno = 99;

--���� QUERY�� �����ϸ� WHERE���� ROW ���� ������ ���� ������
--dept ���̺��� ��� �࿡ ���� �μ���, ��ġ ������ �����Ѵ�.
UPDATE dept SET dname = '���IT', loc = '���κ���';

--SUBQUERY�� �̿��� UPDATE
--emp ���̺� �ű� ������ �Է�
--�����ȣ 9999, ����̸� brown, ���� : null
select * from emp;
insert into emp (empno, ename)
values(9999, 'brown');
commit;

--�����ȣ�� 9999�� ����� �Ҽ� �μ��� �������� SMITH����� �μ�, ������ ������Ʈ �ϼ���.
select * from emp WHERE empno = 9999;
UPDATE emp 
SET deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH') 
    ,job = (SELECT job FROM emp WHERE ename = 'SMITH')
WHERE empno = 9999;
commit;

--DELETE : ���ǿ� �ش��ϴ� ROW�� ����
--�÷��� ���� ����??(NULL)������ �����Ϸ��� --> UPDATE
--DELETE ���̺��
--[WHERE ����]

-- UPDATE������ ���������� DELETE ���� ���������� �ش� ���̺��� WHERE ������ ����
-- �ϰ� �Ͽ� SELECT�� ����, ������ ROW�� ���� Ȯ���غ���

--emp���̺� �����ϴ� �����ȣ 9999�� ����� ����
select * from emp;
select * from emp WHERE empno = 9999;
DELETE emp WHERE empno = 9999;
DELETE emp; -- ���̺� �����ϴ� ��� �����͸� ����

--�Ŵ����� 7698�� ��� ����� ����
select * from emp;
DELETE emp
WHERE empno IN (SELECT empno from emp WHERE mgr = 7698);
--�� Ŀ���� �Ʒ� ������ ����
DELETE emp WHERE mgr = 7698;

-- dept���̺� synonym�� �����Ͽ� (��)
SELECT *
FROM dept;  -- ��
SELECT *
FROM d; -- �� ��� ����

--DDL : TABLE ����
--CREATE TABLE [����ڸ�.]���̺��(
-- �÷���1 �÷�Ÿ��1,
-- �÷���1 �÷�Ÿ��2, ....
-- �÷���N �÷�Ÿ��N);
-- ranger_no NUMBER        : ������ ��ȣ
-- ranger_nm VARCHAR2 (50) : ������ �̸�
-- reg_dt DATE             : ������ �������
--���̺� ���� DDL : Date Defination Languager(������ ���Ǿ�)
--DDL rollback�� ����.(�ڵ�Ŀ�� �ǹǷ� rollback�� �� �� ����.)
CREATE TABLE ranger(
    ranger_no NUMBER,
    ranger_nm VARCHAR2 (50),
    reg_dt DATE);
    
-- ����Ŭ������ ��ü ������ �ҹ��ڷ� �����ϴ���
-- ���������δ� �빮�ڷ� �����Ѵ�.
desc ranger;
SELECT * FROM user_tables WHERE TABLE_NAME = 'RANGER';

--DDL ������ ROLLBACK ó���� �Ұ�!!!!
ROLLBACK;
select * from ranger;


INSERT INTO ranger VALUES (1, 'brown', sysdate);
--�����Ͱ� ��ȸ�Ǵ� ���� Ȯ�� ����
select * from ranger;

--DML���� DDL�� �ٸ��� ROLLBACK�� �����ϴ�
ROLLBACK;

--ROLLBACK�� �߱� ������ DML������ ��ҵȴ�.
select * from ranger;

desc emp;

-- DATE Ÿ�Կ��� �ʵ� �����ϱ�
-- EXTRACT (�ʵ�� FROM �÷�/expression)
SELECT TO_CHAR(sysdate, 'yyyy')yyyy,
        TO_CHAR(sysdate, 'mm')mm,
        EXTRACT(year FROM SYSDATE) ex_yyyy,
        EXTRACT(month FROM SYSDATE) ex_mm
FROM dual;

--���� ���� ���� ����
CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR(14),
    loc VARCHAR(13));

drop table dept_test;    
--���� ���� �ְ� ����
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR(14),
    loc VARCHAR(13));
    
select * from dept_test;

--dept_test ���̺��� deptno �÷��� PRIMARY KEY ���������� �ֱ� ������
--deptno�� ������ �����͸� �Է��ϰų� ���� �� �� ����.
--���� �������̹Ƿ� �Է¼���
INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon');
--dept_test �����Ϳ� deptno�� 99���� �����Ͱ� �����Ƿ�
--primary key �������ǿ� ���� �Է� �� �� ����.
--ORA-00001 unique constraint ���� ����
--����Ǵ� �������Ǹ� SYS-C00????? ���� ���� ���� --����Ŭ�� ���������� �������Ǹ��� ��������
--SYS-C00????? ���������� � ���� �������� �Ǵ��ϱ� ����Ƿ�
--�������ǿ� �̸��� �ڵ� �꿡 ���� �ٿ� �ִ� ����
--���������� ���ϴ�.
INSERT INTO dept_test VALUES(99, '���', '����');

-- ���̺� ������ �������� �̸��� �߰��Ͽ� �� ����.
--primary key : pk_���̺������ ���� ���� CONSTRAINT Ȱ��
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) CONSTRAINT pk_dept_test PRIMARY KEY,
    dname VARCHAR(14),
    loc VARCHAR(13));
    
INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES(99, '���', '����');
select * from dept_test;