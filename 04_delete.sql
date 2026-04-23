-- DELETE 문
-- DML중 하나로 저장된 기존 데이터를 삭제하기 위해 사용하는 쿼리

-- DELETE FROM 테이블명
-- WHERE 조건;

START TRANSACTION;

SET FOREIGN_KEY_CHECKS = 0;

DELETE
FROM employees;
WHERE 
	emp_id < 100000;

SELECT COUNT(*) FROM employees;

ROLLBACK;

SET FOREIGN_KEY_CHECKS = 1;

COMMIT;