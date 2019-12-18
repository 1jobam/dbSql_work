--2019.12.17 복습

SELECT
    MIN(NVL(DECODE(d, 1, dt), dt - d + 1)) 일, MIN(NVL(DECODE(d, 2, dt), dt - d + 2)) 월, MIN(NVL(DECODE(d, 3, dt), dt - d + 3)) 화,
    MIN(NVL(DECODE(d, 4, dt), dt - d + 4)) 수, MIN(NVL(DECODE(d, 5, dt), dt - d + 5)) 목, MIN(NVL(DECODE(d, 6, dt), dt - d + 6)) 금, MIN(NVL(DECODE(d, 7, dt), dt - d + 7)) 토
FROM
    (SELECT 
            TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1) dt,
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1), 'D') d,
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL), 'IW') iw
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD'))
    GROUP BY dt - (d - 1)
    ORDER BY dt - (d - 1);
    
-- 201910 : 35, 첫주의 일요일: 20190929, 마지막주의 토요일: 20191102
-- 일(1), 월(2), 화(3), 수(4), 목(5), 금(6), 토(7)
SELECT ldt - fdt + 1
FROM
(SELECT LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) dt,

        LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) + 
        7 - TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'D') ldt,
        
        TO_DATE(:yyyymm, 'YYYYMM') -
        (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') - 1) fdt
        
FROM dual);



--TEST
SELECT LAST_DAY(SYSDATE) dt,
        LAST_DAY(SYSDATE) + 
        7 - TO_CHAR(LAST_DAY(SYSDATE), 'D') ldt
FROM dual;



-- 과제 복습
SELECT
    MIN(DECODE(d, 1, dt)) 일, MIN(DECODE(d, 2, dt)) 월, MIN(DECODE(d, 3, dt)) 화,
    MIN(DECODE(d, 4, dt)) 수, MIN(DECODE(d, 5, dt)) 목, MIN(DECODE(d, 6, dt)) 금, MIN(DECODE(d, 7, dt)) 토
FROM
    (SELECT 
            TO_DATE(:yyyymm, 'YYYYMM') - (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') - 1) +(LEVEL -1) dt,
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') - (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') - 1) + (LEVEL - 1), 'D') d,
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') - (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') - 1) + (LEVEL), 'IW') iw
    FROM dual
    CONNECT BY LEVEL <= (SELECT ldt - fdt + 1
                        FROM
                        (SELECT LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) dt,
                        
                        LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) + 
                        7 - TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'D') ldt,
                        
                        TO_DATE(:yyyymm, 'YYYYMM') -
                        (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') - 1) fdt
                        
                        FROM dual)))
GROUP BY dt - (d - 1)
ORDER BY dt - (d - 1);

-- 계층구조 시작
SELECT dept_h.*, LEVEL, LPAD(' ', (LEVEL - 1) * 3) || deptnm
FROM dept_h
START WITH deptcd = 'dept0' --시작점은 deptcd = 'dept0' --> XX회사(최상위노드) 조직.
CONNECT BY PRIOR deptcd = p_deptcd;

SELECT LPAD('XX회사', 15, '*'),
        LPAD('XX회사', 15)
FROM dual;
/* 진행순서
    dept0(XX회사)
        dept0_00(디자인부)
            dept0_00_0(디자인팀)
        dept0_01(정보기획부)
            dept0_01_0(기획팀)
                dept0_00_0_0(기획파트)
        dept0_02(정보시스템부)
            dept0_02_0(개발1팀)
            dept0_02_1(개발2팀)
*/

--  계층쿼리 ( 실습 h_2 )
SELECT LEVEL AS LV, deptcd, deptnm, LPAD(' ', (LEVEL - 1) * 3) || deptnm AS P_DEPTCD
FROM dept_h
START WITH deptcd = 'dept0_02'
CONNECT BY PRIOR deptcd = p_deptcd;

-- 디자인팀(dept0_00_0)을 기준으로 상향식 계층쿼리 작성
--자기 부서의 부모 부서와 연결을 한다.
-- 디자인팀
-- 상향식
-- PRIOR은 한번만 쓰지 않아도된다.
-- CONNECT BY 뒤에 꼭 PRIOR 이 올필요는 없다.
SELECT dept_h.*, LEVEL
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY deptcd = PRIOR p_deptcd AND PRIOR deptnm LIKE '디자인%'; -- 요런방식도 가능

-- 이해하기
-- 조인 조건은 한컬럼에만 적용가능한가?
SELECT *
FROM tab a, tab_b
WHERE tab_a.a = tab_b.a
AND tab_a.b = tab_b.b;

-- 계층쿼리 ( 상향식 실습 h_3 )
SELECT deptcd, LPAD(' ', (LEVEL - 1) * 4) || deptnm AS deptnm, p_deptcd
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY deptcd = PRIOR p_deptcd;

-- 계층쿼리 ( 실습 h_4 )
-- 계층형쿼리 복습.sql을 이용하여 테이블을 생성하고 다음과 같은
-- 결과가 나오도록 쿼리를 작성 하시오
-- s.id : 노드 아이디
-- ps_id : 부모 노드 아이디
-- value : 노드값
SELECT LPAD(' ', (LEVEL -1) * 4) || s_id AS s_id, value
FROM h_sum
START WITH s_id = '0'
CONNECT BY PRIOR s_id = ps_id;

-- 계층쿼리 ( 실습 h_5 )
-- 계층형쿼리 스크립트.sql을 이용하여 테이블을 생성하고 다음과 같은
-- 결과가 나오도록 쿼리를 작성 하시오
-- org_cd : 부서코드
-- parent_org_cd : 부모 부서코드
-- no_emp : 부서 인원수
select * from no_emp;

SELECT LPAD(' ', (LEVEL-1) * 4) || ORG_CD AS ORG_CD, NO_EMP
FROM no_emp
START WITH ORG_CD = 'XX회사'
CONNECT BY PRIOR ORG_CD = PARENT_ORG_CD;

-- pruning branch (가지치기)
-- 계층 쿼리의 실행순서
-- FROM --> START WITH ~ CONNECT BY --> WHERE
-- 조건을 CONNECT BY 절에 기술한 경우
-- . 조건에 따라 다음 ROW로 연결이 안되고 종료
-- 조건을 WHERE 절에 기술한 경우
-- . START WITH ~ CONNECT DY 절에 의해 계층으로 나온 결과에
-- WHERE 절에 기술한 결과 값에 해당하는 데이터만 조회

-- 최상위 노드에서 하향식으로 탐색
SELECT *
FROM dept_h
WHERE deptcd = 'dept0';

-- CONNECT BY절에 deptnm != '정보기획부' 조건을 기술한 경우
SELECT *
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = P_deptcd AND deptnm != '정보기획부';


-- WHERE 절에 deptnm != '정보기획부' 조건을 기술한 경우
-- 계층쿼리를 실행하고나서 최종 결과에 WHERE 절 조건을 적용
SELECT *
FROM dept_h
WHERE deptnm != '정보기획부'
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = P_deptcd;

--계층 쿼리에서 사용 가능한 특수 함수
-- CONNECT_BY_ROOT(col) 가장 최상위 row의 col 정보 값 조회
-- SYS_CONNECT_BY_PATH(col, 구분자) : 최상위 row에서 현재 row까지 col값을
-- 구분자로 연결해준 문자열 (EX : XX회사 - 디자인부디자인팀)
-- CONNECT_BY_ISLEAF : 해당 ROW가 마지막 노드인지
-- leaf node : 1, node : 0
SELECT deptcd, LPAD(' ', (LEVEL - 1) * 4) || deptnm,
    CONNECT_BY_ROOT(deptnm) c_root,
    LTRIM(SYS_CONNECT_BY_PATH(deptnm, '-'), '-') sys_path,
    CONNECT_BY_ISLEAF isleaf
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = P_deptcd;

-- 계층쿼리 ( 게시글 계층형쿼리 샘플 자료.sql, 실습 h6 )
-- 게시글을 저장하는 board_test 테이블을 이용하여 계층 쿼리를 작성 하시오.
select * from board_test;

SELECT seq, LPAD(' ', (LEVEL - 1) * 4) || title title
FROM board_test
START WITH PARENT_SEQ is null
CONNECT BY PRIOR seq = parent_seq;

-- 계층쿼리 ( 게시글 계층형쿼리 샘플 자료.sql, 실습 h7 )
select * from board_test;

SELECT SEQ, LPAD(' ', (LEVEL - 1) * 4) || title AS title
FROM board_test
START WITH PARENT_SEQ is null
CONNECT BY PRIOR seq = parent_seq
ORDER BY seq desc;

-- 계층쿼리 ( 게시글 계층형쿼리 샘플 자료.sql, 실습 h8)
-- 게실글은 가장 최신글이 최상위로 온다. 가장 최신글이 오도록 정렬 하시오
SELECT seq, LPAD(' ', (LEVEL - 1) * 4) || title AS title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY seq DESC;
