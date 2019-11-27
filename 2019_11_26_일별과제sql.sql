-- 2019/11/26 과제 

--CASE
-- WHEN condition THEN return1
--END

--DECODE(col | expr, search1, return1, search2, return2....., default)

-- ( condition 실습 cond 1)
-- emp 테이블을 이용하여 deptno에 따라 부서명으로 변경 해서 다음과 같이 조회되는 쿼리를 작성하세요.

SELECT empno, ename, deptno, 
    case 
        WHEN deptno = 10 THEN 'ACCOUNTING'
        WHEN deptno = 20 THEN 'RESEARCH'
        WHEN deptno = 30 THEN 'SALES'
        WHEN deptno = 40 THEN 'OPERATIONS'
    END dname,
    DECODE(deptno, 10, 'ACCOUTING',
                    20, 'RESEARCH',
                    30, 'SALES',
                    40, 'OPERATIONS') dname2
FROM emp;

select MOD(TO_CHAR(sysdate, 'yyyy'), 2)
from dual;

-- ( condition 실습 cond 2 )
-- emp 테이블을 이용하여 hiredate에 따라 올해 건강보험 검진 대상자인지 조회하는 쿼리를 작성하세요.
-- (생년을 기준으로 하나 여기서는 입사년도를 기준으로 한다)
SELECT empno, ename, TO_CHAR(hiredate, 'YY') a, hiredate,
    CASE
       WHEN TO_CHAR(hiredate, 'YY') = '81' THEN '건감검진 대상자'
       WHEN TO_CHAR(hiredate, 'YY') = '83' THEN '건감검진 대상자'
       WHEN TO_CHAR(hiredate, 'YY') = '82' THEN '건감검진 비대상자'
       WHEN TO_CHAR(hiredate, 'YY') = '80' THEN '건감검진 비대상자'
    END contact_to_doctor
FROM emp;

SELECT empno, ename, hiredate,
    case
        when 
             mod(to_char(hiredate, 'yyyy'), 2) =
            mod(to_char(sysdate, 'yyyy'), 2)
            then '건강검진 대상자'
            else '건강검진 비대상자'
        end contact_to_doctor
    from emp;

--2.
-- 내년도 건강검진 대상자를 조회하는 쿼리를 작성해보세요.
--2020년도
SELECT empno, ename, hiredate,
    case 
       when mod(to_char(hiredate, 'yyyy'), 2) =
            mod(TO_CHAR(sysdate, 'yyyy')+1, 2)
            then '건강검진 대상자'
            else '건강검진 비대상자'
    end
FROM emp;