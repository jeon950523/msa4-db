-- SELECT 문
-- DML중 하나로, 
-- 저장되어 있는 데이터를 조회하기 위해 사용하는 쿼리

-- 조회한 데이터 중 특정 컬럼만 출력
-- `으로 감싸면, 컬럼으로써 인식시킴
SELECT 
`name`
,gender
,emp_id
,birth
FROM employees;

-- 테이블 전체 컬럼 조회:*(asterisk)
SELECT * 
FROM departments;

-- WHERE 절: 특정 컬럼의 값이 일치한 데이터만 조회
SELECT * 
FROM employees 
WHERE `name` = '조은혜';

SELECT * 
FROM employees 
WHERE emp_id = 5588;

SELECT *
FROM employees
WHERE birth >= '1990-01-01';

SELECT *
FROM employees
WHERE fire_at IS not NULL;