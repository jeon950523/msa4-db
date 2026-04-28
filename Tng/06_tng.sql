-- 1. 사원의 사원번호, 이름, 직급코드를 출력해 주세요.
SELECT emp.emp_id
,emp.`name`
,tle.title_code
FROM employees emp
	JOIN title_emps tle
		ON emp.emp_id = tle.emp_id
		AND tle.end_at IS NULL
		AND emp.fire_at IS NULL
ORDER BY emp.emp_id
;
-- 2. 사원의 사원번호, 성별, 현재 연봉을 출력해 주세요.
SELECT
emp.emp_id
 ,emp.gender
 ,sal.salary
FROM employees emp
 JOIN salaries sal
 	ON emp.emp_id = sal.emp_id
WHERE emp.fire_at IS NULL
 	AND sal.end_at IS NULL
 	ORDER BY emp.emp_id
;

-- 3. 10010 사원의 이름과 과거부터 현재까지 연봉 이력을 출력해 주세요.
SELECT 
	emp.`name`
	,sal.salary
	,sal.start_at
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
WHERE emp.emp_id = 10010
order BY sal.start_at 
;

-- 4. 사원의 사원번호, 이름, 소속부서명을 출력해 주세요.
SELECT
 emp.emp_id
 ,emp.`name`
 ,dp.dept_name
FROM employees emp
	JOIN department_emps depa
	ON emp.emp_id = depa.emp_id
	AND depa.end_at IS NULL
	AND emp.fire_at IS NULL
	JOIN departments dp
	ON depa.dept_code = dp.dept_code
	AND dp.end_at IS NULL
ORDER BY emp.`name`
;

-- 5. 현재 연봉의 상위 10위까지 사원의 사번, 이름, 연봉을 출력해 주세요.
SELECT
emp.emp_id
,emp.`name`
,sal.salary
FROM employees emp
	JOIN salaries sal
	ON emp.emp_id = sal.emp_id
	AND sal.end_at IS NULL
	AND emp.fire_at IS NULL
ORDER BY sal.salary DESC
LIMIT 10
;
-- 속도개선 서브쿼리 사용 --
SELECT
emp.emp_id
,emp.`name`
,tmp_sal.salary
FROM employees emp
	JOIN (
		SELECT 
		sal.emp_id
		,sal.salary
		FROM salaries sal
		WHERE 
			sal.end_at IS NULL
		ORDER BY sal.salary DESC 
		LIMIT 10
	) tmp_sal
	ON emp.emp_id = tmp_sal.emp_id
		AND emp.fire_at IS NULL
ORDER BY tmp_sal.salary DESC
;


-- 6. 현재 각 부서의 부서장의 부서명, 이름, 입사일을 출력해 주세요.
SELECT
dep.dept_name
,emp.`name`
,emp.hire_at
FROM employees emp
	JOIN department_managers demg
	ON emp.emp_id = demg.emp_id
		AND end_at IS NULL 
		AND emp.fire_at IS NULL
	JOIN departments dep
	ON demg.dept_code = dep.dept_code
	AND dep.end_at IS NULL
;


-- 7. 현재 직급이 "부장"인 사원들의 연봉 평균을 출력해 주세요.
-- 7-1. (보너스)현재 각 부장별 이름, 연봉평균
SELECT 
emp.`name`
,tl.title
,avg(sal.salary) ps_salary		
,(SELECT TRUNCATE(AVG(s2.salary) ,0)
	FROM salaries s2
	JOIN title_emps t2
		ON s2.emp_id = t2.emp_id
		WHERE t2.title_code = 'T005'
		AND t2.end_at IS NULL 
		AND s2.end_at IS NULL
) avg_salary
FROM employees emp	
	JOIN title_emps tle
		ON emp.emp_id = tle.emp_id
			AND tle.end_at IS NULL		 
	JOIN titles tl
		ON tle.title_code = tl.title_code
	JOIN salaries sal
		 ON tle.emp_id = sal.emp_id		 
	WHERE tle.title_code = 'T005'
	GROUP BY emp.emp_id, emp.`name`
;	

SELECT
	tie.emp_id
	,AVG(sal.salary) asv_sal
FROM title_emps tie
	JOIN titles tit
		ON tie.title_code = tit.title_code
			AND tit.title = '부장'
			AND tie.end_at IS NULL
	JOIN salaries sal
		ON	sal.emp_id = tie.emp_id
GROUP BY tie.emp_id
;
-- 8. 부서장직을 역임했던 모든 사원의 이름과 입사일, 사번, 부서번호를 출력해 주세요.
SELECT 
emp.`name`
,emp.hire_at
,emp.emp_id
,damg.dept_code
FROM employees emp
JOIN department_managers damg
	ON emp.emp_id = damg.emp_id

;

SELECT 
emp.`name`
,emp.hire_at
,emp.emp_id
,depm.dept_code
FROM department_managers depm
	JOIN employees emp
		ON depm.emp_id = emp.emp_id
ORDER BY depm.dept_code, depm.start_at
;	
-- 9. 현재 각 직급별 평균연봉 중 60,000,000이상인 직급의 직급명, 평균연봉(정수)를을 평균연봉 내림차순으로 출력해 주세요.
SELECT 
tl.title
,TRUNCATE (AVG(sal.salary),0)
FROM title_emps tlem
	JOIN titles tl
		ON tlem.title_code = tl.title_code
	JOIN salaries sal
		ON tlem.emp_id = sal.emp_id
	WHERE tlem.end_at IS NULL
		AND sal.end_at IS NULL 
GROUP BY tl.title
HAVING AVG(sal.salary) >= 60000000
ORDER BY AVG(sal.salary)
;

SELECT
	tit.title
	,floor(AVG(sal.salary))
FROM title_emps tie
	JOIN salaries sal
		ON tie.emp_id = sal.emp_id
			AND tie.end_at IS NULL 
			AND sal.end_at IS NULL
	JOIN titles tit
		ON tie.title_code = tit.title_code
GROUP BY tie.title_code, tit.title
	HAVING AVG(sal.salary) >= 60000000
ORDER BY AVG(sal.salary) DESC
;			 


-- 10. 성별이 여자인 사원들의 직급별 사원수를 출력해 주세요.
SELECT 
tl.title '직급'
,gender '성별'
,COUNT(emp.emp_id) '사원 수'
FROM employees emp
	JOIN title_emps tiem
	ON emp.emp_id = tiem.emp_id
	JOIN titles tl
	ON tiem.title_code = tl.title_code
WHERE emp.gender = 'F'
AND tiem.end_at IS NULL
GROUP BY tl.title
ORDER BY COUNT(emp.emp_id)
;

SELECT
tie.title_code
,emp.gender
,COUNT(*)
FROM employees emp
	JOIN title_emps tie
		ON emp.emp_id = tie.emp_id
			AND emp.fire_at IS NULL
			AND tie.end_at IS NULL
			-- AND emp.gender = 'F'
GROUP BY tie.title_code, emp.gender
ORDER BY tie.title_code
;


SELECT 
tl.title '직급'
,COUNT(case when emp.gender = 'f' then 1 END) '여성'
,COUNT(case when emp.gender = 'm' then 1 END) '남성'
,COUNT(*) '전체'
FROM employees emp
	JOIN title_emps tiem
		ON emp.emp_id = tiem.emp_id
	JOIN titles tl
		ON tiem.title_code = tl.title_code
	WHERE tiem.end_at IS NULL
	GROUP BY tl.title
;
-- --------- 평균보다 높은 급여를 받은 이력--
SELECT 
	emp.emp_id
	,emp.`name`
	,sal.salary
FROM salaries sal
	JOIN employees emp
		ON sal.emp_id = emp.emp_id
			AND emp.fire_at IS NULL
WHERE 
	sal.salary >= (
		SELECT
			AVG(sala.salary) avg_sal
		FROM salaries sala
		WHERE
			sala.end_at IS NULL
		)
AND sal.end_at IS NULL
ORDER BY sal.salary
;