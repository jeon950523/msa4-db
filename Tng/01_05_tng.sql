SELECT *
FROM title_emps;

SELECT 
emp_id
FROM salaries
WHERE salary <= 60000000 AND end_at IS NULL;

SELECT 
emp_id
FROM salaries
WHERE salary BETWEEN 60000000 AND 70000000 
AND end_at IS null
;

SELECT
*
FROM employees
WHERE emp_id IN (10001,10005);

SELECT
title_code
,title
FROM titles
WHERE title LIKE '%사%'
;

SELECT 
`name`
FROM employees
ORDER BY `name`
;

SELECT 
emp_id,
TRUNCATE (AVG(salary),0)
FROM salaries
GROUP BY emp_id
ORDER BY AVG(salary)
;

SELECT
emp_id
,TRUNCATE(AVG(salary),0)
FROM salaries
GROUP BY emp_id
HAVING AVG(salary) BETWEEN 30000000 AND 50000000
ORDER BY AVG(salary)
;


SELECT
employees.emp_id
,employees.`name`
,employees.gender
FROM employees
WHERE employees.emp_id IN(
	SELECT salaries.emp_id
	FROM salaries
	GROUP BY emp_id
	HAVING AVG(salary) >= 70000000
);

SELECT 
employees.emp_id
,employees.`name`
FROM employees
WHERE employees.emp_id IN (
	SELECT title_emps.emp_id
	FROM title_emps
	WHERE title_emps.title_code = 'T005' 
	AND title_emps.end_at IS NULL)
;

