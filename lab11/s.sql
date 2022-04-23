start transaction isolation level read uncommitted;
UPDATE isolation SET username = 'ajones' WHERE username = 'jones';
UPDATE isolation SET balance = balance + 10 WHERE username = 'ajones';