use hr;
/* Data Cleaning: Change Column name*/
SELECT * FROM hr;

ALTER TABLE hr
CHANGE COLUMN ï»¿id Emp_id VARCHAR(20),
CHANGE COLUMN First_name first_name VARCHAR(20),
CHANGE COLUMN Last_name last_name VARCHAR(50),
CHANGE COLUMN birthdate Birthdate VARCHAR(20),
CHANGE COLUMN gender Gender VARCHAR(20),
CHANGE COLUMN department Department VARCHAR(80),
CHANGE COLUMN jobtitle Jobtitle VARCHAR(80),
CHANGE COLUMN location Location VARCHAR(20),
CHANGE COLUMN termdate Termdate VARCHAR(80),
CHANGE COLUMN location_city Location_City VARCHAR(80),
CHANGE COLUMN race Race VARCHAR(80),
CHANGE COLUMN hire_date Hire_Date VARCHAR(30),
CHANGE COLUMN location_State Location_State VARCHAR(20);

/* Change Birthdate formate */
SET sql_safe_updates = 0;
UPDATE hr
SET Birthdate = CASE
WHEN Birthdate Like'%%' THEN date_format(str_to_date(Birthdate, '%m/%d/%Y'), '%Y-%m-%d')
WHEN Birthdate Like '%-%' THEN date_format(str_to_date(Birthdate, '%m-%d-%Y'), '%Y-%m-%d')
ELSE NULL
END;

SELECT Birthdate FROM hr;
ALTER TABLE hr
MODIFY COLUMN Birthdate DATE;

/* Change Hire_Date Formate */
UPDATE hr
SET Hire_Date = CASE
WHEN Hire_date like '%/%' THEN date_format(str_to_date(Hire_date, '%m/%d/%Y'), '%Y-%m-%d')
WHEN Hire_date like '%-%' THEN date_format(str_to_date(Hire_date, '%m-%d-%Y'), '%Y-%m-%d')
ELSE NULL
END;

UPDATE hr
SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')) 
WHERE termdate IS NOT NULL AND termdate !=' ';

ALTER TABLE hr
MODIFY COLUMN termdate date;

SELECT termdate FROM hr;

UPDATE hr
SET termdate = '0000-00-00'
WHERE termdate = ' ';

describe hr;

ALTER TABLE hr ADD COLUMN age INT;
UPDATE hr
SET AGE = timestampdiff(YEAR, birthdate, CURDATE());

