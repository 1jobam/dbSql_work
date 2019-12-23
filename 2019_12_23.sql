-- PL/SQL ( procedure ���� �ǽ� PRO_3)
-- UPDATEdept_test procedure ����
-- param : deptno, dname, loc
-- login : �Է¹��� �μ� ������ dept_test ���̺� ���� ����
-- exec UPDATEdept_test (99, 'ddit_m', 'daejeon');
-- dept_test ���̺� ���������� ���� �Ǿ����� Ȯ��

CREATE OR REPLACE PROCEDURE UPDATEdept_test
    (p_deptno IN dept_test.deptno %TYPE, 
    p_dname IN dept_test.dname %TYPE, 
    p_loc IN dept_test.loc %TYPE)
IS
--(�����)
    deptno dept_test.deptno %TYPE;
    dname dept_test.dname %TYPE;
    loc dept_test.loc %TYPE;
    --�Ķ���� Ÿ���� ������ ����ΰ� �߰��� �ʿ䰡 ����.
BEGIN
--(����)
    UPDATE dept_test SET dname = p_dname, loc = p_loc
    WHERE deptno = p_deptno;
    
--(����)
END;
/

exec UPDATEdept_test (99, 'ddit_m', 'daejeon_m');


select * from dept_test;

-- ROWTYPE
-- Ư�� ���̺��� ROW ������ ���� �� �ִ� ���� Ÿ��
-- TYPE : ���̺��.���̺��÷���%TYPE -- ����
-- ROWTYPE : ���̺��%ROWTYPE -- ���պ��� Ȱ��

SET SERVEROUTPUT ON;
DECLARE
    --dept ���̺��� row ������ ���� �� �ִ� ROWTYPE ��������
    dept_row dept%ROWTYPE;
BEGIN
    SELECT *
    INTO dept_row
    FROM dept
    WHERE DEPTNO = 10;
    
    dbms_output.put_line(dept_row.dname || ', '  || dept_row.loc);
END;
/

-- RECODE TYPE : �����ڰ� �÷��� ���� �����Ͽ� ���߿� �ʿ��� TYPE�� ����
-- TYPE Ÿ���̸� IS RECORD(�÷�1 �÷�1TYPE, �÷�2 �÷�2TYPE);
-- �Ʒ��� �ڹ� ������ �������� ��
-- public class Ŭ������{ �ʵ�type �ʵ�(�÷�) //ex)String name, �ʵ�2type �ʵ�(�÷�)2 //ex) int age };

DECLARE
    -- �μ��̸�, LOC ������ ������ �� �ִ� RECORD TYPE ����
    --TYPE dept_row IS RECORD(dname VARCHAR2(14), loc VARCHAR2(13)); --Ÿ���� ����� ���� �Ѱ�
    TYPE dept_row IS RECORD(dname dept.dname%TYPE, loc dept.loc%TYPE); --Ÿ���� ������ �Ѱ�
    
    -- type������ �Ϸ�, type�� ���� ������ ����
    -- java : Class ������ �ش� class�� �ν��Ͻ��� ���� (new)
    -- plsql ���� ���� : �����̸� ����Ÿ�� dname dept.dname %TYPE;
    dept_row_data dept_row;
BEGIN
    SELECT dname, loc
    INTO dept_row_data
    FROM dept
    WHERE deptno = 10;
    
    dbms_output.put_line(dept_row_data.dname || ', ' || dept_row_data.loc);
END;
/

-- TABLE TYPE : �������� ROWTYPE�� ������ �� �ִ� TYPE
-- col --> row --> table
-- TYPE ���̺�Ÿ�Ը� IS TABLE OF ROWTYPE/RECORD INDEX BY �ε��� Ÿ��(BINARY_INTEGER)
-- java�� �ٸ��� pl/sql������ array ������ �ϴ� table type�� �ε�����
-- ���� �Ӹ� �ƴ϶�, ���ڿ� ���µ� �����ϴ�
--ex) arr(1).name = 'brown'
--ex) arr('person').name = 'brown'
-- �׷��� ������ INDEX�� ���� Ÿ���� ����Ѵ�.
-- �Ϲ������� array(list) ������ ����� INDEX BY BINARY_INTEGER�� �ַ� ����Ѵ�.

-- dept ���̺��� row�� ������ ���� �� �� �ִ� dept_tab TABLE TYPE �����Ͽ�
-- SELECT * FROM detp; �� ���(������)�� ������ ��´�.
DECLARE
    TYPE dept_tab IS TABLE OF dept%ROWTYPE INDEX BY BINARY_INTEGER;
    v_dept dept_tab;
BEGIN
    -- �� row�� ���� ������ ���� : INTO
    -- ���� row�� ���� ������ ���� : BULK COLLECT INTO
    SELECT *
    BULK COLLECT INTO v_dept
    FROM dept;
    
    --dbms_output.put_line('SQL%ROWCOUNT : ' ||  v_dept.dept); --// ����
    
    FOR i IN 1..v_dept.count LOOP
        -- �ڹٿ����� arr[1] -> pl/sql ������ ���ȣ�� �ƴ� �Ұ�ȣ�� �Է�
        dbms_output.put_line('dept_row : ' || v_dept(i).deptno || ', ' || v_dept(i).dname);
    END LOOP;
END;
/



-- ���� ���� IF
-- IF condition THEN
--    statement
-- ELSIF condition THEN
--       statement
-- ELSE
--       statement
-- END IF;

-- PL/SQL IF �ǽ�
-- ���� p(NUMBER) �� 2��� ���� �Ҵ��ϰ�
-- java int a = 5;
-- int a;
-- a = 5;
-- IF ������ ���� p�� ���� 1, 2, �� ���� ���϶� �ؽ�Ʈ ���
DECLARE
    p NUMBER := 2; --���� ����� �Ҵ��� �ѹ��忡�� ����
BEGIN
    --p := 2; -- ��� �Ҵ��� ������ �ϴ°͵� ����
    IF p = 1 THEN
        dbms_output.put_line('p = 1');
    ELSIF p = 2 THEN    -- java�� ������ �ٸ��� (else if -> ELSIF)
        dbms_output.put_line('p = 2');
    ELSE
        dbms_output.put_line(p || '�̶��' || p || '�̶��' || p || '�̶��' || p || '�̶��');
    END IF;
END;
/

-- FOR LOOP
-- FOR �ε������� IN [REVERSE] START..END LOOP
--      �ݺ����๮
-- END LOOP;
-- 0~5���� ���� ������ �̿��Ͽ� �ݺ��� ����
DECLARE
BEGIN
    FOR i IN 0..5 LOOP
        dbms_output.put_line(i);
    END LOOP;
END;
/

-- 1~10 : 55
-- 1~10 ������ ���� loop�� �̿��Ͽ� ���, ����� s_val �̶�� ������ ���
-- dbms_output.put_line �Լ��� ���� ȭ�鿡 ���
DECLARE
    s_val NUMBER;
BEGIN
    s_val := 0;
    FOR i IN 1..10 LOOP
        s_val := s_val + i;
    END LOOP;
    dbms_output.put_line('��ǳ�� : ' || s_val);
END;
/

-- while loop
-- WHILE condition LOOP
--   statement
-- END LOOP;
-- 0���� 5���� WHILE ���� �̿��Ͽ� ���
DECLARE
    i NUMBER := 0;
BEGIN
    WHILE i <= 5 LOOP
        dbms_output.put_line(i);
        i := i + 1;
    END LOOP;
END;
/

-- LOOP ���
-- LOOP
--      statement;
--      EXIT [WHEN condition];
--  END LOOP;
DECLARE
    i NUMBER := 0;
BEGIN
    LOOP
        dbms_output.put_line(i);
        EXIT WHEN i >= 5;
        i := i + 1;
    END LOOP;
END;
/

-- CURSOR : SQL�� �����ڰ� ������ �� �ִ� ��ü -- ����

-- ������ : �����ڰ� ������ Ŀ������ ������� ���� ����, ORACLE���� �ڵ�����
--         OPEN, ����, FETCH, CLOSE�� �����Ѵ�.
-- ����� : �����ڰ� �̸��� ���� Ŀ��, �����ڰ� ���� �����ϸ�
--         ����, OPEN, FETCH, CLOSE �ܰ谡 �����Ѵ�.

-- CURSOR Ŀ�� �̸� IS -- Ŀ�� ����
--      QUERY
-- OPEN Ŀ���̸�; -- Ŀ�� OPEN
-- FETCH Ŀ���̸� INTO ����1, ����2...  -- Ŀ�� FETCH(�� ����)
-- CLOSE Ŀ���̸�; -- Ŀ�� CLOSE

-- �μ����̺��� ��� ���� �μ��̸�, ��ġ ���� ������ ��� (CURSOR�� �̿�)
DECLARE
    -- Ŀ�� ����
    CURSOR dept_cursor IS
        SELECT dname, loc, deptno
        FROM dept;
    v_dname dept.dname%TYPE;
    v_loc dept.loc%TYPE;
    v_deptno dept.deptno%TYPE;
BEGIN
    -- Ŀ�� ����
    OPEN dept_cursor;
    LOOP
        FETCH dept_cursor INTO v_dname, v_loc, v_deptno;
        exit WHEN dept_cursor%NOTFOUND; 
        dbms_output.put_line(v_dname || ', ' || v_loc || ', ' || v_deptno);
    END LOOP;
    CLOSE dept_cursor;
END;
/

