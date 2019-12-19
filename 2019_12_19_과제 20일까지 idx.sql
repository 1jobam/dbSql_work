-- 분석함수 / window 함수 ( 그룹내 행 순서 - 생각해보기, 실습 no_ana 3 )
-- 모든 사원에 대해 사원번호, 사원이름, 입사일자, 급여를 급여가 낮은순으로
-- 조회 해보자. 급여가 동일할 경우 사원번호가 빠른사람이 우선순위가 높다
-- 우선순위가 가장 낮은 사람부터 본인 까지의 급여 합을 새로운 컬럼으로 생성
-- window (분석함수) 없이 진행

SELECT a.empno, a.ename, a.sal, b.sal
FROM
(SELECT empno, ename, sal, rownum
FROM emp
ORDER BY sal)a,
(SELECT empno,ename, sal, rownum
FROM emp
ORDER BY sal)b
WHERE a.ename = b.ename;

