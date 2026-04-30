-- ---------
-- VIEW 
-- ---------
-- VIED 생성
CREATE VIEW view_avg_salary_by_dept
AS 
-- 부서별 현재 연봉 평균
	SELECT dep.dept_name ,TRUNCATE(AVG(sal.salary),0) avg_sal
	FROM departments dep
		JOIN 
			department_emps depe
			ON dep.dept_code = depe.dept_code
				AND depe.end_at IS NULL
				AND dep.end_at IS NULL
		JOIN salaries sal
			ON depe.emp_id = sal.emp_id
				AND sal.end_at IS NULL 
	GROUP BY dep.dept_name
	ORDER BY AVG(sal.salary)
;

-- 뷰 조회하기
SELECT *
FROM view_avg_salary_by_dept
WHERE avg_sal >= 44000000;

-- 뷰 삭제하기
DROP VIEW view_avg_salary_by_dept;








