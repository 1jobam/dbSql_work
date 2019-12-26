-- EXCEPTION
-- ���� �߻��� ���α׷��� �����Ű�� �ʰ�
-- �ش� ���ܿ� ���� �ٸ� ������ ���� ��ų�� �ְ� �� ó���Ѵ�.

-- ���ܰ� �߻��ߴµ� ����ó���� ���� ��� : pl/sql ����� ������ �Բ� ����ȴ�.
-- �������� SELECT ����� �����ϴ� ��Ȳ���� ��Į�� ������ ���� �ִ� ��Ȳ

-- emp ���̺��� ��� �̸��� ��ȸ
SET SERVEROUTPUT ON;

DECLARE
    -- ��� �̸��� ������ �� �ִ� ����
    v_ename emp.ename%TYPE;
BEGIN
    -- 14���� select ����� ������ sql --> ��Į�� ������ ������ �Ұ��ϴ�(����)
    SELECT ename
    INTO v_ename
    FROM emp;
    
EXCEPTION -- ����ó��
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('�������� select ����� ����');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('WHEN OTHERS');
END;
/

-- ����� ���� ����
-- ����Ŭ���� ������ ������ ���� �̿ܿ��� �����ڰ� �ش� ����Ʈ���� �����Ͻ� ��������
-- ������ ���ܸ� ����, ����� �� �ִ�.
-- ���� ��� SELECT ����� ���� ��Ȳ���� ����Ŭ������ NO_DATE_FOUND ���ܸ� ������
-- �ش� ���ܸ� ��� NO_EMP��� �����ڰ� ������ ���ܷ� ������ �Ͽ� ���ܸ� ���� �� �ִ�.

--
DECLARE
    -- emp ���̺� ��ȸ ����� ������ ����� ����� ���� ����
    --- ���ܸ� EXCEPTION; --> ���
    no_emp EXCEPTION;
    v_ename emp.ename%TYPE;
BEGIN
    -- NO_DATA_FOUND
    BEGIN
        SELECT ename
        INTO v_ename
        FROM emp
        WHERE empno = 7000;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE no_emp; -- java ������ throw new NoEmpException();
        END;
EXCEPTION
    WHEN no_emp THEN
        DBMS_OUTPUT.PUT_LINE('NO_EMP');
END;
/

-- ����� �Է¹޾Ƽ� �ش� ������ �̸��� �����ϴ� �Լ�
-- getEmpName(7369) --> SMITH

CREATE OR REPLACE FUNCTION getEmpName (p_empno emp.empno%TYPE)
RETURN VARCHAR2 IS
-- �����
    v_ename emp.ename%TYPE;
BEGIN
    SELECT ename
    INTO v_ename
    FROM emp
    WHERE empno = p_empno;
    
    return v_ename;
END;
/

SELECT getempname(7369)
FROM dual;

SELECT getempname(empno)
FROM emp;

select * from emp;


--PL/SQL (function �ǽ� function1)
-- �μ���ȣ�� �Ķ���ͷ� �Է¹ް� �ش� �μ��� �̸��� �����ϴ� �Լ� getdeptname�� �ۼ��غ�����.

CREATE OR REPLACE FUNCTION getdeptname (p_deptno dept.deptno%TYPE) 
RETURN VARCHAR2 IS
    v_dname dept.dname%TYPE;
BEGIN
    SELECT dname
    INTO v_dname
    FROM dept
    WHERE deptno = p_deptno;
    
    return v_dname;
END;
/

SELECT getdeptname(deptno)
FROM dept;

-- cache : 20
-- ������ ������ :
-- deptno (�ߺ� �߻�����) : �������� ���� ���ϴ�.  -- > �Լ��� ������ ���
-- empno (�ߺ��� ����) : �������� ����.

-- ���࿡ emp ���̺��� �����Ͱ� 100������ ���
-- 100���� �߿��� deptno�� ������ 4��(10~40)
SELECT getdeptname(deptno), --4����
       getempname(empno)    --row ����ŭ �����Ͱ� ����
FROM emp;


-- PL /SQL (function �ǽ� function2 )
-- ���������� ���� �ݺ��Ǵ� ������ ���Ÿ�ü�� ǥ���Ͽ����ϴ�.
-- �ش� �κ��� indent��� �̸��� �Լ��� ��ü �غ�����.
-- ���ڿ� ���ϰ��� ���� �����غ�����
CREATE OR REPLACE FUNCTION indent (p_lv NUMBER, p_dname VARCHAR2) 
RETURN VARCHAR2 IS
    v_dname VARCHAR2(200);
BEGIN
    SELECT LPAD(' ', ( p_lv - 1 ) * 4, ' ') || p_dname
    INTO v_dname
    FROM dual;
    
    --v_dname := LPAD(' ', ( p_lv - 1 ) * 4, ' ') || p_dname;
    
    return v_dname;
END;
/

SELECT deptcd, LPAD(' ',(LEVEL-1)*4,' ') || deptnm deptnm
FROM dept_h
START WITH p_deptcd IS NULL
CONNECT BY PRIOR deptcd = p_deptcd;

SELECT deptcd, indent(LEVEL, deptnm)
FROM dept_h
START WITH p_deptcd IS NULL
CONNECT BY PRIOR deptcd = p_deptcd;


-- ��Ű�� ����
CREATE OR REPLACE PACKAGE names AS
    FUNCTION getEmpname (p_empno emp.empno%TYPE) RETURN VARCHAR2;
    FUNCTION getdeptname(p_deptno dept.deptno%TYPE) RETURN VARCHAR2;
END names;
/

--��Ű�� �ٵ�
CREATE OR REPLACE PACKAGE BODY names AS
    FUNCTION getEmpname (p_empno emp.empno%TYPE) RETURN VARCHAR2 IS
        ename emp.ename%TYPE;
    BEGIN
        SELECT ename
        INTO ename
        FROM emp
        WHERE empno = p_empno;
    
        RETURN ename;
    END;
    
    FUNCTION getdeptname (p_deptno dept.deptno%TYPE)RETURN VARCHAR2 AS
        dname dept.dname%TYPE;
    BEGIN
        SELECT dname
        INTO dname
        FROM dept
        WHERE deptno = p_deptno;
        
        RETURN dname;
    END;
    
    FUNCTION indent (p_lv NUMBER, p_dname VARCHAR2) RETURN VARCHAR2 IS
        v_dname VARCHAR2(200);
    BEGIN
        SELECT LPAD(' ', ( p_lv - 1 ) * 4, ' ') || p_dname
        INTO v_dname
        FROM dual;
    
        --v_dname := LPAD(' ', ( p_lv - 1 ) * 4, ' ') || p_dname;
    
        return v_dname;
    END;
END;
/


SELECT names.getempname(empno),
       names.getdeptname(deptno)
FROM emp;


CREATE OR REPLACE package names AS
    FUNCTION getEmpname(p_empno emp.empno%TYPE) RETURN VARCHAR2;
    FUNCTION getdeptname(p_deptno dept.deptno%TYPE) RETURN VARCHAR2;
    FUNCTION indent (p_lv NUMBER, p_dname VARCHAR2) RETURN VARCHAR2;
END names;
/


-- Ʈ����
SELECT *
FROM users;

-- users ���̺��� ��й�ȣ �÷��� ������ ������ ��
-- ������ ����ϴ� ��й�ȣ �÷� �̷��� �����ϱ� ���� ���̺�
CREATE TABLE users_history(
    userid VARCHAR2(20),
    pass VARCHAR2(100),
    mod_dt date
);

CREATE OR REPLACE TRIGGER make_history
    --timing
    BEFORE UPDATE ON users
    FOR EACH ROW -- ��Ʈ����, ���� ������ ���� ������ �����Ѵ�.
    --���� ������ ���� : OLD
    --���� ������ ���� : NEW
BEGIN
    --users ���̺��� pass �÷��� ������ �� trigger ����
    IF :OLD.pass != :NEW.pass THEN
        INSERT INTO users_history
            VALUES (:OLD.userid, :OLD.pass, sysdate);
    END IF;
    --�ٸ� �÷��� ���ؼ��� �����Ѵ�.
END;
/


-- USERS ���̺��� PASS �÷��� ���� ���� ��
-- trigger�� ���ؼ� users_history ���̺� �̷��� �����Ǵ��� Ȯ��
select rownum, users_history.* from users_history;
select * from users;

update users set pass = '1234'
WHERE userid = 'brown';









