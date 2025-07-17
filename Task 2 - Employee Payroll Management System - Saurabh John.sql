-- Create the payroll database
CREATE DATABASE IF NOT EXISTS payroll_database;
USE payroll_database;

-- Create the employees table
CREATE TABLE employees (
    EMPLOYEE_ID INT PRIMARY KEY,
    NAME VARCHAR(100),
    DEPARTMENT VARCHAR(100),
    EMAIL VARCHAR(100),
    PHONE_NO BIGINT,
    JOINING_DATE DATE,
    SALARY DECIMAL(10,2),
    BONUS DECIMAL(10,2),
    TAX_PERCENTAGE DECIMAL(5,2)
);

-- Insert sample data to employees table

INSERT INTO employees VALUES
(1, 'Alice Johnson', 'Sales', 'alice.johnson@example.com', 9876543210, '2024-12-01', 85000, 20000, 15.00),
(2, 'Bob Smith', 'IT', 'bob.smith@example.com', 8765432109, '2023-03-15', 95000, 15000, 20.00),
(3, 'Charlie Brown', 'HR', 'charlie.brown@example.com', 7654321098, '2024-03-20', 60000, 45000, 10.00),
(4, 'Diana Prince', 'Sales', 'diana.prince@example.com', 6543210987, '2024-02-10', 90000, 10000, 18.00),
(5, 'Ethan Hunt', 'Marketing', 'ethan.hunt@example.com', 5432109876, '2023-11-01', 70000, 3000, 12.00),
(6, 'Farah Khan', 'IT', 'farah.khan@example.com', 4321098765, CURDATE() - INTERVAL 2 MONTH, 105000, 12000, 22.00),
(7, 'George Lee', 'HR', 'george.lee@example.com', 3210987654, CURDATE() - INTERVAL 3 MONTH, 60000, 3000, 10.00),
(8, 'Hannah Ray', 'Finance', 'hannah.ray@example.com', 2109876543, '2023-10-15', 115000, 7000, 25.00),
(9, 'Isaac Newton', 'Sales', 'isaac.newton@example.com', 1098765432, '2024-01-05', 88000, 8000, 15.00),
(10, 'Julia Stiles', 'Finance', 'julia.stiles@example.com', 1987654321, '2025-01-10', 85000, 10000, 25.00);

-- PAYROLL QUERIES

-- a) List of employees sorted by salary in descending order
SELECT * FROM employees
ORDER BY SALARY DESC;

-- b) Employees with total compensation > $100,000
SELECT *, (SALARY + BONUS) AS TOTAL_COMPENSATION
FROM employees
WHERE (SALARY + BONUS) > 100000;

-- c) Update bonus for Sales department by 10%
UPDATE employees
SET BONUS = BONUS * 1.10
WHERE DEPARTMENT = 'Sales';

-- d) Net salary = (SALARY + BONUS) - TAX
SELECT NAME, DEPARTMENT, SALARY, BONUS, TAX_PERCENTAGE,
       (SALARY + BONUS - ((SALARY + BONUS) * TAX_PERCENTAGE / 100)) AS NET_SALARY
FROM employees;

-- e) Avg, min and max salary per department
SELECT DEPARTMENT,
       AVG(SALARY) AS AVG_SALARY,
       MIN(SALARY) AS MIN_SALARY,
       MAX(SALARY) AS MAX_SALARY
FROM employees
GROUP BY DEPARTMENT;

-- ADVANCED QUERIES

-- a) Employees joined in the last 6 months
SELECT *
FROM employees
WHERE JOINING_DATE >= (CURRENT_DATE - INTERVAL 6 MONTH);

-- b) Count of employees per department
SELECT DEPARTMENT, COUNT(*) AS EMPLOYEE_COUNT
FROM employees
GROUP BY DEPARTMENT;

-- c) Department with highest average salary
SELECT DEPARTMENT, AVG(SALARY) AS AVG_SALARY
FROM employees
GROUP BY DEPARTMENT
ORDER BY AVG_SALARY DESC
LIMIT 1;

-- d) Employees who have the same salary as at least one other
SELECT *
FROM employees
WHERE SALARY IN (
    SELECT SALARY
    FROM employees
    GROUP BY SALARY
    HAVING COUNT(*) > 1
);