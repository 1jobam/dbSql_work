-- Ư�� ���̺��� �÷� ��ȸ
--1. desc ���̺��
--2. select * from user_tab_columns;

--prod ���̺��� �÷���ȸ
desc prod;

varchar2, char --> ���ڿ� (character)
number --> ����
CLOB --> character Large OBject, ���ڿ� Ÿ���� ���� ������ ���ϴ� Ÿ��
          -- �ִ� ������ : VARCHAR2 (4000BYTE), CLOB : 4GB
DATE --> ��¥(�Ͻ� = ��,��,�� + �ð�,��,��) -- yyyy,dd,mm + hh,,ss

--date Ÿ�Կ� ���� ������ �����?
'2019/11/20 09:16:20' + 1 = ?

--USERS ���̺��� ��� �÷��� ��ȸ �غ�����.
SELECT * FROM USERS;

--userid,usernm, reg_dt ������ �÷��� ��ȸ
SELECT userid, usernm, reg_dt FROM USERS;

--userid,usernm, reg_dt ������ �÷��� ��ȸ
--������ ���� ���ο� �÷��� ���� (reg_dt�� ���� ������ �� ���ο� ���� �÷�)
--��¥ + ���� ������ ?? ==> ���ڸ� ���� ��¥ Ÿ���� ����� ���´�.
--��Ī : ���� �÷����̳� ������ ���� ������ ���� �÷��� ������ �÷��̸��� �ο�
--  col(�����÷�) | express(�����÷�) [AS] ��Ī��
SELECT userid as "���̵�", usernm "�̸�", reg_dt as reg_date, reg_dt+5 as after5day FROM USERS;

--���� ���, ���ڿ� ��� ( oracle : '', java : '', "")
--table�� ���� ���� ������ �÷����� ����
--���ڿ� ���� ���� ( +, -, /, *)
--���ڿ� ���� ���� ( + ���簡 ���� ����, ==> ||�� ���)
SELECT (1+5)*2 "������", 'DB SQL ����',
        /* userid + '_modified', ���ڿ� ������ ���ϱ� ������ ���� */ 
        usernm || '_modeified', reg_dt 
from users;

--NULL : ���� �𸣴� ��
--NULL�� ���� ���� ����� �׻� NULL �̴�
--DESC ���̺�� NOT NULL�� �����Ǿ� �ִ� �÷����� ���� �ݵ�� ���� �Ѵ�.

--users ���ʿ��� ������ ����
-- rollback; : �ǵ����� �Ǽ��� �ѹ��� ��ȸ
SELECT * FROM USERS;

DELETE users WHERE userid not in ('brown', 'sally', 'cony', 'moon', 'james');
commit;

--null ������ �����غ��� ���� moon�� reg_dt �÷��� null�� ����
select userid, usernm, reg_dt from users;
UPDATE users SET reg_dt = Null where userid = 'moon';

--users ���̺��� reg_dt �÷����� 5���� ���� ���ο� �÷��� ����
--NULL���� ���� ������ ����� NULL�̴�.
SELECT userid, usernm, reg_dt, reg_dt+5 FROM users;

-- ���ڿ� �÷��� ����   (�÷� || �÷�, '���ڿ����' || �÷�)
--                    (CONCAT (�÷�, �÷�) )
select userid, usernm, userid || usernm AS id_nm, concat(userid, usernm) as con_id_nm from users;
-- ||�� �̿��ؼ� userid, usernm, pass

select userid, usernm, pass, userid || usernm || pass as id_nm_pass, concat(userid, usernm || pass) as con_id_nm_pass, concat(concat(userid, usernm), pass)  as con2_id2_nm2_pass2  from users;

--����ڰ� ������ ���̺� ��� ��ȸ
--LPROD --> select * from lprod;
select * from user_tables;

select 'select * from ' || table_name || ';' query from user_tables;
--concat �Լ��� �̿��ؼ�

select concat(concat('select * ','from '),table_name) || ';' as query from user_tables;
select concat(concat('select * from ', table_name), ';') as query from user_tables;

-- where : ������ ��ġ�ϴ� �ุ ��ȸ�ϱ� ���� ���
--          �࿡ ���� ��ȸ ������ �ۼ�
-- where���� ������ �ش� ���̺��� ��� �࿡ ���� ��ȸ
select userid, usernm, alias, reg_dt from users;

--userid �÷��� 'brown'�� ��(row)�� ��ȸ
select userid, usernm, alias, reg_dt from users where userid = 'brown';

-- emp ���̺��� ��ü ������ ��ȸ (��� ��(row), �÷�(colume))
select * from emp;
select * from dept;

--�μ���ȣ(deptno)�� 20���� ũ�ų� ���� �μ����� ���ϴ� ���� ���� ��ȸ
select * from emp where deptno >= 20;

--�����ȣ�� 7700���� ũ�ų� ���� ����� ������ ��ȸ
select * from emp where empno >=7700;

--����Ի����ڰ� 1982�� 1�� 1�� ������ ���
-- ���ڿ� --> ��¥ Ÿ������ ���� to_date('��¥���ڿ�', '��¥���ڿ�����')
select empno, ename, hiredate, 2000 no, '���ڿ����' str, to_date('19810101', 'yyyymmdd') ��¥ from emp where hiredate >= to_date('19820101','yyyymmdd');

--���� ��ȸ (between ���۱��� and ���� ����)
--���۱���, ��������� ����
--����߿��� �޿�(sal)�� 1000���� ũ�ų� ����, 2000���� �۰ų� ���� ��� ������ȸ
select * from emp where sal between 1000 and 2000;  -- between Ȱ��
--between and �����ڴ� �ε�ȣ �����ڷ� ��ü ����
select * from emp where sal >= 1000 and sal <=2000; -- and�� Ȱ��

-- emp ���̺��� �Ի� ���ڰ� 1982�� 1�� 1�� ���ĺ��� 1983�� 1�� 1�� ������ ����� ename, hiredate �����͸� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�
--(�� �����ڴ� between�� ����Ѵ�)
--where1
select ename, hiredate from emp where hiredate between to_date('19820101','yyyymmdd') and to_date('19830101','yyyymmdd');
--where2
-- emp ���̺��� �Ի� ���ڰ� 1982�� 1�� 1�� ���ĺ��� 1983�� 1�� 1�� ������ ����� ename, hiredate �����͸� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�.
-- (�� �����ڴ� �񱳿����ڸ� ����Ѵ�)
select ename ���̸�, to_char(hiredate, 'yyyy-mm-dd') ��¥ from emp where hiredate >= to_date('19820101','yyyymmdd') and hiredate <= to_date('19830101','yyyymmdd');


