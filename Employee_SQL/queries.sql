--Create employee salaries view which contains employees' first name,
-- last name, employee number, sex and salary.
--view is a join between Employees table and Salaries table
CREATE VIEW employee_salaries AS
SELECT Employees.employee_number, Employees.last_name,Employees.first_name,Employees.sex,Salaries.salary
FROM Employees
LEFT JOIN Salaries ON
Salaries.employee_number=Employees.employee_number;

SELECT * FROM employee_salaries;

-- Create view of employees that were hired in 1986 that contains first name,
--last name, and hire date
CREATE VIEW employees_1986 AS
SELECT first_name,last_name,hire_date 
FROM Employees
WHERE hire_date LIKE '%1986';

SELECT * FROM employees_1986;

--Create view manager_personal_info to be joined with
-- manager_department_info. View contains employee_number,
-- last_name, and first_name
CREATE VIEW manager_personal_info AS
SELECT employee_number, last_name, first_name
FROM Employees
WHERE employee_number IN
	(SELECT employee_number
	 FROM Department_Manager
	 );

--Create view manager_departments_info to be joined with
-- manager_personal_info. View contains employee_number,
-- dept_name, and dept_number
CREATE VIEW manager_departments_info AS
SELECT employee_number,dept_number, 
	(SELECT Departments.dept_name
		FROM Departments
		WHERE Department_Manager.dept_number= Departments.dept_number)
FROM Department_Manager;

-- Create full_manager_info_view that is a join of:
-- manager_personal_info and manager_department_info.
CREATE VIEW full_manager_info AS
SELECT manager_personal_info.employee_number, manager_personal_info.first_name,
		manager_personal_info.last_name, manager_departments_info.dept_number,
		manager_departments_info.dept_name
FROM manager_personal_info
LEFT JOIN manager_departments_info ON
manager_personal_info.employee_number = manager_departments_info.employee_number;

SELECT * FROM full_manager_info;



--repeat process for non manager employees
CREATE VIEW employee_personal_info AS
SELECT employee_number, last_name, first_name
FROM Employees
WHERE employee_number IN
	(SELECT employee_number
	 FROM Department_Employee
	 );


CREATE VIEW employee_departments_info AS
SELECT employee_number,dept_number, 
	(SELECT Departments.dept_name
		FROM Departments
		WHERE Department_Employee.dept_number= Departments.dept_number)
FROM Department_Employee;

CREATE VIEW full_employee_info AS
SELECT employee_personal_info.employee_number, employee_personal_info.first_name,
		employee_personal_info.last_name,
		employee_departments_info.dept_name
FROM employee_personal_info
LEFT JOIN employee_departments_info ON
employee_personal_info.employee_number = employee_departments_info.employee_number;

SELECT * FROM full_employee_info;


--Create hercules_info view that contains:
-- first name, last name and sex for employees Whose:
--first name is Hercules and last name begins with B.
CREATE VIEW hercules_info AS
SELECT first_name,last_name,sex
FROM EMPLOYEES
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';


-- Create view sales_dept_info that contains:
-- all information from emloyee_departments_info where dept_name is 'Sales'
CREATE VIEW sales_dept_info AS
SELECT * FROM employee_departments_info
WHERE dept_name='Sales';

-- Create view employee_sales_dept_info
-- used to query join between Employees and sales_dept_info
CREATE VIEW employee_sales_dept_info AS
SELECT Employees.employee_number, Employees.first_name, Employees.last_name, sales_dept_info.dept_name
FROM Employees
RIGHT JOIN sales_dept_info ON
Employees.employee_number = sales_dept_info.employee_number;

SELECT * FROM employee_departments_info;



--repeat process for Sales & Development
CREATE VIEW sales_development_dept_info AS
SELECT * FROM employee_departments_info
WHERE dept_name IN ('Sales','Development');
		
CREATE VIEW employee_sales_development_dept_info AS
SELECT Employees.employee_number, Employees.first_name, Employees.last_name, 
sales_development_dept_info.dept_name
FROM Employees
RIGHT JOIN sales_development_dept_info ON
Employees.employee_number = sales_development_dept_info.employee_number;

SELECT * FROM employee_sales_development_dept_info;


-- Create last_name view count that contains the frequency of
-- the last names of employees
CREATE VIEW last_name_count AS
SELECT last_name, COUNT(last_name) AS "last_name_total"
FROM Employees
GROUP BY last_name
ORDER BY "last_name_total" DESC;

SELECT * FROM last_name_count;