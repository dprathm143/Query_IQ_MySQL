SHOW DATABASES;

CREATE DATABASE EMPLOYEES;
USE EMPLOYEES;

SHOW TABLES;

CREATE TABLE EmployeeInfo
(
	EMPID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    EMPF_NAME CHAR(25),
    EMPL_NAME CHAR(25),
    DEPARTMENT CHAR(25),
    PROJECT CHAR(25),
    ADDRESS CHAR(25),
    DOB DATE,
    GENDER CHAR(25)
);

SELECT * FROM EMPLOYEEINFO;

INSERT INTO EmployeeInfo
	(EMPID, EMPF_NAME, EMPL_NAME, DEPARTMENT, PROJECT, ADDRESS, DOB, GENDER) VALUES
		(1,'SANJAY','MEHRA','HR','P1','HYDERABAD(HYD)','2019-05-01','M'),
        (2,'ANANYA','MISHRA','ADMIN','P2','DELHI(DEL)','1968-05-02','F'),
        (3,'ROHAN','DIWAN','ACCOUNT','P3','MUMBAI(MUM)','1980-01-01','M'),
        (4,'SONIA','KULKARNI','HR','P1','HYDERABAD(HYD)','1992-05-02','F'),
        (5,'ANKIT','KAPOOR','ADMIN','P2','DELHI(DEL)','1994-07-03','M');
        
-- truncate TABLE EMPLOYEEINFO;

-- DROP TABLE EMPLOYEEINFO;

CREATE TABLE EMPLOYEE_POSITION
(
	EMPID INT,
    EMP_POSITION CHAR(25),
    DATEOFJOINING DATE,
    SALARY INT(15),
    FOREIGN KEY (EMPID)
		REFERENCES EmployeeInfo(EMPID)
        ON DELETE CASCADE
);

INSERT INTO EMPLOYEE_POSITION
	(EMPID, EMP_POSITION, DATEOFJOINING, SALARY) VALUES
		(1,'MANAGER','2019-05-01',500000),
        (2,'EXECUTIVE','2019-05-02',75000),
        (3,'MANAGER','2019-05-01',90000),
        (2,'LEAD','2019-05-02',85000),
        (1,'EXECUTIVE','2019-05-01',300000);

-- Q1. Write a query to fetch the EmpFname from the EmployeeInfo table in the upper case and use the ALIAS name as EmpName.

SELECT UPPER(EMPF_NAME) AS FIRST_NAME
FROM EMPLOYEEINFO;

SELECT LOWER(EMPF_NAME) AS FIRST_NAME
FROM EMPLOYEEINFO;

-- Q2. Write a query to fetch the number of employees working in the department ‘HR’.

SELECT COUNT(*) 
FROM EMPLOYEEINFO
WHERE DEPARTMENT = 'HR';

-- Q3. Write a query to get the current date.

SELECT CURDATE();
SELECT SYSDATE();

-- Q4. Write a query to retrieve the first four characters of  EmpLname from the EmployeeInfo table.

SELECT substr(EMPL_NAME, 1,4) 
FROM EMPLOYEEINFO;

-- Q5. Write a query to fetch only the place name(string before brackets) from the Address column of EmployeeInfo table.

SELECT mid(ADDRESS, 0, locate('(',ADDRESS))
FROM EMPLOYEEINFO;

-- SELECT substring(ADDRESS, 1 , CHARINDEX('(',ADDRESS))
-- FROM EMPLOYEEINFO;

-- Q6. Write a query to create a new table which consists of data and structure copied from the other table.

CREATE TABLE NEWTABLE AS
SELECT *
FROM EMPLOYEEINFO;

SELECT * FROM EMPLOYEEINFO;

UPDATE EMPLOYEEINFO
SET DOB = '1986-01-12'
WHERE EMPID = 1;

-- Q7. Write q query to find all the employees whose salary is between 50000 to 100000.

SELECT * 
FROM EMPLOYEE_POSITION
WHERE SALARY BETWEEN 50000 AND 100000;

-- Q8. Write a query to find the names of employees that begin with ‘S’

SELECT * 
FROM EMPLOYEEINFO
WHERE EMPF_NAME LIKE 'S%';

-- Q9. Write a query to fetch top N records.

SELECT * 
FROM EMPLOYEE_POSITION
ORDER BY SALARY DESC LIMIT N;

SELECT * FROM EmpPosition ORDER BY Salary DESC LIMIT N;

-- Q10. Write a query to retrieve the EmpFname and EmpLname in a single column as “FullName”. The first name and the last name must be separated with space.

SELECT CONCAT(EMPF_NAME,' ',EMPL_NAME) AS FULLNAME
FROM EMPLOYEEINFO;

-- Q11. Write a query find number of employees whose DOB is between 02/05/1970 to 31/12/1975 and are grouped according to gender

SELECT COUNT(*),GENDER
FROM EMPLOYEEINFO
WHERE DOB BETWEEN '1980-05-02' AND '1998-12-31'
GROUP BY GENDER;

-- Q12. Write a query to fetch all the records from the EmployeeInfo table ordered by EmpLname in descending order and Department in the ascending order.

SELECT *
FROM EMPLOYEEINFO
ORDER BY EMPL_NAME DESC,DEPARTMENT ASC;

-- Q13. Write a query to fetch details of employees whose EmpLname ends with an alphabet ‘A’ and contains five alphabets.

SELECT *
FROM EMPLOYEEINFO
WHERE EMPL_NAME LIKE '____A';

-- Q14. Write a query to fetch details of all employees excluding the employees with first names, “Sanjay” and “Sonia” from the EmployeeInfo table.

SELECT *
FROM EMPLOYEEINFO
WHERE EMPF_NAME NOT IN ('SANJAY','SONIA');

-- Q15. Write a query to fetch details of employees with the address as “DELHI(DEL)”.

SELECT * 
FROM EMPLOYEEINFO
WHERE ADDRESS LIKE 'DELHI(DEL)';

-- Q16. Write a query to fetch all employees who also hold the managerial position.

SELECT E.EMPF_NAME, E.EMPL_NAME, P.EMP_POSITION
FROM EMPLOYEEINFO E
INNER JOIN EMPLOYEE_POSITION P 
ON E.EMPID = P.EMPID
AND P.EMP_POSITION IN ('MANAGER');

-- Q17. Write a query to fetch the department-wise count of employees sorted by department’s count in ascending order.

SELECT DEPARTMENT, COUNT(EMPID) AS EMPDEPTCOUNT
FROM EMPLOYEEINFO
GROUP BY DEPARTMENT
ORDER BY EMPDEPTCOUNT ASC;

-- Q18. Write a query to calculate the even and odd records from a table.

SELECT * FROM EMPLOYEEINFO
WHERE MOD(EMPID ,2) <> 0;

SELECT * FROM EMPLOYEEINFO
WHERE MOD(EMPID , 2) <> 1;

-- Q19. Write a SQL query to retrieve employee details from EmployeeInfo table who have a date of joining in the EmployeePosition table.

SELECT * FROM EMPLOYEEINFO E
WHERE EXISTS
(SELECT * FROM EMPLOYEE_POSITION P
WHERE E.EMPID = P.EMPID);

-- Q20. Write a query to retrieve two minimum and maximum salaries from the EmployeePosition table.

SELECT DISTINCT SALARY
FROM EMPLOYEE_POSITION E1
WHERE 2 >= (
	SELECT COUNT(DISTINCT SALARY)
    FROM EMPLOYEE_POSITION E2
    WHERE E1.SALARY >= E2.SALARY)
    ORDER BY E1.SALARY DESC;

SELECT DISTINCT SALARY
FROM EMPLOYEE_POSITION E1
WHERE 2 >= (
	SELECT COUNT(DISTINCT SALARY)
    FROM EMPLOYEE_POSITION E2
    WHERE E1.SALARY <= E2.SALARY)
    ORDER BY E1.SALARY DESC;
    
-- Q21. Write a query to find the Nth highest salary from the table without using TOP/limit keyword.

SELECT Salary 
FROM Employee_Position E1 
WHERE 2 = ( 
      SELECT COUNT( DISTINCT ( E2.Salary ) ) 
      FROM Employee_Position E2 
      WHERE E2.Salary >  E1.Salary );
      
-- Q22. Write a query to retrieve duplicate records from a table.

SELECT COUNT(*)  DEPARTMENT, EMPID, EMPF_NAME
FROM EMPLOYEEINFO
GROUP BY EMPID, EMPF_NAME,DEPARTMENT
HAVING COUNT(*) > 1;

-- Q23. Write a query to retrieve the list of employees working in the same department.

SELECT DISTINCT E.EMPID, E.EMPF_NAME, E.DEPARTMENT
FROM EMPLOYEEINFO E, EMPLOYEEINFO E1
WHERE E.DEPARTMENT = E1.DEPARTMENT AND E.EMPID != E1.EMPID;

-- Q24. Write a query to retrieve the last 3 records from the EmployeeInfo table.

SELECT * 
FROM EMPLOYEEINFO
WHERE EMPID <= 3
UNION
SELECT * FROM 
(
	SELECT * FROM EMPLOYEEINFO E 
    ORDER BY E.EMPID DESC
) AS E1 
WHERE E1.EMPID <= 3;

-- Q25. Write a query to find the third-highest salary from the EmpPosition table.

 SELECT *
 FROM EMPLOYEE_POSITION E1
 WHERE 2 = (
	SELECT COUNT(DISTINCT SALARY)
    FROM EMPLOYEE_POSITION E2
    WHERE E2.SALARY > E1.SALARY
 );

-- Q26. Write a query to display the first and the last record from the EmployeeInfo table.

SELECT * 
FROM EMPLOYEEINFO
WHERE EMPID = (
	SELECT MIN(EMPID)
    FROM EMPLOYEEINFO
);

SELECT *
FROM EMPLOYEEINFO
WHERE EMPID = (
	SELECT MAX(EMPID)
    FROM EMPLOYEEINFO
);

-- Q27. Write a query to add email validation to your database



-- Q28. Write a query to retrieve Departments who have less than 2 employees working in it.

SELECT DEPARTMENT,COUNT(EMPID) AS 'NO. OF EMPLOYEES'
FROM EMPLOYEEINFO
GROUP BY DEPARTMENT
HAVING COUNT(EMPID) < 2;

-- Q29. Write a query to retrieve EmpPostion along with total salaries paid for each of them.

SELECT EMP_POSITION,SUM(SALARY)
FROM EMPLOYEE_POSITION
GROUP BY EMP_POSITION;

-- Q30. Write a query to fetch 50% records from the EmployeeInfo table.

SELECT *
FROM EMPLOYEEINFO
WHERE EMPID <= (
	SELECT COUNT(EMPID)/2
    FROM EMPLOYEEINFO
);

-- Q.	WAQ TO DISPLAY THE TOTAL SALARYOF EACH EMPLOYEE AFTER ADDING 10% INCREMENT IN SALARY

SELECT EMPID,SALARY+(SALARY/5) AS TOTALSALARY
FROM EMPLOYEE_POSITION;