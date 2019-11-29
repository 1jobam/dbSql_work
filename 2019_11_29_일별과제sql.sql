-- 과제 ( 8 ~ 13 )

-- ( 실습 join 8 )
-- erd 다이그램을 참고하여 countries, regions 테이블을 이용하여 지역별 소속 국가를 다음과 같은 결과가 나오도록 쿼리를 작성해보세요.
-- (지역은 유럽만 한정)
select * from countries;
select * from regions;

SELECT b.region_id, b.region_name, a.country_name
FROM countries a JOIN regions b ON b.region_id = a.region_id WHERE b.region_name = 'Europe';


-- ( 실습 join 9 )
-- erd 다이어그램을 참고하여 countries, regions, locations 테이블을 이용하여 지역별 소속 국가, 국가에 소속된 도시 이름을 다음과 같은 결과가 나오도록 쿼리 작성하기.
-- (지역은 유럽만 한정)
select * from countries;
select * from regions;
select * from locations;

SELECT a.region_id, a.region_name, b.country_name, c.city
FROM regions a JOIN countries b ON a.region_id = b.region_id JOIN locations c ON b.country_id = c.country_id
WHERE a.region_name = 'Europe';

-- ( 실습 join 10 )
-- erd 다이어그램을 참고하여 countries, regions, locations, departments 테이블을 이용하여 지역별 소속 국가,
-- 국가에 소속된 도시 이름 및 도시에 있는 부서를 다음과 같은 결과가 나오도록 쿼리를 작성해보세요.
-- (지역은 유럽만 한정)
select * from countries;
select * from regions;
select * from locations;
select * from departments;

SELECT a.region_id, b.region_name, a.country_name, c.city, d.department_name
FROM countries a 
JOIN regions b ON a.region_id = b.region_id 
JOIN locations c ON a.country_id = c.country_id
JOIN departments d ON c.location_id = d.location_id WHERE b.region_name = 'Europe';

-- ( 실습 join 11 )
select * from employees;

SELECT a.region_id, b.region_name, a.country_name, c.city, d.department_name, concat(f.first_name, f.last_name) name
FROM countries a 
JOIN regions b ON a.region_id = b.region_id 
JOIN locations c ON a.country_id = c.country_id
JOIN departments d ON c.location_id = d.location_id
JOIN employees f ON d.department_id = f.department_id
WHERE b.region_name = 'Europe';

-- ( 실습 join 12 )
select * from employees;
select * from jobs;

SELECT a.employee_id, concat(a.first_name, a.last_name) name, b.job_id, b.job_title
FROM employees a JOIN jobs b ON a.job_id = b.job_id;

-- ( 실습 join 13 )
select * from employees;
select * from jobs;
SELECT a.manager_id mng_id, a.employee_id, concat(a.first_name, a.last_name) name, b.job_id, b.job_title
FROM employees a JOIN jobs b ON a.job_id = b.job_id;