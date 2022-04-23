BEGIN;

UPDATE client
  SET credit = credit - 500
  WHERE id = 1;
UPDATE client
  SET credit = credit + 500
  WHERE id = 3;

UPDATE client
  SET credit = credit - 700
  WHERE id = 2;
UPDATE client
  SET credit = credit + 700
  WHERE id = 1;

UPDATE client
  SET credit = credit - 100
  WHERE id = 2;
UPDATE client
  SET credit = credit + 100
  WHERE id = 3;

SELECT * FROM client ORDER BY id;

ROLLBACK;