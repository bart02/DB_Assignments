SELECT a.customer_id, a.first_name, a.last_name, b.total FROM customer a 
INNER JOIN (
    SELECT customer_id, SUM(amount) as total FROM payment 
    GROUP BY customer_id 
    ORDER BY total desc 
    LIMIT 10
) b ON a.customer_id=b.customer_id;