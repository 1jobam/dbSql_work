--연습

--도시발전지수가 높은 순으로 나열
--도시발전지수 = (버거킹개수 + KFC개수 + 맥도날드 개수) / 롯데리아 개수
--순위 / 시도 / 시군구 / 도시발전지수 (소수점 둘째 짜리에서 반올림)
-- 1 / 서울특별시 / 서초구 / 7.5
-- 2 / 서울특별시 / 강남구 / 7.2

select * from fastfood;

SELECT rownum 순위, c.sido, c.sigungu, c.점수 from
(SELECT a.sido, a.sigungu, round(a.cnt / b.cnt, 1) 점수
FROM(select sido, sigungu, count(*) cnt
from fastfood
WHERE gb in('버거킹', 'KFC', '맥도날드')
GROUP BY sido, sigungu)a,
(select sido, sigungu, count(*) cnt
from fastfood
WHERE gb in('롯데리아')
GROUP BY sido, sigungu)b
WHERE a.sido = b.sido
AND a.sigungu = b.sigungu
ORDER BY 점수 desc)c;