SELECT *
FROM PC02.users;

SELECT *
FROM jobs;

SELECT *
FROM USER_TABLES;

--78 --> 79���� ���̺�� �ٲ�.
SELECT *
FROM ALL_TABLES
WHERE OWNER = 'PC02'; --ALL_TABLES �� �������� ���� ���̺��� ���� �ִ�.

SELECT *
FROM PC02.FASTFOOD;
-- PC02.fastfood --> fastfood

CREATE SYNONYM fastfood FOR PC02.fastfood;
DROP SYNONYM fastfood;

SELECT * FROM fastfood;

