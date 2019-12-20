-- 분석함수 / window 함수 ( 그룹내 행 순서 - 생각해보기, 실습 no_ana 3 )
-- 모든 사원에 대해 사원번호, 사원이름, 입사일자, 급여를 급여가 낮은순으로
-- 조회 해보자. 급여가 동일할 경우 사원번호가 빠른사람이 우선순위가 높다
-- 우선순위가 가장 낮은 사람부터 본인 까지의 급여 합을 새로운 컬럼으로 생성
-- window (분석함수) 없이 진행

SELECT c.empno, c.ename, c.sal, sum(c.sal) c_sum
FROM
(SELECT a.*, rownum rn
FROM
(SELECT empno, ename, sal
FROM emp
ORDER BY sal)a,
(SELECT empno,ename, sal
FROM emp
ORDER BY sal)b
WHERE a.ename = b.ename)c,
(SELECT a.*, rownum rn
FROM
(SELECT empno, ename, sal
FROM emp
ORDER BY sal)a,
(SELECT empno,ename, sal
FROM emp
ORDER BY sal)b
WHERE a.ename = b.ename)d
WHERE c.rn >= d.rn
GROUP BY c.empno, c.ename, c.sal
ORDER BY sal;


select a.empno, a.ename, a.sal1,sum(sal2) as c_sum
from
(select empno,ename,rownum as rn1, sal1
from 
(select empno, ename,sal as sal1
from emp
order by sal)) a,
(select rownum as rn2, sal as sal2
from 
(select sal
from emp
order by sal)) b
where a.rn1 >= b.rn2
group by a.empno, a.ename, a.sal1
order by c_sum;
