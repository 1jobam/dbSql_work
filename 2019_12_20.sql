-- hash join ����
explain plan for
SELECT *
FROM dept, emp
WHERE dept.deptno = emp.deptno;

-- dept ���� �д� ����
-- join �÷��� hash �Լ��� ������ �ش� �ؽ� �Լ��� �ش��ϴ� bucket�� �����͸� �ִ´�
-- 10 --> aaabbaa (hashvalue)

--emp ���̺� ���� ���� ������ �����ϰ� ����
-- 10 --> aaabbaa (hashvalue)
explain plan for
SELECT *
FROM dept, emp
WHERE emp.deptno BETWEEN dept.deptno AND 99;

SELECT * FROM TABLE(dbms_xplan.display);
10 --> AAAAAA
20 --> AAAAAB


-- �����ȣ, ����̸�, �μ���ȣ, �޿�, �μ����� ��ü �޿���
SELECT empno, ename, deptno, sal,
        SUM(sal) OVER (ORDER BY sal 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) c_sum, --���� ó������ ������ ����
        
        --�ٷ� �������̶� ����������� �޿���
        sum(sal) OVER (ORDER BY sal ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) c_sum2
FROM emp
ORDER BY sal;

-- �м��Լ� / window �Լ� ( �׷쳻 �� ���� �ǽ� ana 7 )
-- �����ȣ, ����̸�, �μ���ȣ, �޿� ������ �μ����� �޿�, �����ȣ
-- ������������ ���� ������ �ڽ��� �޿��� �����ϴ� ������� �޿����� ��ȸ�ϴ� ������ �ۼ��ϼ���(window �Լ� ���)
SELECT empno, ename, deptno, sal,
    SUM(sal) OVER (PARTITION BY deptno ORDER BY sal ROWS BETWEEN empno PRECEDING AND CURRENT ROW) c_sum
FROM emp;


--ROWS vs RANGE ���� Ȯ���ϱ�
SELECT empno, ename, deptno, sal,
    SUM(sal) OVER (ORDER BY sal ROWS UNBOUNDED PRECEDING ) row_sum,
    SUM(sal) OVER (ORDER BY sal RANGE UNBOUNDED PRECEDING ) range_sum,
    SUM(sal) OVER (ORDER BY sal ) c_sum
FROM emp;


-- PL / SQL
-- PL / SQL �⺻����
-- DECLARE : �����, ������ �����ϴ� �κ�
-- BEGIN : PL/SQL�� ������ ���� �κ�
-- EXCEPTION : ����ó����

-- DBMS.OUTPUT.PUT_LINE �Լ��� ����ϴ� ����� ȭ�鿡 �����ֵ��� Ȱ��ȭ
SET SERVEROUTPUT ON;
DECLARE --�����
    -- java : Ÿ�� ������;
    -- PL/SQL : ������ Ÿ��;
    /*v_dname VARCHAR2(14);
    v_loc VARCHAR2(13);*/
    -- ���̺� �÷��� ���Ǹ� �����Ͽ� ������ Ÿ���� �����Ѵ�
    v_dname dept.dname %Type;
    v_loc dept.loc %Type;
BEGIN
    --DEPT ���̺��� 10�� �μ��� �μ� �̸�, LOC ������ ��ȸ
    SELECT dname,loc
    INTO v_dname, v_loc
    FROM dept
    WHERE deptno = 10;
    -- String a = "t";
    -- String b = "c";
    -- System.out.println(a + b);
    DBMS_OUTPUT.PUT_LINE(v_dname || v_loc);
END;
/
-- PL/SQL ���� ����

DESC dept;


-- 10�� �μ��� �μ��̸�, ��ġ������ ��ȸ�ؼ� ������ ���
-- ������ DBMS_OUTPUT.PUT_LINE�Լ��� �̿��Ͽ� console�� ���
CREATE OR REPLACE PROCEDURE printdept IS
--�����(�ɼ�)
    dname dept.dname %TYPE;
    loc dept.loc %TYPE;
--�����
BEGIN
    SELECT dname, loc
    INTO dname, loc
    FROM dept
    WHERE deptno = 10;
--����ó����(�ɼ�)
    DBMS_OUTPUT.PUT_LINE(dname || ' ' || loc);
END;
/

exec printdept;



CREATE OR REPLACE PROCEDURE printdept 
--�Ķ���͸� IN/OUT Ÿ��
-- p_�Ķ���͸�
( p_deptno IN dept.deptno%TYPE )
IS
--�����(�ɼ�)
    dname dept.dname%TYPE;
    loc dept.loc%TYPE;
--�����
BEGIN
    SELECT dname, loc
    INTO dname, loc
    FROM dept
    WHERE deptno = p_deptno;
--����ó����(�ɼ�)
    DBMS_OUTPUT.PUT_LINE(dname || ' ' || loc);
END;
/

exec printdept(10);


-- PL/SQL (procedure ���� �ǽ� PRO_1)
--printemp procedure ����
-- param : empno
-- login : empno�� �ش��ϴ� ����� ������ ��ȸ �Ͽ� ����̸�, �μ��̸��� ȭ�鿡 ���

CREATE OR REPLACE PROCEDURE printemp 
    ( p_empno IN emp.empno %TYPE )
IS
    ename emp.ename %TYPE;
    job emp.job %TYPE;
BEGIN
    SELECT ename, job
    INTO ename, job
    FROM emp
    WHERE empno = p_empno;
   
   DBMS_OUTPUT.PUT_LINE(ename || ' ' || job); 
END;
/

select * from emp;
exec printemp(7499);


--PL / SQL (procedure ���� �ǽ� PRO_2)
-- registdept_test procedure ����
-- param : deptno, dname, loc
-- login : �Է¹��� �μ� ������ dept_test ���̺� �ű� �Է�
-- exec registdept_test(99, 'ddit', 'daejeon');
-- dept_test���̺� ���������� �Է� �Ǿ����� Ȯ��
select * from dept;

CREATE OR REPLACE PROCEDURE registdept_test
    (p_deptno IN dept_test.deptno %TYPE, p_dname IN dept_test.dname %TYPE, p_loc IN dept_test.loc %TYPE)
IS
    deptno dept_test.deptno %TYPE;
    dname dept_test.dname %TYPE;
    loc dept_test.loc %TYPE;
BEGIN
    INSERT INTO dept_test (deptno, dname, loc)
    VALUES (p_deptno, p_dname, p_loc);
END;
/


exec registdept_test(99, 'ddit_m', 'daejeon');

select * from dept_test;








