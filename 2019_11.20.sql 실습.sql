column alias (�ǽ� select2)

-- prod ���̺��� prod_id, prod_name �� �÷��� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�
--(�� prod_id -> id, prod_name -> name ���� �÷� ��Ī�� ����)
select prod_id id, prod_name name from prod;

-- lprod ���̺��� lprod_gu, lprod_nm �� �÷��� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�.
--(�� lprod_gu -> gu, lprod_nm -> nm ���� �÷� ��Ī�� ����)
select lprod_gu gu, lprod_nm as nm from lprod;

-- buyer ���̺��� buyer_id, buyer_name �� �÷��� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�.
--(�� buyer_id -> ���̾���̵�, buyer_name -> �̸� ���� �÷� ��Ī�� ����)
select buyer_id as ���̾���̵�, buyer_name as �̸� from buyer;


