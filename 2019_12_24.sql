-- PLSQL에서는 index를 숫자가 아니라 문자열도 가능
--자바로 보면
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
--  > > > 위에는 자바로 비교

-- FOR LOOP에서 명시적 커서 사용하기
-- 부서테이블의 모든 행의 부서이름, 위치 지역 정보를 출력 (CURSOR를 이용)

SET SERVEROUTPUT ON

-- 커서에서 인자가 들어가는 경우
DECLARE
    -- 커서 선언
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

--FOR LOOP 인라인 커서
--FOR LOOP 구문에서 커서를 직접 선언
DECLARE
BEGIN
    FOR record_row IN (SELECT dname, loc, deptno FROM dept) LOOP
        dbms_output.put_line(record_row.dname || ', '|| record_row.deptno || ', ' || record_row.loc);
    END LOOP;
END;
/

-- DT 생성
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


--PL/SQL(cursor, 로직제어 실습 PRO_3)
--dt.sql 파일을 통해 테이블과 데이터를 생성하고, 다음과 같은 날짜
--간격사이의 평균을 구하는 프로시져 생성
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
--2. 분석함수
--3. 
SELECT AVG(sum_avg) sum_avg
FROM
(SELECT LEAD(dt) OVER (ORDER BY dt) - dt sum_avg
FROM dt);

SELECT (MAX(dt) - MIN(dt)) / (count(*) - 1) avg_sum
FROM dt;

SELECT *
FROM cycle;


-- PL/SQL ( cusor, 로직제어 실습 PRO_4 )
-- 인자로 들어온 년월 값에 해당하는 일실적을 생성하는 프로시져 작성
-- cycle 테이블에는 고객이 애음하는 요일이 들어있음
-- 생성전 해당 년월에 해당하는 daily 데이터는 삭제
-- 해당 요일을 이용하여 인자로 들어온 년월의 일자로 계산 하여 daily
-- 테이블에 데이터 신규 생성

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
    -- 생성하기 전에 해당 년월에 해당하는 일실적 데이터를 삭제한다.
    DELETE daily
    WHERE dt LIKE v_yyyymm || '%';
    
    --달력정보를 table 변수에 저장한다.
    -- 반복적인 sql 실행을 방지하기 위해 한번만 실행하여 변수에 저장
    SELECT TO_CHAR(TO_DATE(v_yyyymm, 'YYYYMM') + (LEVEL - 1), 'YYYYMMDD') dt,
           TO_CHAR(TO_DATE(v_yyyymm, 'YYYYMM') + (LEVEL - 1), 'D') day
    BULK COLLECT INTO v_cal_tab
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(v_yyyymm, 'YYYYMM')), 'DD');
    
    -- 애음주기 정보를 읽는다.
    FOR daily IN (SELECT * FROM cycle) LOOP
        --12월 일자달력 : cycle row 건수 만큼 반복
        FOR i IN 1..v_cal_tab.count LOOP
            IF daily.day = v_cal_tab(i).day THEN
                --cid, pid, 일자, 수량
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




-- VARCHAR2 타입이기 때문에 '20191255' 들어갈수도있다.

SELECT *
FROM daily
WHERE dt BETWEEN '201912' || '01' AND '201912' || '31';

-- 66
-- 1건 : 0.028초
INSERT INTO DAILY VALUES (1, 100, '20191201', 5);

-- 효율적으로 튜닝
SELECT cycle.cid, cycle.pid, cal.dt, cycle.cnt
FROM cycle,
(SELECT TO_CHAR(TO_DATE(:v_yyyymm, 'YYYYMM') + (LEVEL - 1), 'YYYYMMDD') dt,
           TO_CHAR(TO_DATE(:v_yyyymm, 'YYYYMM') + (LEVEL - 1), 'D') day
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:v_yyyymm, 'YYYYMM')), 'DD')) cal
WHERE cycle.day = cal.day;