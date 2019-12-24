-- PLSQL������ index�� ���ڰ� �ƴ϶� ���ڿ��� ����
--�ڹٷ� ����
--List<String> nameList = new ArrayList<String>();
--nameList.add("brown");
--nameList.add("cony");
--nameList.add("sally");

--for(int i = 0; i < nameList.size(); i++){
--  System.out.println(nameList.get(i));
--}

--for(String name : nameList){
--  System.out.println(name);
--}
--  > > > ������ �ڹٷ� ��

-- FOR LOOP���� ����� Ŀ�� ����ϱ�
-- �μ����̺��� ��� ���� �μ��̸�, ��ġ ���� ������ ��� (CURSOR�� �̿�)

SET SERVEROUTPUT ON

-- Ŀ������ ���ڰ� ���� ���
DECLARE
    -- Ŀ�� ����
    CURSOR dept_cursor(p_deptno dept.deptno%TYPE) IS
        SELECT dname, loc, deptno
        FROM dept
        WHERE deptno = p_deptno;
    v_dname dept.dname%TYPE;
    v_loc dept.loc%TYPE;
    v_deptno dept.deptno%TYPE;
BEGIN
    FOR record_row IN dept_cursor(:p_deptno) LOOP
        dbms_output.put_line(record_row.dname || ', ' || record_row.loc);
    END LOOP;
END;
/

--FOR LOOP �ζ��� Ŀ��
--FOR LOOP �������� Ŀ���� ���� ����
DECLARE
BEGIN
    FOR record_row IN (SELECT dname, loc, deptno FROM dept) LOOP
        dbms_output.put_line(record_row.dname || ', '|| record_row.deptno || ', ' || record_row.loc);
    END LOOP;
END;
/

-- DT ����
 CREATE TABLE DT
(	DT DATE);

insert into dt
select trunc(sysdate + 10) from dual union all
select trunc(sysdate + 5) from dual union all
select trunc(sysdate) from dual union all
select trunc(sysdate - 5) from dual union all
select trunc(sysdate - 10) from dual union all
select trunc(sysdate - 15) from dual union all
select trunc(sysdate - 20) from dual union all
select trunc(sysdate - 25) from dual;

commit;
--


--PL/SQL(cursor, �������� �ǽ� PRO_3)
--dt.sql ������ ���� ���̺�� �����͸� �����ϰ�, ������ ���� ��¥
--���ݻ����� ����� ���ϴ� ���ν��� ����
--exec avgdt
CREATE OR REPLACE PROCEDURE avgdt IS
    TYPE dt_tab IS TABLE OF dt%ROWTYPE INDEX BY BINARY_INTEGER;
    v_dt_tab dt_tab;
    v_sum NUMBER := 0;
BEGIN
    SELECT *
    BULK COLLECT INTO v_dt_tab
    FROM dt
    ORDER BY dt;
    
    FOR i IN 1..v_dt_tab.count - 1 LOOP
        v_sum := v_sum + v_dt_tab(i + 1).dt - v_dt_tab(i).dt;
    END LOOP;
    
    dbms_output.put_line(v_sum / (v_dt_tab.count - 1));
END;
/

exec avgdt;



--1. rownum
--2. �м��Լ�
--3. 
SELECT AVG(sum_avg) sum_avg
FROM
(SELECT LEAD(dt) OVER (ORDER BY dt) - dt sum_avg
FROM dt);

SELECT (MAX(dt) - MIN(dt)) / (count(*) - 1) avg_sum
FROM dt;

SELECT *
FROM cycle;


-- PL/SQL ( cusor, �������� �ǽ� PRO_4 )
-- ���ڷ� ���� ��� ���� �ش��ϴ� �Ͻ����� �����ϴ� ���ν��� �ۼ�
-- cycle ���̺��� ���� �����ϴ� ������ �������
-- ������ �ش� ����� �ش��ϴ� daily �����ʹ� ����
-- �ش� ������ �̿��Ͽ� ���ڷ� ���� ����� ���ڷ� ��� �Ͽ� daily
-- ���̺� ������ �ű� ����

--1, 100, 2, 1 --> 1, 100, 20191202, 1
--             --> 1, 100, 20191209, 1

CREATE OR REPLACE PROCEDURE create_daily_sales
    (v_yyyymm IN VARCHAR2)
IS
    TYPE cal_row_type IS RECORD (
        dt VARCHAR2(8),
        day NUMBER);
    TYPE cal_tab IS TABLE OF cal_row_type INDEX BY BINARY_INTEGER;
    v_cal_tab cal_tab;
BEGIN
    -- �����ϱ� ���� �ش� ����� �ش��ϴ� �Ͻ��� �����͸� �����Ѵ�.
    DELETE daily
    WHERE dt LIKE v_yyyymm || '%';
    
    --�޷������� table ������ �����Ѵ�.
    -- �ݺ����� sql ������ �����ϱ� ���� �ѹ��� �����Ͽ� ������ ����
    SELECT TO_CHAR(TO_DATE(v_yyyymm, 'YYYYMM') + (LEVEL - 1), 'YYYYMMDD') dt,
           TO_CHAR(TO_DATE(v_yyyymm, 'YYYYMM') + (LEVEL - 1), 'D') day
    BULK COLLECT INTO v_cal_tab
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(v_yyyymm, 'YYYYMM')), 'DD');
    
    -- �����ֱ� ������ �д´�.
    FOR daily IN (SELECT * FROM cycle) LOOP
        --12�� ���ڴ޷� : cycle row �Ǽ� ��ŭ �ݺ�
        FOR i IN 1..v_cal_tab.count LOOP
            IF daily.day = v_cal_tab(i).day THEN
                --cid, pid, ����, ����
                INSERT INTO daily VALUES (daily.cid, daily.pid, v_cal_tab(i).dt, daily.cnt);
            END IF;
        END LOOP;
        dbms_output.put_line(daily.cid || ', ' || daily.day);
    END LOOP;
    COMMIT;
END;
/

exec create_daily_sales('201912');

select * from daily;
desc cycle;
desc daily;




-- VARCHAR2 Ÿ���̱� ������ '20191255' �������ִ�.

SELECT *
FROM daily
WHERE dt BETWEEN '201912' || '01' AND '201912' || '31';

-- 66
-- 1�� : 0.028��
INSERT INTO DAILY VALUES (1, 100, '20191201', 5);

-- ȿ�������� Ʃ��
SELECT cycle.cid, cycle.pid, cal.dt, cycle.cnt
FROM cycle,
(SELECT TO_CHAR(TO_DATE(:v_yyyymm, 'YYYYMM') + (LEVEL - 1), 'YYYYMMDD') dt,
           TO_CHAR(TO_DATE(:v_yyyymm, 'YYYYMM') + (LEVEL - 1), 'D') day
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:v_yyyymm, 'YYYYMM')), 'DD')) cal
WHERE cycle.day = cal.day;