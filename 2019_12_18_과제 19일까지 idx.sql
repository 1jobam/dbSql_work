-- �������� ( �����غ��Ÿ� �ǽ� h9) -- > ����
-- �Ϲ����� �Խ����� ���� �ֻ������� �ֽű��� ���� ����, ����� ��� �ۼ��� ������� ������ �ȴ�.
-- ��� �ϸ� �ֻ������� �ֽű� ��(desc)���� �����ϰ�, ����� ����(asc) ������ ���� �� �� ������?
select * from board_test;

SELECT seq, LPAD(' ', (LEVEL - 1) * 4) || title
FROM board_test
START WITH parent_seq is null
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY NVL(parent_seq, seq) desc; 

