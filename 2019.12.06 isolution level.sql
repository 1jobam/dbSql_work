-- �б� �ϰ���(ISOLATION LEVER)
-- DML���� �ٸ� ����ڿ��� ��� ������
-- ��ġ���� ������ ����(0-3)

-- ISOLATION LEVEL2
-- ���� Ʈ����ǿ��� ���� ������
-- (FOR UPDATE)�� ����, ���� ��������
SELECT * FROM dept WHERE deptno = 40 FOR UPDATE;

-- �ٸ� Ʈ����ǿ��� ������ ���ϱ� ������
-- �� Ʈ����ǿ��� �ش� ROW�� �׻�
-- ������ ��������� ��ȸ �� �� �ִ�.

-- ������ ���� Ʈ����ǿ��� �űԵ�����
-- �Է��� commit�� �ϸ� �� Ʈ����ǿ���
-- ��ȸ�� �ȴ�. (�����б�) phantom read

-- ISOLATION LEVEL 3
-- SERIALIZABLE READ
-- Ʈ������� ������ ��ȸ ������
-- Ʈ����� ���� �������� ��������.
-- �� ���� Ʈ����ǿ��� �����͸� �ű� �Է�, ����, ���� �� COMMIT�� �ϴ���
-- ���� Ʈ����ǿ����� �ش� �����͸� ���� �ʴ´�.

--Ʈ����� ���� ���� (serializable read)
SET TRANSACTION isolation LEVEL SERIALIZABLE;
--t0 : 4����
select * from dept;