CREATE TABLE Employees (
    employee_number INTEGER NOT NULL PRIMARY KEY,
    employee_title_id VARCHAR(255) NOT NULL,
    birth_date VARCHAR(255) NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    sex VARCHAR(255) NOT NULL,
    hire_date VARCHAR(255) NOT NULL
    );

CREATE TABLE Departments (
    dept_number VARCHAR(255) NOT NULL PRIMARY KEY,
    dept_name VARCHAR(255) NOT NULL 
	);

CREATE TABLE Titles (
    employee_title_id VARCHAR(255) NOT NULL PRIMARY KEY ,
    title VARCHAR(255) NOT NULL
    );

CREATE TABLE Salaries (
    employee_number INTEGER NOT NULL,
    salary INT NOT NULL,
	FOREIGN KEY (employee_number)
	REFERENCES Employees(employee_number),
	PRIMARY KEY (employee_number)
	);

CREATE TABLE Department_Manager (
    dept_number VARCHAR(255) NOT NULL,
    employee_number INTEGER NOT NULL,
	FOREIGN KEY(dept_number)
	REFERENCES Departments(dept_number),
	FOREIGN KEY(employee_number)
	REFERENCES Employees(employee_number),
    PRIMARY KEY (dept_number,employee_number)
     );

CREATE TABLE Department_Employee (
    employee_number INTEGER NOT NULL,
    dept_number VARCHAR(255) NOT NULL,
	FOREIGN KEY(employee_number)
	REFERENCES Employees(employee_number),
	FOREIGN KEY(dept_number)
	REFERENCES Departments(dept_number),
    PRIMARY KEY (employee_number,dept_number)
    );

ALTER TABLE Employees ADD FOREIGN KEY(employee_title_id)
REFERENCES Titles(employee_title_id);

