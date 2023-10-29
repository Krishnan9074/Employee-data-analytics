USE csvtodb;
select * from hr;
-- headquater vs remote 
SELECT location, COUNT(*) as count
FROM hr
WHERE age >= 18
GROUP BY location;

-- avg length of employement before termination
SELECT ROUND(AVG(DATEDIFF(termdate, hire_date))/365,0) AS avg_length_of_employment
FROM hr
WHERE termdate <> '0000-00-00' AND termdate <= CURDATE() AND age >= 18;

-- gender ratio in diff departments
SELECT department, gender, COUNT(*) as count
FROM hr
WHERE age >= 18
GROUP BY department, gender
ORDER BY department;

-- job titles count
SELECT jobtitle, COUNT(*) as count
FROM hr
WHERE age >= 18
GROUP BY jobtitle
ORDER BY jobtitle DESC;

-- turnover rate department wise
SELECT department, COUNT(*) as total_count, 
    SUM(CASE WHEN termdate <= CURDATE() AND termdate <> '0000-00-00' THEN 1 ELSE 0 END) as terminated_count, 
    SUM(CASE WHEN termdate = '0000-00-00' THEN 1 ELSE 0 END) as active_count,
    (SUM(CASE WHEN termdate <= CURDATE() THEN 1 ELSE 0 END) / COUNT(*)) as termination_rate
FROM hr
WHERE age >= 18
GROUP BY department
ORDER BY termination_rate DESC;

-- employee locations
SELECT location_state, COUNT(*) as count
FROM hr
WHERE age >= 18
GROUP BY location_state
ORDER BY count DESC;

-- tenure distribution among diff dept
SELECT department, ROUND(AVG(DATEDIFF(CURDATE(), termdate)/365),0) as avg_tenure
FROM hr
WHERE termdate <= CURDATE() AND termdate <> '0000-00-00' AND age >= 18
GROUP BY department


-- sql findings:
/*
1. The workforce comprises a higher number of male employees.
*/

/*
2. The predominant ethnic group is of White descent, whereas Native Hawaiian and American Indian populations exhibit the lowest representation.
*/

/*
3. The youngest member of the workforce is 21 years old, and the eldest is 58.
*/

/*
4. We categorized employees into five age groups (18-24, 25-34, 35-44, 45-54, 55-64). A significant portion falls within the 25-34 range, followed by the 35-44 category, while the smallest contingent lies within the 55-64 group.
*/

/*
5. A substantial portion of employees operates from the company headquarters as opposed to working remotely.
*/

/*
6. On average, terminated employees had a tenure of approximately 8 years.
*/

/*
7. Gender distribution within departments is generally balanced, though there tends to be a higher male presence across the organization.
*/

/*
8. The Marketing department experiences the highest turnover rate, followed by Training. Conversely, Research and Development, Support, and Legal departments exhibit the lowest turnover rates.
*/

/*
9. The majority of employees originate from the state of Ohio.
*/

/*
10. The average tenure within each department is around 8 years, with Legal and Auditing departments displaying the highest averages and Services, Sales, and Marketing having the lowest.
*/
