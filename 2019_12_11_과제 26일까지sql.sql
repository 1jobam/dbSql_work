-- 테이블 생성
DROP TABLE jobs;
DROP TABLE job_history;
DROP TABLE employees;
DROP TABLE departments;
DROP TABLE locations;
DROP TABLE countries;
DROP TABLE regions;


CREATE TABLE JOBS
    (
    JOB_ID VARCHAR2(10) CONSTRAINT pk_job_01 PRIMARY KEY,
    JOB_TITLE VARCHAR2(35),
    MIN_SALARY NUMBER(6),
    MAX_SALARY NUMBER(6)
    );
    
CREATE TABLE REGIONS
    (
    REGION_ID NUMBER CONSTRAINT pk_reg_01 PRIMARY KEY,
    REGION_NAME VARCHAR2(25)
    );
    
CREATE TABLE COUNTRIES
    (
    COUNTRY_ID CHAR(2) CONSTRAINT pk_cout_01 PRIMARY KEY,
    COUNTRY_NAME VARCHAR2(40),
    REGION_ID NUMBER,
    
    CONSTRAINT fk_cout_01 FOREIGN KEY (REGION_ID) REFERENCES REGIONS (REGION_ID)
    );
    
CREATE TABLE LOCATIONS
    (
    LOCATION_ID NUMBER(4) CONSTRAINT pk_loc_01 PRIMARY KEY,
    STREET_ADDRESS VARCHAR2(40),
    POSTAL_CODE VARCHAR2(12),
    CITY VARCHAR2(30),
    STATE_PROVINCE VARCHAR2(25),
    COUNTRY_ID CHAR(2),
    
    CONSTRAINT fk_loc_01 FOREIGN KEY (COUNTRY_ID) REFERENCES COUNTRIES (COUNTRY_ID)
    );
    
CREATE TABLE EMPLOYEES
    (
    EMPLOYEE_ID NUMBER(6) CONSTRAINT pk_emp_01 PRIMARY KEY,
    FIRST_NAME VARCHAR2(20) CONSTRAINT NN_emp_01 NOT NULL,
    LAST_NAME VARCHAR2(25) CONSTRAINT NN_emp_02 NOT NULL,
    EMAIL VARCHAR2(25),
    PHONE_NUMBER VARCHAR2(20),
    HIRE_DATE DATE CONSTRAINT NN_emp_03 NOT NULL,
    JOB_ID VARCHAR2(10) CONSTRAINT NN_emp_04 NOT NULL,
    SALARY NUMBER(8, 2),
    COMMISSION_PCT NUMBER(2, 2),
    MANAGER_ID NUMBER(6),
    DEPARTMENT_ID NUMBER(4),
    
    CONSTRAINT fk_emp_01 FOREIGN KEY (JOB_ID) REFERENCES JOBS (JOB_ID),
    CONSTRAINT fk_emp_02 FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENTS (DEPARTMENT_ID)
    );
    
CREATE TABLE DEPARTMENTS
    (
    DEPARTMENT_ID NUMBER(4) CONSTRAINT pk_dept_01 PRIMARY KEY,
    DEPARTMENT_NAME VARCHAR2(30) CONSTRAINT NN_dept_01 NOT NULL,
    MANAGER_ID NUMBER(6),
    LOCATION_ID NUMBER(4),
    
    CONSTRAINT fk_dept_01 FOREIGN KEY (MANAGER_ID) REFERENCES EMPLOYEES (EMPLOYEE_ID),
    CONSTRAINT fk_dept_02 FOREIGN KEY (LOCATION_ID) REFERENCES LOCATIONS (LOCATION_ID)
    );
    


CREATE TABLE JOB_HISTORY
    (
    EMPLOYEE_ID NUMBER(6) CONSTRAINT pk_job_h_01 PRIMARY KEY,
    START_DATE DATE CONSTRAINT pj_job_h_02 PRIMARY KEY,
    END_DATE DATE CONSTRAINT NN_job_01 NOT NULL,
    JOB_ID VARCHAR2(10) CONSTRAINT NN_job_h_02 NOT NULL,
    DEPARTMENT_ID NUMBER(4),
    
    CONSTRAINT fk_job_h_01 FOREIGN KEY (JOB_ID) REFERENCES JOBS (JOB_ID),
    CONSTRAINT fk_job_h_02 FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENT (DEPARTMENT_ID)
    );
