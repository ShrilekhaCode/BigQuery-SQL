desc departments
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE FROM C##USER1.TABLE_CONSTRAINTS WHERE TABLE_NAME='DEPARTMENTS'
select constraint_name, CONSTRAINT_TYPE  from all_constraints where table_name='DEPARTMENTS'
select constraint_name, CONSTRAINT_TYPE  from all_constraints where table_name='employees'
select * from departments where department_name IN ( 'IT Support', 'Recruiting');
SELECT * FROM employees INNER JOIN departments ON departments.department_id = employees.department_id

SELECT * FROM employees INNER JOIN departments ON employees.department_id = departments.department_id
SELECT employees.* FROM employees INNER JOIN departments ON departments.department_id = employees.department_id;
SELECT departments.* FROM employees INNER JOIN departments ON departments.department_id = employees.department_id;
SELECT Employee_id, First_name, E.department_id,department_name FROM employees E INNER JOIN departments D ON E.department_id = D.department_id;
SELECT E.Employee_id, E.First_name, E.department_id, D.department_name FROM employees E INNER JOIN departments D ON E.department_id = D.department_id;
SELECT E.Employee_id, E.First_name, E.department_id, D.department_name FROM employees E LEFT OUTER JOIN departments D ON E.department_id = D.department_id;
SELECT E.Employee_id, E.First_name, E.department_id, D.department_name FROM employees E RIGHT OUTER JOIN departments D ON E.department_id = D.department_id;
SELECT E.Employee_id, E.First_name, E.department_id, D.department_id, D.department_name FROM employees E FULL OUTER JOIN departments D ON E.department_id = D.department_id;
SELECT * FROM employees E INNER JOIN departments D ON E.department_id = D.department_id;

SELECT E.Employee_id, E.First_name, E.department_id, D.department_name
FROM employees E, departments D
WHERE E.department_id = D.department_id(+);

SELECT E.Employee_id, E.First_name, E.department_id,  D.department_id, D.department_name
FROM employees E, departments D
WHERE E.department_id(+) = D.department_id;

SELECT department_id, department_name, count(*) FROM Departments GROUP BY Department_id, department_name HAVING count(*) > 1;

WITH DuplicateRecords AS (
    SELECT department_id, 
           ROW_NUMBER() OVER (PARTITION BY department_name, location_id ORDER BY department_id) AS row_num
    FROM departments
)
DELETE FROM departments
WHERE department_id IN (
    SELECT department_id
    FROM DuplicateRecords
    WHERE row_num > 1
);

    SELECT MIN(ROWID)
    FROM departments
    GROUP BY department_name, department_id;
    
DELETE FROM departments
WHERE ROWID NOT IN (
    SELECT MIN(ROWID)
    FROM departments
    GROUP BY department_name, department_id
);
SELECT * FROM departments
WHERE ROWID NOT IN (
    SELECT MIN(ROWID)
    FROM departments
    GROUP BY department_name, department_id
);

SELECT * FROM employees 
WHERE ROWID NOT IN (
    SELECT MIN(ROWID)
    FROM employees
    GROUP BY employee_id );

SELECT e.employee_id, e.first_name AS employee_name, e.manager_id,
       (SELECT m.first_name FROM employees m WHERE m.employee_id = e.manager_id) AS manager_name
FROM employees e;

SELECT e.EMPLOYEE_ID as employee_id, e.first_name as first_name, e.MANAGER_ID as manager_id, m.first_name as manager_name
FROM employees e, employees m
where e.MANAGER_ID = m.EMPLOYEE_ID;

SELECT e.EMPLOYEE_ID, e.first_name AS employee_name, e.MANAGER_ID, m.first_name AS manager_name
FROM employees e JOIN employees m
ON e.MANAGER_ID = m.EMPLOYEE_ID;

SELECT e.EMPLOYEE_ID, e.first_name AS employee_name, e.MANAGER_ID, m.first_name AS manager_name
FROM employees e, employees m
WHERE e.MANAGER_ID = m.EMPLOYEE_ID;

select * from employees
MINUS
select * from employee_copy1

select * from  employee_copy 
MINUS
select * from employee_copy1

create table employee_copy2 as (select * from  employee_copy)
select * from employee_copy2
-- below will delete 4 duplicate rows from the above table , 115 rows
delete from employee_copy2 
where rowid NOT IN (select min(rowid) from employee_copy2 GROUP BY employee_id)
select * from employee_copy2 -- returning 111

delete from employee_copy2 
where rowid NOT IN (select min(rowid) from employee_copy2 GROUP BY employee_id)

select * from  employee_copy2 
MINUS
select * from employee_copy1

select * from  employee_copy2 
union
select * from employee_copy1

SELECT  * FROM countries
WHERE country_name ='United States of America' FETCH FIRST 3 ROWS ONLY;

insert into  employee_copy2 (select * from employee_copy1) -- duplicate rows inserted
-- display duplicate rows 
select count (*) from  employee_copy2 
where rowid NOT IN (select min(rowid) from employee_copy2 GROUP BY employee_id)

select salary from (select salary from employees order by salary desc) where rownum = 1;

-- 4th highest salary
select min(salary) from 
(select salary from employees order by salary desc)
where rownum <=4;

-- 4th lowest salary 
select max(salary) from 
(select salary from employees order by salary asc)
where rownum <=4;

create table T1 (id number);
create table T2 (id number);
insert into T1 values(1);
insert into T1 values(1);
insert into T1 values(1);
insert into T1 values(2);
insert into T1 values(3);
insert into T1 values(4);
insert into T1 values(null);
select * from t1;
insert into T2 values(1);
insert into T2 values(2);
insert into T2 values(5);
insert into T2 values(null);

--If Table T1 has : ( 1,1,1,2,3,4,null ), and , Table T2 : (1,2,5, null) then
select * from T1 INNER JOIN T2 ON T1.id = T2.id; 
-- resultset is 1,1,1,2 , total 4 records
select * from T1 LEFT OUTER JOIN T2 ON T1.id = T2.id; 
-- total 7 records , the one with no match in T2 will get null value 
select * from T1 RIGHT OUTER JOIN T2 ON T1.id = T2.id; 
-- total 6 records, (1,1,1,2,5,null) so all the rows of T2 , the one with no match in T1 will get null value 
select * from T1 FULL OUTER JOIN T2 ON T1.id = T2.id; 
-- total 9 records, (1,1,1,2,3,4,null,5,null) so all the rows of T2 and T1, the one with no match will get null value 

SELECT Max(salary) , Min(salary), sum(salary) , count(salary), d.department_id
FROM employees e INNER JOIN Departments d
 ON e.department_id = d.department_id
GROUP BY d.department_id

select count(*), count(commission_pct) from employees

SELECT CEIL(15.7) "Ceiling" FROM dual; -- It will return 16
SELECT FLOOR(15.7) "Floor" FROM dual; -- It will return 15
SELECT ROUND(54.339, 2) "Round" FROM DUAL; -- returns m rounded to m places
SELECT MOD(11, 4) "Modulus" FROM DUAL; -- REturns 3
SELECT ABS(-15) "Absolute" FROM DUAL; -- Returns 15
SELECT Power(3,2) "Power Function" FROM DUAL; -- returns 9
SELECT TRUNC(29.793333,1) "Truncate" FROM DUAL; -- Truncated to 29.7
SELECT TRUNC(29.793333,-1) "Truncate" FROM DUAL; --- Truncated to 20
SELECT LTRIM('xyXxyCity Town','xy') "LTRIM Example" FROM DUAL; --- LTRIM returns XxyCity Town















