--DML : SELECT
/*
    select *
    from ���̺��;
*/

--�ڵ��� ���ظ� ���� ���� ������ �ۼ� : �ּ�

-- prod ���̺��� ��� �÷��� ������� ��� �����͸� ��ȸ
select * from prod;

--prod ���̺��� prod_id, prod_name �÷��� ��� �����Ϳ� ���� ��ȸ
select prod_id, prod_name from prod;

--���� ������ ������ �����Ǿ� �ִ� ���̺� ����� ��ȸ
select * from USER_TABLES;

--���̺��� �÷� ����Ʈ ��ȸ

select * from USER_TAB_COLUMNS;

--DESC ���̺��
DESC PROD;

-- lprod ���̺��� ��� �����͸� ��ȸ�ϴ� ������ �ۼ��ϼ���
select * from lprod;

-- buyer ���̺��� buyer_id, buyer_name �÷��� ��ȸ�ϴ� ������ �ۼ��ϼ���
select buyer_id, buyer_name from buyer;

-- cart ���̺��� ��� �����͸� ��ȸ�ϴ� ������ �ۼ��ϼ���
select * from cart;

-- member ���̺��� mem_id, mem_pass, mem_name �÷��� ��ȸ�ϴ� ������ �ۼ��ϼ���
select mem_id, mem_pass, mem_name from member;