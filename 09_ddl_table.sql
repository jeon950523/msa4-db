CREATE DATABASE mydb;
USE mydb;

-- --------
-- TABLE 생성 pk, 작성일, 수정일, 삭제일은 반드시포함
-- id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT
-- name VARCHAR(50) NOT NULL
-- gender CHAR(1)(db에서는 char의 속도가 가장빠름) NOT NULL 
-- 이름, 성별, 작성일, 수정일, 삭제일
-- --------

CREATE TABLE users(
	id				BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT
	,`name` 		VARCHAR(50) NOT NULL
	,gender  	CHAR(1) NOT NULL COMMENT "M:남자, F:여자"
	,created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP() -- now는 쿼리가 실행됬을때 시간이라 X
	,updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
	,deleted_at DATETIME
	,TEXted LONGTEXT 
)
;

-- 게시글 테이블
-- pk, 유저번호, 제목, 내용, 작성일, 수정일, 삭제일, fk로 사용할때 테이블의 단수명으로 
CREATE TABLE posts(
	id 			BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT
	,user_id 	BIGINT UNSIGNED NOT NULL
	,title 		VARCHAR(50) NOT NULL
	,content 	VARCHAR(1000) NOT NULL
	,created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
	,updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
	,deleted_at DATETIME
);

-- -----------
-- 테이블 수정
-- -----------
-- 컬럼추가
-- ALTER TABLE [테이블명] ADD COLUMN [컬럼명] [타입] [제약조건]
ALTER TABLE users ADD COLUMN age INT UNSIGNED NOT NULL;

-- 컬럼 데이터 타입 수정
-- ALTER TABLE [테이블명] MODIFY COLUMN [컬럼명] [타입] [제약조건]
ALTER TABLE users MODIFY COLUMN age BIGINT NOT NULL;

-- 컬럼 삭제
-- -- ALTER TABLE [테이블명] DROP COLUMN [컬럼명] [타입] [제약조건]
ALTER TABLE users DROP COLUMN age;

-- 제약조건(constraint) 추가/삭제
ALTER TABLE posts 
ADD CONSTRAINT fk_posts_user_id
FOREIGN KEY (user_id) REFERENCES users(id);

ALTER TABLE posts DROP CONSTRAINT fk_posts_user_id;

-- -------------
-- AUTO_INCREAMENT 값 변경
-- -------------
ALTER TABLE users AUTO_INCREMENT = 1;

INSERT INTO users (`name`, gender) VALUES('hong','F');

-- --------------
-- TABLE의 모든 데이터를 깨끗하게 제거하는 문
-- --------------
TRUNCATE TABLE users;

-- --------------
-- TABLE 삭제
-- --------------
DROP TABLE posts;
DROP TABLE users;
DROP TABLE users, posts; -- 하위 테이블먼저



