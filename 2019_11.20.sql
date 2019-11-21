-- 특정 테이블의 컬럼 조회
--1. desc 테이블명
--2. select * from user_tab_columns;

--prod 테이블의 컬럼조회
desc prod;

varchar2, char --> 문자열 (character)
number --> 숫자
CLOB --> character Large OBject, 문자열 타입의 길이 제한을 피하는 타입
          -- 최대 사이즈 : VARCHAR2 (4000BYTE), CLOB : 4GB
DATE --> 날짜(일시 = 년,월,일 + 시간,분,초) -- yyyy,dd,mm + hh,,ss

--date 타입에 대한 연산의 결과는?
'2019/11/20 09:16:20' + 1 = ?

--USERS 테이블의 모든 컬럼을 조회 해보세요.
SELECT * FROM USERS;

--userid,usernm, reg_dt 세가지 컬럼만 조회
SELECT userid, usernm, reg_dt FROM USERS;

--userid,usernm, reg_dt 세가지 컬럼만 조회
--연산을 통해 새로운 컬럼을 생성 (reg_dt에 숫자 연산을 한 새로운 가공 컬럼)
--날짜 + 정수 연산은 ?? ==> 일자를 더한 날짜 타입이 결과로 나온다.
--별칭 : 기존 컬럼명이나 연산을 통해 생성된 가상 컬럼에 임의의 컬러이름을 부여
--  col(기존컬럼) | express(가상컬럼) [AS] 별칭명
SELECT userid as "아이디", usernm "이름", reg_dt as reg_date, reg_dt+5 as after5day FROM USERS;

--숫자 상수, 문자열 상수 ( oracle : '', java : '', "")
--table에 없는 값을 임으로 컬럼으로 생성
--숫자에 대한 연산 ( +, -, /, *)
--문자에 대한 연산 ( + 존재가 하지 않음, ==> ||로 사용)
SELECT (1+5)*2 "연산자", 'DB SQL 수업',
        /* userid + '_modified', 문자열 연산은 더하기 연산이 없다 */ 
        usernm || '_modeified', reg_dt 
from users;

--NULL : 아직 모르는 값
--NULL에 대한 연산 결과는 항상 NULL 이다
--DESC 테이블명 NOT NULL로 설정되어 있는 컬럼에는 값이 반드시 들어가야 한다.

--users 불필요한 데이터 삭제
-- rollback; : 되돌리기 실수시 한번의 기회
SELECT * FROM USERS;

DELETE users WHERE userid not in ('brown', 'sally', 'cony', 'moon', 'james');
commit;

--null 연산을 시험해보기 위해 moon의 reg_dt 컬럼을 null로 변경
select userid, usernm, reg_dt from users;
UPDATE users SET reg_dt = Null where userid = 'moon';

--users 테이블의 reg_dt 컬럼값에 5일을 더한 새로운 컬럼을 생성
--NULL값에 대한 연산의 결과는 NULL이다.
SELECT userid, usernm, reg_dt, reg_dt+5 FROM users;

-- 문자열 컬럼간 결합   (컬럼 || 컬럼, '문자열상수' || 컬럼)
--                    (CONCAT (컬럼, 컬럼) )
select userid, usernm, userid || usernm AS id_nm, concat(userid, usernm) as con_id_nm from users;
-- ||을 이용해서 userid, usernm, pass

select userid, usernm, pass, userid || usernm || pass as id_nm_pass, concat(userid, usernm || pass) as con_id_nm_pass, concat(concat(userid, usernm), pass)  as con2_id2_nm2_pass2  from users;

--사용자가 소유한 테이블 목록 조회
--LPROD --> select * from lprod;
select * from user_tables;

select 'select * from ' || table_name || ';' query from user_tables;
--concat 함수만 이용해서

select concat(concat('select * ','from '),table_name) || ';' as query from user_tables;
select concat(concat('select * from ', table_name), ';') as query from user_tables;

-- where : 조건이 일치하는 행만 조회하기 위해 사용
--          행에 대한 조회 기준을 작성
-- where절이 없으면 해당 테이블의 모든 행에 대해 조회
select userid, usernm, alias, reg_dt from users;

--userid 컬럼이 'brown'인 행(row)만 조회
select userid, usernm, alias, reg_dt from users where userid = 'brown';

-- emp 테이블의 전체 데이터 조회 (모든 행(row), 컬럼(colume))
select * from emp;
select * from dept;

--부서번호(deptno)가 20보다 크거나 같은 부서에서 일하는 직원 정보 조회
select * from emp where deptno >= 20;

--사원번호가 7700보다 크거나 같은 사원의 정보를 조회
select * from emp where empno >=7700;

--사원입사일자가 1982년 1월 1일 이후인 사원
-- 문자열 --> 날짜 타입으로 변경 to_date('날짜문자열', '날짜문자열포맷')
select empno, ename, hiredate, 2000 no, '문자열상수' str, to_date('19810101', 'yyyymmdd') 날짜 from emp where hiredate >= to_date('19820101','yyyymmdd');

--범위 조회 (between 시작기준 and 종료 기준)
--시작기준, 종료기준을 포함
--사원중에서 급여(sal)가 1000보다 크거나 같고, 2000보다 작거나 같은 사원 정보조회
select * from emp where sal between 1000 and 2000;  -- between 활용
--between and 연산자는 부등호 연산자로 대체 가능
select * from emp where sal >= 1000 and sal <=2000; -- and만 활용

-- emp 테이블에서 입사 일자가 1982년 1월 1일 이후부터 1983년 1월 1일 이전인 사원의 ename, hiredate 데이터를 조회하는 쿼리를 작성하시오
--(단 연산자는 between을 사용한다)
--where1
select ename, hiredate from emp where hiredate between to_date('19820101','yyyymmdd') and to_date('19830101','yyyymmdd');
--where2
-- emp 테이블에서 입사 일자가 1982년 1월 1일 이후부터 1983년 1월 1일 이전인 사원의 ename, hiredate 데이터를 조회하는 쿼리를 작성하시오.
-- (단 연산자는 비교연산자를 사용한다)
select ename 니이름, to_char(hiredate, 'yyyy-mm-dd') 날짜 from emp where hiredate >= to_date('19820101','yyyymmdd') and hiredate <= to_date('19830101','yyyymmdd');


