SELECT *
FROM PC02.users;

SELECT *
FROM jobs;

SELECT *
FROM USER_TABLES;

--78 --> 79건의 테이블로 바뀜.
SELECT *
FROM ALL_TABLES
WHERE OWNER = 'PC02'; --ALL_TABLES 는 사용권한을 받은 테이블을 볼수 있다.

SELECT *
FROM PC02.FASTFOOD;
-- PC02.fastfood --> fastfood

CREATE SYNONYM fastfood FOR PC02.fastfood;
DROP SYNONYM fastfood;

SELECT * FROM fastfood;

