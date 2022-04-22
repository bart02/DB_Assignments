SELECT DISTINCT c.* FROM payment p
JOIN customer AS c ON p.customer_id = c.customer_id
WHERE p.amount = 14

UNION

SELECT DISTINCT c.* FROM payment p
JOIN customer AS c ON p.customer_id = c.customer_id
INNER JOIN (
    SELECT customer_id, SUM(amount) FROM payment
    GROUP BY customer_id
    HAVING SUM(amount) < 5
) AS s ON p.customer_id = s.customer_id
INNER JOIN (
    SELECT customer_id, MAX(amount) FROM payment
    GROUP BY customer_id
    HAVING MAX(amount) < 2.99
) AS m ON p.customer_id = m.customer_id;
