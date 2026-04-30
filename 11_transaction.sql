-- ------------
-- TRANSACTION - 항상 트랜잭션 시작을 적어줘야함 mysql은 오토커밋
-- ------------
START TRANSACTION;

INSERT INTO employees (
 `name`
,birth
,gender
,hire_at
)
VALUES(
'홍길동'
,'2000-01-01'
,'M'
,NOW()
)
;

ROLLBACK;
COMMIT;




