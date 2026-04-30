-- ----------
-- INDEX 
-- ----------

-- INDEX 확인
SHOW INDEX FROM salaries;
SHOW INDEX FROM employees;
-- 
SELECT * FROM employees WHERE `name` = '조은혜';

-- IDNEX 생성 - 스키마
ALTER TABLE employees 
ADD INDEX idx_employees_name (`name`);

-- INDEX 삭제
ALTER TABLE employees
DROP INDEX idx_employees_name;







