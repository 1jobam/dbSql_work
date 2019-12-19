-- 계층쿼리 ( 생각해볼거리 실습 h9) -- > 과제
-- 일반적인 게시판을 보면 최상위글은 최신글이 먼저 오고, 답글의 경우 작성한 순서대로 정렬이 된다.
-- 어떻게 하면 최상위글은 최신글 순(desc)으로 정렬하고, 답글은 순차(asc) 적으로 정렬 할 수 있을까?
select * from board_test;

SELECT seq, LPAD(' ', (LEVEL - 1) * 4) || title
FROM board_test
START WITH parent_seq is null
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY NVL(parent_seq, seq) desc; 

