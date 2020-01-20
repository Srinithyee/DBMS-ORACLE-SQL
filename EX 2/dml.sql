

REM 11. Display first name, job id and salary of all the employees.

SELECT  first_name  AS  "FIRST NAME",
        job_id      AS  "JOB ID",
        salary      AS  "SALARY"
FROM    employees;

REM 12. Display the id, name(first & last), salary and annual salary of all the employees. Sort the 
REM     employees by first name. Label the columns as shown below:
REM     (EMPLOYEE_ID, FULL NAME, MONTHLY SAL, ANNUAL SALARY)

SELECT  employee_id                     AS  "EMPLOYEE ID",
        CONCAT(first_name,last_name)    AS  "FULL NAME",
        salary                          AS  "MONTHLY SALARY",
        salary*12                       AS  "ANNUAL SALARY"
FROM    employees;

REM 13. List the different jobs in which the employees are working for.

SELECT  DISTINCT job_id  AS   "JOBS"
FROM    employees;

REM 14. Display the id, first name, job id, salary and commission of employees who are earning 
REM     commissions.

SELECT  employee_id     AS  "EMPLOYEE ID",
        first_name      AS  "FIRST NAME",
        salary          AS  "SALARY",
        commission_pct  AS  "COMMISSION"
FROM    employees
WHERE   commission_pct IS NOT NULL;

REM 15. Display the details (id, first name, job id, salary and dept id) of employees who are 
REM     MANAGERS.

SELECT  employee_id     AS  "EMPLOYEE ID",
        first_name      AS  "FIRST NAME",
        job_id          AS  "JOB ID",
        salary          AS  "SALARY",
        department_id   AS  "DEPARTMENT ID"
FROM    employees
WHERE   job_id  LIKE '%MAN';

REM 16. Display the details of employees other than sales representatives (id, first name, hire date, 
REM     job id, salary and dept id) who are hired after ‘01­May­1999’ or whose salary is at least 
REM     10000

SELECT  employee_id     AS  "EMPLOYEE ID",
        first_name      AS  "FIRST NAME",
        hire_date       AS  "HIRE DATE",
        job_id          AS  "JOB ID",
        salary          AS  "SALARY",
        department_id   AS  "DEPARTMENT ID"
FROM    employees
WHERE   salary >=10000  OR  hire_date > to_date('01-MAY-1999', 'DD-MON-YYYY')
AND     department_id   NOT LIKE 'SA_REP';

REM 17. Display the employee details (first name, salary, hire date and dept id) whose salary falls in 
REM     the range of 5000 to 15000 and his/her name begins with any of characters (A,J,K,S). Sort 
REM     the output by first name.

SELECT      first_name      AS  "FIRST NAME",
            salary          AS  "SALARY",
            hire_date       AS  "HIRE DATE",
            department_id   AS  "DEPARTMENT ID"
FROM        employees
WHERE       first_name  LIKE    'A%'
OR          first_name  LIKE    'J%'
OR          first_name  LIKE    'K%'
OR          first_name  LIKE    'S%'
AND         salary      BETWEEN 5000 AND 15000
ORDER BY    first_name;

REM 18. Display the experience of employees in no. of years and months who were hired after 1998. 
REM     Label the columns as: (EMPLOYEE_ID, FIRST_NAME, HIRE_DATE, EXP­YRS, EXP­MONTHS)

SELECT  employee_id                                                 AS  "EMPLOYEE ID",
        first_name                                                  AS  "FIRST NAME",
        hire_date                                                   AS  "HIRE DATE",
        TRUNC((sysdate - hire_date)/(365))                          AS  "EXPYRS",
        TRUNC(MOD(sysdate - hire_date, 365)/30)                     AS  "EXPMONTHS"
FROM    employees
WHERE   EXTRACT(YEAR FROM hire_date) > 1998;

REM 19. Display the total number of departments.

SELECT  COUNT(DISTINCT(department_id))  AS  "NO. OF DEPARTMENTS"
FROM    employees;

REM 20. Show the number of employees hired by year­wise. Sort the result by year­wise.

SELECT  COUNT(*)                        AS  "NO. OF EMPLOYEES",
        EXTRACT(YEAR FROM hire_date)    AS  "YEAR"
FROM        employees
GROUP BY    EXTRACT(YEAR FROM hire_date)
ORDER BY    EXTRACT(YEAR FROM hire_date);

REM 21. Display the minimum, maximum and average salary, number of employees for each 
REM     department. Exclude the employee(s) who are not in any department. Include the 
REM     department(s) with at least 2 employees and the average salary is more than 10000. Sort the 
REM     result by minimum salary in descending order.

SELECT  MIN(salary)             AS  "MIN. SALARY",
        MAX(salary)             AS  "MAX. SALARY",
        TRUNC(AVG(salary),2)    AS  "AVG. SALARY",
        COUNT(*)                AS  "NO. OF EMPLOYEES"
FROM        employees
GROUP BY    department_id
HAVING      COUNT(*) >=2
AND         AVG(salary) > 10000
ORDER BY    MIN(salary) DESC;

