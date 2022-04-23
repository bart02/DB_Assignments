BEGIN;

UPDATE client
  SET credit = credit - 500 - 30
  WHERE id = 1;
UPDATE client
  SET credit = credit + 500
  WHERE id = 3;
UPDATE client
  SET credit = credit + 30
  WHERE id = 4;

INSERT INTO ledger ("from", "to", "fee", "amount") VALUES (1,3,30,500);

UPDATE client
  SET credit = credit - 700 - 30
  WHERE id = 2;
UPDATE client
  SET credit = credit + 700
  WHERE id = 1;
UPDATE client
  SET credit = credit + 30
  WHERE id = 4;
INSERT INTO ledger("from", "to", "fee", "amount") VALUES (2,1,30,700);

UPDATE client
  SET credit = credit - 100 - 30
  WHERE id = 2;
UPDATE client
  SET credit = credit + 100
  WHERE id = 3;
UPDATE client
  SET credit = credit + 30
  WHERE id = 4;
INSERT INTO ledger("from", "to", "fee", "amount") VALUES (2,3,30,100);

SELECT * FROM client ORDER BY id;
SELECT * FROM ledger ORDER BY id;

ROLLBACK;
