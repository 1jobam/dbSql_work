-- hash join 설명
explain plan for
SELECT *
FROM dept, emp
WHERE dept.deptno = emp.deptno;

-- dept 먼저 읽는 형태
-- join 컬럼을 hash 함수로 돌려서 해당 해쉬 함수에 해당하는 bucket에 데이터를 넣는다
-- 10 --> aaabbaa (hashvalue)

--emp 테이블에 대해 위의 진행을 동일하게 진행
-- 10 --> aaabbaa (hashvalue)
explain plan for
SELECT *
FROM dept, emp
WHERE emp.deptno BETWEEN dept.deptno AND 99;

SELECT * FROM TABLE(dbms_xplan.display);
10 --> AAAAAA
20 --> AAAAAB


-- 사원번호, 사원이름, 부서번호, 급여, 부서원의 전체 급여합
SELECT empno, ename, deptno, sal,
        SUM(sal) OVER (ORDER BY sal 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) c_sum, --가장 처음부터 현재행 까지
        
        --바로 이전행이랑 현재행까지의 급여합
        sum(sal) OVER (ORDER BY sal ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) c_sum2
FROM emp
ORDER BY sal;

-- 분석함수 / window 함수 ( 그룹내 행 순서 실습 ana 7 )
-- 사원번호, 사원이름, 부서번호, 급여 정보를 부서별로 급여, 사원번호
-- 오름차순으로 정렬 했을때 자신의 급여와 선행하는 사원들의 급여합을 조회하는 쿼리를 작성하세요(window 함수 사용)
SELECT empno, ename, deptno, sal,
    SUM(sal) OVER (PARTITION BY deptno ORDER BY sal ROWS BETWEEN empno PRECEDING AND CURRENT ROW) c_sum
FROM emp;


--ROWS vs RANGE 차이 확인하기
SELECT empno, ename, deptno, sal,
    SUM(sal) OVER (ORDER BY sal ROWS UNBOUNDED PRECEDING ) row_sum,
    SUM(sal) OVER (ORDER BY sal RANGE UNBOUNDED PRECEDING ) range_sum,
    SUM(sal) OVER (ORDER BY sal ) c_sum
FROM emp;


-- PL / SQL
-- PL / SQL 기본구조
-- DECLARE : 선언부, 변수를 선언하는 부분
-- BEGIN : PL/SQL의 로직이 들어가는 부분
-- EXCEPTION : 예외처리부

-- DBMS.OUTPUT.PUT_LINE 함수가 출력하는 결과를 화면에 보여주도록 활성화
SET SERVEROUTPUT ON;
DECLARE --선언부
    -- java : 타입 변수명;
    -- PL/SQL : 변수명 타입;
    /*v_dname VARCHAR2(14);
    v_loc VARCHAR2(13);*/
    -- 테이블 컬럼의 정의를 참조하여 데이터 타입을 선언한다
    v_dname dept.dname %Type;
    v_loc dept.loc %Type;
BEGIN
    --DEPT 테이블에서 10번 부서의 부서 이름, LOC 정보를 조회
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
-- PL/SQL 블럭을 실행

DESC dept;


-- 10번 부서의 부서이름, 위치지역을 조회해서 변수에 담고
-- 변수를 DBMS_OUTPUT.PUT_LINE함수를 이용하여 console에 출력
CREATE OR REPLACE PROCEDURE printdept IS
--선언부(옵션)
    dname dept.dname %TYPE;
    loc dept.loc %TYPE;
--실행부
BEGIN
    SELECT dname, loc
    INTO dname, loc
    FROM dept
    WHERE deptno = 10;
--예외처리부(옵션)
    DBMS_OUTPUT.PUT_LINE(dname || ' ' || loc);
END;
/

exec printdept;



CREATE OR REPLACE PROCEDURE printdept 
--파라미터명 IN/OUT 타입
-- p_파라미터명
( p_deptno IN dept.deptno%TYPE )
IS
--선언부(옵션)
    dname dept.dname%TYPE;
    loc dept.loc%TYPE;
--실행부
BEGIN
    SELECT dname, loc
    INTO dname, loc
    FROM dept
    WHERE deptno = p_deptno;
--예외처리부(옵션)
    DBMS_OUTPUT.PUT_LINE(dname || ' ' || loc);
END;
/

exec printdept(10);


-- PL/SQL (procedure 생성 실습 PRO_1)
--printemp procedure 생성
-- param : empno
-- login : empno에 해당하는 사원의 정보를 조회 하여 사원이름, 부서이름을 화면에 출력

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


--PL / SQL (procedure 생성 실습 PRO_2)
-- registdept_test procedure 생성
-- param : deptno, dname, loc
-- login : 입력받은 부서 정보를 dept_test 테이블에 신규 입력
-- exec registdept_test(99, 'ddit', 'daejeon');
-- dept_test테이블에 정상적으로 입력 되었는지 확인
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








