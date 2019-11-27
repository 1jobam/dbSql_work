-- 2019/11/26 ���� 

--CASE
-- WHEN condition THEN return1
--END

--DECODE(col | expr, search1, return1, search2, return2....., default)

-- ( condition �ǽ� cond 1)
-- emp ���̺��� �̿��Ͽ� deptno�� ���� �μ������� ���� �ؼ� ������ ���� ��ȸ�Ǵ� ������ �ۼ��ϼ���.

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

-- ( condition �ǽ� cond 2 )
-- emp ���̺��� �̿��Ͽ� hiredate�� ���� ���� �ǰ����� ���� ��������� ��ȸ�ϴ� ������ �ۼ��ϼ���.
-- (������ �������� �ϳ� ���⼭�� �Ի�⵵�� �������� �Ѵ�)
SELECT empno, ename, TO_CHAR(hiredate, 'YY') a, hiredate,
    CASE
       WHEN TO_CHAR(hiredate, 'YY') = '81' THEN '�ǰ����� �����'
       WHEN TO_CHAR(hiredate, 'YY') = '83' THEN '�ǰ����� �����'
       WHEN TO_CHAR(hiredate, 'YY') = '82' THEN '�ǰ����� ������'
       WHEN TO_CHAR(hiredate, 'YY') = '80' THEN '�ǰ����� ������'
    END contact_to_doctor
FROM emp;

SELECT empno, ename, hiredate,
    case
        when 
             mod(to_char(hiredate, 'yyyy'), 2) =
            mod(to_char(sysdate, 'yyyy'), 2)
            then '�ǰ����� �����'
            else '�ǰ����� ������'
        end contact_to_doctor
    from emp;

--2.
-- ���⵵ �ǰ����� ����ڸ� ��ȸ�ϴ� ������ �ۼ��غ�����.
--2020�⵵
SELECT empno, ename, hiredate,
    case 
       when mod(to_char(hiredate, 'yyyy'), 2) =
            mod(TO_CHAR(sysdate, 'yyyy')+1, 2)
            then '�ǰ����� �����'
            else '�ǰ����� ������'
    end
FROM emp;