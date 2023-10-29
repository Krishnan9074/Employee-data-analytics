USE csvtodb;
select * from hr;
alter table hr change column ï»¿id emp_id varchar(20) null;
DESCRIBE hr; 
SELECT birthdate FROM hr;

SET sql_safe_updates = 0;

UPDATE hr SET birthdate = CASE 
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'),'%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'),'%Y-%m-%d')
    ELSE NULL
END;

ALTER 	TABLE hr  MODIFY COLUMN birthdate DATE;

UPDATE hr SET hire_date = CASE 
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'),'%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'),'%Y-%m-%d')
    ELSE NULL
END;

SELECT hire_date FROM hr;
ALTER 	TABLE hr  MODIFY COLUMN hire_date DATE;

SELECT termdate FROM hr;
UPDATE hr
SET termdate = IF(termdate IS NOT NULL AND termdate != '', date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')), '0000-00-00')
WHERE true;

SELECT termdate from hr;

SET sql_mode = 'ALLOW_INVALID_DATES';

ALTER TABLE hr
MODIFY COLUMN termdate DATE;
ALTER TABLE hr ADD COLUMN age INT;

UPDATE hr SET age = timestampdiff(YEAR,birthdate,CURDATE());

SELECT birthdate,age from hr;

SELECT MIN(age) AS youngest,max(age) AS oldest FROM hr;

SELECT COUNT(*) FROM hr WHERE age<18;

-- Gender Ratio:
SELECT gender,count(*) AS count FROM hr WHERE age>=18 AND termdate = '0000-00-00' GROUP BY gender;

-- race Ratio:
SELECT race,count(*) AS count FROM hr WHERE age>=18 AND termdate = '0000-00-00' GROUP BY race ORDER BY count(*) DESC;

-- age dist:
SELECT min(age) AS youngest,max(age) AS oldest FROM hr WHERE age>=18 AND termdate = '0000-00-00'; 

SELECT 
	CASE 
		WHEN age>=18 AND age<=24 THEN '18-24'
		WHEN age>=25 AND age<=34 THEN '25-34'
		WHEN age>=35 AND age<=44 THEN '35-44'
		WHEN age>=45 AND age<=54 THEN '45-54'
		WHEN age>=55 AND age<=64 THEN '55-64'
		ELSE '65+'
	END AS age_group,gender,
	count(*) AS count
FROM hr WHERE age>=18 AND termdate = '0000-00-00' GROUP BY age_group,gender ORDER BY age_group,gender;

