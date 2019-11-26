-- 날짜관련 함수
-- ROUND, TRUNC
-- (MOTNHS_BETWEEN) ADD_MONTHS, NEXT_DAY
-- LAST_DAY : 해당 날짜가 속한 월의 마지막 일자(DATE)

-- 월 : 1, 3, 5, 7, 8, 10, 12 : 31일
--  : 2 - 윤년 여부 28, 29
--  : 4, 6, 9, 11 : 30일

SELECT SYSDATE, LAST_DAY(SYSDATE)
FROM dual;

-- (date 종합 실습 fn3)
-- 파라미터로 yyyymm형식의 문자열을 사용 하여 (ex : yyyymm = 201912) 해당 년월에 해당하는 일자 수를 구해보세요.
-- yyyymm = 201912 -> 31
-- yyyymm = 201911 -> 30
-- yyyymm = 201602 -> 29 (2016년은 윤년)

SELECT a.*, LAST_DAY(a)- a + 1 FROM(SELECT TO_DATE('201912', 'yyyymm') a FROM dual) a;
SELECT a.*, LAST_DAY(a)- a + 1 FROM(SELECT TO_DATE('201911', 'yyyymm') a FROM dual) a;
SELECT a.*, LAST_DAY(a)- a + 1 FROM(SELECT TO_DATE('201602', 'yyyymm') a FROM dual) a;

-- '201912' --> date 타입으로 변경하기
-- 해당 날짜의 마지막 날짜로 이동
-- 일자 필드만 추출
-- DATE --> 일자컬럼(DD)만 추출
-- DATE --> 문자열(DD)
-- TO_CHAR(DATE, '포맷')
-- DATE : LAST_DAY(TO_DATE('201912', 'YYYYMM'))
-- 포맷 : 'DD'
SELECT '201912' PARAM, TO_CHAR(LAST_DAY(TO_DATE('201912', 'YYYYMM')), 'dd') DT FROM dual;
SELECT '201911' PARAM, TO_CHAR(LAST_DAY(TO_DATE('201911', 'YYYYMM')), 'dd') DT FROM dual;
SELECT '201602' PARAM, TO_CHAR(LAST_DAY(TO_DATE('201602', 'YYYYMM')), 'dd') DT FROM dual;

SELECT : yyyymm param,
        TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD') dt
FROM dual;

-- SYSDATE를 YYYY/MM/DD 포맷의 문자열로 변경
-- '2019/11/26' 문자열 --> DATE
SELECT sysdate 원조, TO_CHAR(sysdate, 'YYYY/MM/DD') 짝퉁 --2019/11/26
FROM dual;
-- '2019/11/26' 문자열 --> DATE
SELECT sysdate 원조, TO_DATE(TO_CHAR(sysdate), 'YYYY/MM/DD') 짝퉁 --2019/11/26
FROM dual;
-- 2019/11/26
SELECT TO_DATE('2019/11/26', 'YYYY/MM/DD') FROM dual;
-- YYYY-MM-DD HH24:MI:SS 문자열로 변경
SELECT sysdate, TO_CHAR(TO_DATE(TO_CHAR(SYSDATE, 'YYYY/MM/DD'), 'YYYY/MM/DD'), 'YYYY-MM-DD HH24:MI:SS') 변환
FROM dual;

--EMPNO NOT NULL NUMBER(4)
--HIREDATE      DATE
desc emp;

--empno가 7369인 직원 정보 조회 하기

EXPLAIN PLAN FOR
SELECT * 
FROM emp
WHERE empno = '7322';

Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    38 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    38 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("EMPNO"=7369)

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = '7369';

SELECT *
FROM TABLE(dbms_xplan.display);

SELECT 7300 + '69' FROM dual;

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7300 + '69'; -- 69 -> 숫자로 변경

SELECT * FROM TABLE(dbms_xplan.display);

--

SELECT *
FROM emp
WHERE hiredate > = TO_DATE('1981/06/01', 'YYYY/MM/DD');

--DATE 타입의 묵시적 형변환은 사용을 권하지 않음
--
SELECT *
FROM emp
-- WHERE hiredate > = '81/06/01' --DATE 타입의 묵시적 형변환은 사용을 권하지 않음
WHERE hiredate > = TO_DATE('81/06/01', 'RRRR/MM/DD');

SELECT TO_DATE('49/05/05', 'RR/MM/DD'),
        TO_DATE('50/05/05', 'RR/MM/DD'),
        TO_DATE('49/05/05', 'YY/MM/DD'),
        TO_DATE('50/05/05', 'YY/MM/DD')
FROM dual;

-- 숫자 --> 문자열
-- 문자열 --> 숫자
-- 숫자 : 1000000 --> 1,000,000.00 ( 한국 )
-- 숫자 : 1000000 --> 1.000.000,00 ( 독일 }
--날짜 포맷 : YYYY, MM, DD, HH24, MI, SS
--숫자 포맷 : 숫자 표현 : 9, 자리맞춤을 위한 0표시 : 0, 화폐단위 : L
--          1000자리 구분 : , 소수점 : .
--숫자 -> 문자열 TO_CHAR(숫자, '포맷')
--숫자 포맷이 길어질 경우 숫자 자리수를 충분히 표현
SELECT empno, ename, TO_CHAR(sal, 'L009,999') fm_sal
FROM emp;

SELECT TO_CHAR(10000000000, 'L999,999,999,999') 많이써
FROM dual;

--NULL 처리 함수 : NVL, NVL2, NULLIF, COALESCE

--NVL(expr1, expr2) : 함수 인자 두개
-- expr1이 NULL 이면 expr2를 반환
-- expr1이 NULL 이 아니면 expr1을 반환

SELECT empno, ename, comm, NVL(comm, -1) nvl_comm
FROM emp;

--NVL2(expr1, expr2, expr3)
--expr1 IS NOT NULL expr2 리턴
--expr1 IS NULL expr3 리턴
SELECT empno, ename, comm, NVL2(comm, 1000, -500) nvl2_comm,
        NVL2(comm, comm, -500) nvl3_comm -- NVL과 동일한 결과
FROM emp;

--NULLIF(expr1, expr2)
-- expr1 = expr2 NULL을 리턴
-- expr1 != expr2 expr1을 리턴
--comm이 NULL일때 comm+500 : NULL
-- NULLIF(NULL, NULL) : NULL
--comm이 NULL이 아닐때 com+500 : comm + 500
-- NULLIF(comm, comm+500) : comm

SELECT empno, ename, comm, NULLIF(comm, comm+500) nullif_comm
FROM emp;

--COALESCE(expr1, expr2, expr3 ......) -- 가변인자가 여러개가 올수있다.
--인자중에 첫번째로 등장하는 NULL이 아닌 exprN을 리턴
--expr1 IN NOT NULL expr1을 리턴하고
--expr1 IS NULL COALESCE(expr2, expr3.......)
select empno, ename, comm, sal, COALESCE(comm, sal) coal_sal
from emp;

-- (null 실습 fn4)
-- emp 테이블의 정보를 다음과 같이 조회되도록 쿼리를 작성하세요.
-- (nvl, nvl2, coalesce)
select empno, ename, mgr, nvl(mgr, 9999) mgr_n, nvl2(mgr, mgr, 9999) mgr_n_1, coalesce(mgr, 9999) mgr_n_2
from emp;

-- (null 실습 fn5)
-- users 테이블의 정보를 다음과 같이 조회되도록 쿼리를 작성하세요
-- reg_dt가 null일 경우 sysdate를 적용
SELECT userid, usernm, to_char(to_date(reg_dt), 'YY/MM/DD') reg_dt, nvl(to_char(to_date(reg_dt), 'YY/MM/DD'), to_char(to_date(sysdate), 'YY/MM/DD')) n_reg_dt
FROM users where userid != 'brown';

-- condition
-- case
-- emp.job 컬럼을 기준으로
-- 'SALESMAN'이면 sal * 1.05를 적요한 값 리턴
-- 'MANAGER'이면 sal * 1.10를 적용한 값 리턴
-- 'PRESIDENT'이면 sal * 1.20를 적용한 값 리턴
-- 위 3가지 직군이 아닐 경우 sal 리턴
-- empno, ename, sal, 요율 적용한 급여 AS bonus
SELECT empno, ename, job, sal,
    CASE
        WHEN job = 'SALESMAN' THEN sal * 1.05
        WHEN job = 'MANAGER' THEN sal * 1.10
        WHEN job = 'PRESIDENT' THEN sal * 1.20
        ELSE sal
    END bonus,
    comm,
    CASE
        WHEN comm IS NULL THEN -10
        ELSE comm
    END case_null
    -- NULL처리 함수 사용하지 않고 CASE 절을 이용하여
    -- comm이 NULL일 경우 -10을 리턴하도록 구성
FROM emp;


--DECODE
SELECT empno, ename, job, sal,
    DECODE(job, 'SALESMAN', sal * 1.05, 
            'MANAGER', sal * 1.10, 
            'PRESIDENT', sal * 1.20, 
            sal) bonus
FROM emp;