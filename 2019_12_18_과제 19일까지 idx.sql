-- �������� ( �����غ��Ÿ� �ǽ� h9) -- > ����
-- �Ϲ����� �Խ����� ���� �ֻ������� �ֽű��� ���� ����, ����� ��� �ۼ��� ������� ������ �ȴ�.
-- ��� �ϸ� �ֻ������� �ֽű� ��(desc)���� �����ϰ�, ����� ����(asc) ������ ���� �� �� ������?
select * from board_test;

SELECT seq, LPAD(' ', (LEVEL - 1) * 4) || title AS title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY seq desc;