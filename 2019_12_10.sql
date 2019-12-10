-- �������� Ȱ��ȭ / ��Ȱ��ȭ
--ALTER TABLE ���̺�� ENABLE OR DISABLE CONSTRAINT �������Ǹ�;

--USER_CONSTRAINTS VIEW�� ���� dept_test ���̺� ������
--�������� Ȯ��
SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'DEPT_TEST';

ALTER TABLE dept_test DISABLE CONSTRAINT IDX_DEPT_NUMBER;

SELECT *
FROM dept_test;

--dept_test ���̺��� deptno �÷��� �����  PRIMARY KEY ���������� ��Ȱ��ȭ �Ͽ�
--������ �μ���ȣ�� ���� �����͸� �Է��� �� �ִ�.
INSERT INTO dept_test values(99, 'ddit', 'daejeon');
INSERT INTO dept_test values(99, 'DDIT', '����');

--dept_test ���̺��� PRIMARY KEY �������� Ȱ��ȭ
--�̹� ������ ������ �ΰ��� INSERT ������ ���� ���� �μ���ȣ�� ���� �����Ͱ�
--�����ϱ� ������ PRIMARY KEY ���������� Ȱ��ȭ �� �� ����.
--Ȱ��ȭ �Ϸ��� �ߺ������͸� ���� �ؾ��Ѵ�.
ALTER TABLE dept_test ENABLE CONSTRAINT IDX_DEPT_NUMBER;

--�μ���ȣ�� �ߺ��Ǵ� �����͸� ��ȸ �Ͽ�
--�ش� �����Ϳ� ���� ������ PRIMARY KEY ���������� Ȱ��ȭ �� �� �ִ�.
SELECT deptno, count(*)
FROM dept_test
GROUP BY deptno
HAVING COUNT(*) >= 2;

--table_name, constraint_name, column_name
--position ���� (ASC)
SELECT * 
FROM user_constraints
WHERE TABLE_NAME = 'BUYER';

SELECT *
FROM user_cons_columns
WHERE table_name = 'BUYER';

--���̺� ���� ���� (�ּ�) VIEW
SELECT *
FROM USER_TAB_COMMENTS;

--���̺� �ּ�
--COMMENT ON TABLE ���̺�� IS '�ּ�����';
COMMENT ON TABLE dept IS '�μ�';

--�÷� �ּ�
--COMMNET ON COLUMN ���̺��.�÷��� IS '�ּ�����';
COMMENT ON COLUMN dept.deptno IS '�μ���ȣ';
COMMENT ON COLUMN dept.dname IS '�μ���';
COMMENT ON COLUMN dept.loc IS '�μ���ġ����';

SELECT * FROM USER_COL_COMMENTS WHERE TABLE_NAME = 'DEPT';

-- DDL(TABLE - comments �ǽ� comment1)
SELECT * FROM user_tab_comments;
SELECT * FROM user_col_comments;

SELECT a.TABLE_NAME, a.TABLE_TYPE, a.COMMENTS TAB_COMMENT, b.COLUMN_NAME, b.COMMENTS COL_COMMENT
FROM user_tab_comments a, user_col_comments b 
WHERE a.TABLE_NAME = b.TABLE_NAME
AND a.TABLE_NAME IN ('CUSTOMER', 'PRODUCT', 'CYCLE', 'DAILY');


--VIEW : QUERY �̴�
--���̺� ó�� �����Ͱ� ���������� ���� �ϴ� ���� �ƴϴ�.
--���� ������ �� = QUERY
--VIEW �� ���̺� �̴� (X)

--VIEW ����
--CREATE OR REPLACE VIEW ���̸� [(�÷���Ī 1, �÷���Ī 2....)] AS
--SUBQUERY

--emp���̺��� sal, comm�÷��� ������ ������ 6�� �÷��� ��ȸ�� �Ǵ� view
--v_emp�̸����� ����
CREATE OR REPLACE VIEW v_emp AS
SELECT empno, ename, job, mgr, hiredate, deptno FROM emp;

desc emp;

--SYSTEM �������� �۾�
GRANT CREATE VIEW TO PC02;

--VIEW�� ���� ������ ��ȸ
SELECT *
FROM v_emp;

--INLINE VIEW
SELECT *
FROM (SELECT empno, ename, job, mgr, hiredate, deptno FROM emp);

--emp���̺��� �����ϸ� view�� ������ ������?
--KING�� �μ���ȣ�� ���� 10��
--emp ���̺��� KING�� �μ���ȣ �����͸� 30������ ����
--v_emp ���̺��� KING�� �μ���ȣ�� ����
select * from (select empno, ename, job, mgr, hiredate, deptno FROM emp);

UPDATE emp SET deptno = 30
WHERE ename = 'KING';

--v_emp ���̺��� KING �� �μ���ȣ�� ����
select * from v_emp;

rollback;

CREATE OR REPLACE VIEW v_emp_dept AS
SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT *
FROM v_emp_dept;

--emp ���̺��� KING������ ����(COMMIT ���� ����)
SELECT * FROM emp WHERE ename = 'KING';
DELETE emp WHERE ename = 'KING';

rollback;
--emp ���̺��� KING ������ ������ v_emp_dept view�� ��ȸ ��� Ȯ��
SELECT * FROM v_emp_dept;

--INLINE VIEW
SELECT *
FROM (SELECT emp.empno, emp.ename, emp.deptno, dept.dname FROM emp,dept WHERE emp.deptno = dept.deptno);

--emp���̺��� empno �÷��� eno�� �÷��̸� ����
ALTER TABLE emp RENAME COLUMN empno TO eno;
ALTER TABLE emp RENAME COLUMN eno TO empno;

SELECT *
FROM v_emp_dept;

--VIEW ����
--v_emp ����
DROP VIEW v_emp;

--�μ��� ������ �޿� �հ�
CREATE OR REPLACE VIEW v_emp_sal AS
SELECT deptno, sum(sal) sum_sal
FROM emp
GROUP BY deptno;

SELECT *
FROM (SELECT deptno, sum(sal) sum_sal
    FROM emp
    GROUP BY deptno)
WHERE deptno = 20;


--SEQUENCE
--����Ŭ��ü�� �ߺ����� �ʴ� ���� ���� �������ִ� ��ü
--CREATE SEQUENCE ��������
--[�ɼ�...]
 CREATE SEQUENCE  "PC02"."SEQ_BOARD"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
CREATE SEQUENCE seq_board;

--������ ����� : ��������.nextval
SELECT seq_board.currval
FROM dual;
--������-����
SELECT TO_CHAR(sysdate, 'yyyymmdd') || '-' || seq_board.nextval
FROM dual;

SELECT rowid, rownum, emp.*
FROM emp;

--emp ���̺� empno �÷����� PRIMARY KEY ���� ���� : pk_emp
--dept ���̺� deptno �÷����� PRIMARY KEY ���� ���� : pk_dept
--emp ���̺��� empno �÷��� dept ���̺��� deptno �÷��� �����ϵ���
--FOREIGN KEY ���� �߰� : fk_dept_deptno
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);
ALTER TABLE dept ADD CONSTRAINT pk_dept PRIMARY KEY (deptno);
ALTER TABLE emp ADD CONSTRAINT fk_dept_deptno FOREIGN KEY (deptno)
            REFERENCES dept (deptno);

--emp_test ���̺� ����
DROP TABLE emp_test;

--emp ���̺��� �̿��Ͽ� emp_test ���̺����
CREATE TABLE emp_test AS
SELECT * FROM emp;

--emp_test ���̺��� �ε����� ���� ����
--���ϴ� �����͸� ã�� ���ؼ��� ���̺��� �����͸� ��� �о���� �Ѵ�.

EXPLAIN PLAN FOR
SELECT *
FROM emp_test
WHERE empno = 7369;

SELECT * FROM table(dbms_xplan.display);

--���� ��ȹ�� ���� 7369 ����� ���� ���� ������ ��ȸ �ϱ�����
--���̺��� ��� ������(14)�� �о� �������� ����� 7369�� �����͸� �����Ͽ�
--����ڿ��� ��ȯ
--**13���� �����ʹ� ���ʿ��ϰ� ��ȸ�� ����

Plan hash value: 3124080142
 
------------------------------------------------------------------------------
| Id  | Operation         | Name     | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |          |     1 |    87 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP_TEST |     1 |    87 |     3   (0)| 00:00:01 |
------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("EMPNO"=7369)
 
Note
-----
   - dynamic sampling used for this statement (level=2)
   
--   
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7369;

SELECT * FROM table(dbms_xplan.display);


--�����ȹ�� ���� �м��� �ϸ�
--empno�� 7369�� ������ index�� ���� �ſ� ������ �ε����� ����
--���� ����Ǿ� �ִ� rowid ���� ���� table�� ������ �Ѵ�.
--table���� ���� �����ʹ� 7369��� ������ �ѰǸ� ��ȸ�� �ϰ�
--������ 13�ǿ� ���ؼ��� ���� �ʰ� ó��.
-- ����������쿡�� 14 --> 1
-- ������ȸ��쿡�� 1 --> 1
Plan hash value: 2949544139
 
--------------------------------------------------------------------------------------
| Id  | Operation                   | Name   | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |        |     1 |    38 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP    |     1 |    38 |     1   (0)| 00:00:01 |
|*  2 |   INDEX UNIQUE SCAN         | PK_EMP |     1 |       |     0   (0)| 00:00:01 |
--------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("EMPNO"=7369)

EXPLAIN PLAN FOR
SELECT rowid, emp.*
FROM emp
WHERE rowid = 'AAAE5xAAFAAAAETAAA';

SELECT * FROM table(dbms_xplan.display);