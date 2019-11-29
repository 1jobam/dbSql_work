-- ���� ( 8 ~ 13 )

-- ( �ǽ� join 8 )
-- erd ���̱׷��� �����Ͽ� countries, regions ���̺��� �̿��Ͽ� ������ �Ҽ� ������ ������ ���� ����� �������� ������ �ۼ��غ�����.
-- (������ ������ ����)
select * from countries;
select * from regions;

SELECT b.region_id, b.region_name, a.country_name
FROM countries a JOIN regions b ON b.region_id = a.region_id WHERE b.region_name = 'Europe';


-- ( �ǽ� join 9 )
-- erd ���̾�׷��� �����Ͽ� countries, regions, locations ���̺��� �̿��Ͽ� ������ �Ҽ� ����, ������ �Ҽӵ� ���� �̸��� ������ ���� ����� �������� ���� �ۼ��ϱ�.
-- (������ ������ ����)
select * from countries;
select * from regions;
select * from locations;

SELECT a.region_id, a.region_name, b.country_name, c.city
FROM regions a JOIN countries b ON a.region_id = b.region_id JOIN locations c ON b.country_id = c.country_id
WHERE a.region_name = 'Europe';

-- ( �ǽ� join 10 )
-- erd ���̾�׷��� �����Ͽ� countries, regions, locations, departments ���̺��� �̿��Ͽ� ������ �Ҽ� ����,
-- ������ �Ҽӵ� ���� �̸� �� ���ÿ� �ִ� �μ��� ������ ���� ����� �������� ������ �ۼ��غ�����.
-- (������ ������ ����)
select * from countries;
select * from regions;
select * from locations;
select * from departments;

SELECT a.region_id, b.region_name, a.country_name, c.city, d.department_name
FROM countries a 
JOIN regions b ON a.region_id = b.region_id 
JOIN locations c ON a.country_id = c.country_id
JOIN departments d ON c.location_id = d.location_id WHERE b.region_name = 'Europe';

-- ( �ǽ� join 11 )
select * from employees;

SELECT a.region_id, b.region_name, a.country_name, c.city, d.department_name, concat(f.first_name, f.last_name) name
FROM countries a 
JOIN regions b ON a.region_id = b.region_id 
JOIN locations c ON a.country_id = c.country_id
JOIN departments d ON c.location_id = d.location_id
JOIN employees f ON d.department_id = f.department_id
WHERE b.region_name = 'Europe';

-- ( �ǽ� join 12 )
select * from employees;
select * from jobs;

SELECT a.employee_id, concat(a.first_name, a.last_name) name, b.job_id, b.job_title
FROM employees a JOIN jobs b ON a.job_id = b.job_id;

-- ( �ǽ� join 13 )
select * from employees;
select * from jobs;
SELECT a.manager_id mng_id, a.employee_id, concat(a.first_name, a.last_name) name, b.job_id, b.job_title
FROM employees a JOIN jobs b ON a.job_id = b.job_id;