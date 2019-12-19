-- ����̸�, �����ȣ, ��ü�����Ǽ�
SELECT ename, empno, COUNT(*), SUM(sal)
FROM emp
GROUP BY ename, empno;

-- (�����غ��� �ǽ� ana0)
-- ����� �μ��� �޿�(sql)�� ���� ���ϱ�
-- emp ���̺� ���
SELECT a.ename, a.sal, a.deptno, b.rn
FROM 
(SELECT ename, sal, deptno, ROWNUM j_rn
    FROM
    (SELECT ename, sal, deptno
     FROM emp
     ORDER BY deptno, sal DESC)) a,

(SELECT rn, ROWNUM j_rn
FROM
    (SELECT b.*, a.rn
    FROM 
    (SELECT ROWNUM rn
     FROM dual
     CONNECT BY level <= (SELECT COUNT(*) FROM emp)) a,
    
    (SELECT deptno, COUNT(*) cnt
     FROM emp
     GROUP BY deptno) b
    WHERE b.cnt >= a.rn
    ORDER BY b.deptno, a.rn )) b
WHERE a.j_rn = b.j_rn;

-- ana 0�� �м��Լ���
SELECT ename, sal, deptno,
    RANK() OVER (PARTITION BY deptno ORDER BY sal DESC) rn
FROM emp;

-- �� window �Լ��� �м�
SELECT ename, sal, deptno,
    RANK() OVER(PARTITION BY deptno ORDER BY sal) sal_rank,
    DENSE_RANK() OVER (PARTITION BY deptno ORDER BY sal) sal_dense_rank,
    ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal) sal_row_numbe
FROM emp;


-- �м��Լ� / window  �Լ� (�ǽ� ana1)
-- ����� ��ü �޿� ������ rank, dense_rank, row_number�� �̿��Ͽ� ���ϼ���.
-- �� �޿��� ������ ��� ����� ���� ����� ���� ������ �ǵ��� �ۼ��ϼ���.
SELECT empno, ename, sal, deptno,
    RANK() OVER(ORDER BY sal DESC, empno) sal_rank,
    DENSE_RANK() OVER(ORDER BY sal DESC, empno) sal_dense_rank,
    ROW_NUMBER() OVER(ORDER BY sal DESC, empno) sal_row_number
FROM emp;

-- �м��Լ� / window �Լ� ( �ǽ� no_ana1 )
-- ������ ��� ������ Ȱ���Ͽ�.
-- ��� ����� ���� �����ȣ, ����̸�, �ش� ����� ���� �μ��� ��� ����
-- ��ȸ�ϴ� ������ �ۼ��ϼ���.
SELECT b.empno, b.ename, b.deptno, a.cdept FROM
(SELECT deptno, COUNT(deptno) cdept
FROM emp
GROUP BY deptno) a,
(SELECT empno, ename, deptno
FROM emp) b
WHERE a.deptno = b.deptno
ORDER BY deptno;

-- �����ȣ, ����̸�, �μ���ȣ, �μ��� ������
SELECT empno, ename, deptno,
    COUNT(*) OVER (PARTITION BY deptno) cnt
FROM emp;

-- �м��Լ� / window �Լ� ( �ǽ� ana2 )
-- window function�� �̿��Ͽ� ��� ����� ���� �����ȣ, ����̸�, ����
-- �޿�, �μ���ȣ�� �ش� ����� ���� �μ��� �޿� ����� ��ȸ �ϴ� ������ �ۼ��ϼ���
-- (�޿� ����� �Ҽ��� ��° �ڸ����� ���Ѵ�)
SELECT empno, ename, sal, deptno,
    ROUND(AVG(sal) OVER (PARTITION BY deptno), 2) sal_avg
FROM emp;

-- �м��Լ� / window �Լ� ( �ǽ� ana3 )
-- window function�� �̿��Ͽ� ��� ����� ���� �����ȣ, ����̸�, ����,
-- �޿�, �μ���ȣ�� �ش� ����� ���� �μ��� ���� ���� �޿��� ��ȸ�ϴ� ������ �ۼ��ϼ���.
SELECT empno, ename, sal, deptno,
    MAX(sal) OVER (PARTITION BY deptno) max_sal
FROM emp;

-- �м��Լ� / window �Լ� ( �ǽ� ana4 )
-- window function�� �̿��Ͽ� ��� ����� ���� �����ȣ, ����̸�, ����
-- �޿�, �μ���ȣ�� �ش� ����� ���� �μ��� ���� ���� �޿��� ��ȸ�ϴ� ������ �ۼ��ϼ���.
SELECT empno, ename, sal, deptno,
    MIN(sal) OVER (PARTITION BY deptno) min_sal
FROM emp;

-- ��ü����� ������� �޿������� �ڽź��� �Ѵܰ� ���� ����� �޿�
-- (�޿��� ������� �Ի����ڰ� ���� ����� ���� ����)
SELECT empno, ename, hiredate, sal,
    LEAD(sal) OVER (ORDER BY SAL DESC, hiredate) lead_sal
FROM emp;

--�м��Լ� / window �Լ� (�׷쳻 �� ���� �ǽ� ana5)
--window function�� �̿��Ͽ� ��� ����� ���� �����ȣ, ����̸�,
--�Ի�����, �޿�, ��ü ����� �޿� ������ 1�ܰ� ���� ����� �޿��� ��ȸ�ϴ� ������ �ۼ��ϼ���.
--(�޿��� ���� ��� �Ի����� ���� ����� ��������)
SELECT empno, ename, hiredate, sal,
    LAG(sal) OVER (ORDER BY sal DESC, hiredate) lag_sal
FROM emp;

--�м��Լ� / window �Լ� (�׷쳻 �� ���� �ǽ� ana6)
--window function�� �̿��Ͽ� ��� ����� ���� �����ȣ, ����̸�,
--�Ի�����, ����(job), �޿� ������ ������(JOB) �� �޿� ������ 1�ܰ� ����
--����� �޿��� ��ȸ�ϴ� ������ �ۼ��ϼ���
--(�޿��� ���� ��� �Ի����� ���� ����� ��������)
SELECT empno, ename, hiredate, job, sal,
    LAG(sal) OVER (PARTITION BY job ORDER BY sal DESC, hiredate) lag_sal
FROM emp;