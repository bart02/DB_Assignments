SELECT DISTINCT c.* FROM payment p
JOIN customer AS c ON p.customer_id = c.customer_id
WHERE p.amount = 14;
