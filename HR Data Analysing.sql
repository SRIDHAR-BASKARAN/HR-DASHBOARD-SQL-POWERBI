USE humanresources;

SELECT * FROM hr;

/* Gender breakdown of employees in the company */

SELECT gender, count(*) AS count
FROM hr
WHERE age >=18 AND termdate = '0000-00-00'
GROUP BY gender;

/* The Race/Ethnicity breakdown in the company */

SELECT Race, COUNT(*)AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY Race
ORDER BY count(*) DESC;

/* Age distribution of employees in the company */

SELECT
min(age) AS youngest,
max(age) AS oldest
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00';

SELECT
CASE
  WHEN AGE >= 18 AND age <=24 THEN '18-24'
  WHEN AGE >= 25 AND age <=34 THEN '25-34'
  WHEN AGE >= 35 AND age <=44 THEN '35-44'
  WHEN AGE >= 45 AND age <=54 THEN '45-54'
  WHEN AGE >= 55 AND age <=64 THEN '55-64'
ELSE'65+'
END AS age_group, gender,
count(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY age_group, gender
ORDER BY AGE_group, gender;
 
/* People work at headquaters vs remote locations */
 
SELECT location, count(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY location;
 
/* Average length of employment for employees who have been terminated */
SELECT 
round(avg(datediff(termdate, hire_date))/365,0) AS avg_length_employment
FROM hr
WHERE termdate <= curdate() AND termdate <> '0000-00-00' AND age >= 18;
 
/* Gender distribution vary across departments and job titles */
  
SELECT department, Age, Jobtitle, gender, COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY department, gender, Jobtitle, Age
ORDER BY department, Jobtitle, Gender, Age;
 
/* Which is the Distribution of job titles across the company*/

SELECT jobtitle, count(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY Jobtitle
ORDER BY Jobtitle DESC;
 
/* Which Department has the highest turnover rate */
  
SELECT Department,
  COUNT(*) AS total_count,
  COUNT(CASE
  WHEN termdate IS NOT NULL AND termdate <= curdate() THEN 1
  END) AS Terminated_Count,
  ROUND((COUNT(CASE
  WHEN Termdate IS NOT NULL AND Termdate <= curdate() THEN 1
  END)/COUNT(*))*100,2) AS termination_rate
  FROM hr
  GROUP BY Department 
  ORDER BY Termination_Rate DESC;

 /* Distribution of employees across location by city and state */
 
 SELECT location_state, COUNT(*) AS count
 FROM hr
 WHERE AGE >= 18 AND termdate = '0000-00-00'
 GROUP BY location_state
 ORDER BY count DESC;
 
 /* Company's employee count changed over time based on hire and term dates */
 
 SELECT 
 year,
 hires,
 Terminations,
 hires - terminations AS net_change,
 round((hires - terminations)/hires * 100,2) AS net_change_percent
 FROM(
      SELECT 
      YEAR(Hire_Date) AS year,
      count(*) AS hires,
      SUM(CASE WHEN Termdate <> '0000-00-00' AND Termdate <= curdate() THEN 1 ELSE 0 END) AS terminations
	   FROM hr
       WHERE age >=18
       GROUP BY YEAR(Hire_Date)
       ) AS subquery
ORDER BY year ASC;
           
/* Tenure distribution for each Department */

SELECT Department, round(avg(datediff(Termdate, Hire_Date)/365),0) AS avg_tenure
FROM hr
WHERE Termdate <= curdate() AND Termdate<> '0000-00-00' AND age >= 18
GROUP BY Department




