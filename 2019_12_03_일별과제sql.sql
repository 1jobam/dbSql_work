--����

--���ù��������� ���� ������ ����
--���ù������� = (����ŷ���� + KFC���� + �Ƶ����� ����) / �Ե����� ����
--���� / �õ� / �ñ��� / ���ù������� (�Ҽ��� ��° ¥������ �ݿø�)
-- 1 / ����Ư���� / ���ʱ� / 7.5
-- 2 / ����Ư���� / ������ / 7.2

select * from fastfood;

SELECT rownum ����, c.sido, c.sigungu, c.���� from
(SELECT a.sido, a.sigungu, round(a.cnt / b.cnt, 1) ����
FROM(select sido, sigungu, count(*) cnt
from fastfood
WHERE gb in('����ŷ', 'KFC', '�Ƶ�����')
GROUP BY sido, sigungu)a,
(select sido, sigungu, count(*) cnt
from fastfood
WHERE gb in('�Ե�����')
GROUP BY sido, sigungu)b
WHERE a.sido = b.sido
AND a.sigungu = b.sigungu
ORDER BY ���� desc)c;