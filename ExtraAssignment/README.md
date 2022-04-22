# Extra assignment
## Project init
1. Install `docker` and `docker-compose`;
1. Run `docker-compose up -d` in Terminal to start the PostgreSQL;
1. Use http://localhost:8080/ Adminer webpanel to create the DB;
1. Download [dvdrental](https://www.postgresqltutorial.com/wp-content/uploads/2019/05/dvdrental.zip) DB and unzip it;
1. `docker cp dvdrental.tar db_db_1:/`
1. `docker exec -it db_db_1 bash`
1. `pg_restore -U postgres -d <db_name> dvdrental.tar`

## Q1: Find customers that have rented movies priced $14?
Use query in Adminer webpanel:
```sql
SELECT DISTINCT c.* FROM payment p
JOIN customer c ON p.customer_id = c.customer_id
WHERE p.amount = 14;
```

Result:
```
No rows.
```

## Q2: Find customers that have rented movies priced $14 or that they spent more than $2.99 on individual rentals, but have spent a total less than $5?
```sql
SELECT DISTINCT c.* FROM payment p
JOIN customer c ON p.customer_id = c.customer_id
WHERE p.amount = 14

UNION

SELECT DISTINCT c.* FROM payment p
JOIN customer c ON p.customer_id = c.customer_id
INNER JOIN (
    SELECT customer_id, SUM(amount) FROM payment
    GROUP BY customer_id
    HAVING SUM(amount) < 5
) s ON p.customer_id = s.customer_id
INNER JOIN (
    SELECT customer_id, MAX(amount) FROM payment
    GROUP BY customer_id
    HAVING MAX(amount) < 2.99
) m ON p.customer_id = m.customer_id;
```

Result:
```
No rows.
```

## Q3: what is the statement for this query
```sql
SELECT a.customer_id, a.first_name, a.last_name, b.total FROM customer a 
INNER JOIN (
    SELECT customer_id, SUM(amount) as total FROM payment 
    GROUP BY customer_id 
    ORDER BY total desc 
    LIMIT 10
) b ON a.customer_id=b.customer_id;
```
Analysing the query we can conclude that it will find (unordered) top-10 customers (with id, first name, last name and total sum) by total sum spent in DVD rental company.

## Q4: Display How Many Rentals Were Returned Late, On Time, Or Have Not Been Returned?
### Returned late
```sql
SELECT COUNT(*) AS count_returned_late FROM rental AS r
JOIN inventory AS i ON r.inventory_id = i.inventory_id
JOIN film AS f ON i.film_id = f.film_id
WHERE EXTRACT(DAY FROM (r.return_date - r.rental_date)) >= f.rental_duration;
```

Result:
```
count_returned_late
8123
```

### Returned on time
```sql
SELECT COUNT(*) AS count_returned_on_time FROM rental AS r
JOIN inventory AS i ON r.inventory_id = i.inventory_id
JOIN film AS f ON i.film_id = f.film_id
WHERE EXTRACT(DAY FROM (r.return_date - r.rental_date)) < f.rental_duration;
```

Result:
```
count_returned_on_time
7738
```

### Have not been returned
```sql
SELECT COUNT(*) AS count_not_returned FROM rental
WHERE return_date IS NULL;
```

Result:
```
count_not_returned
183
```

If we sum all these query result, we gets 16044. That is equal to result of query 
```sql
SELECT COUNT(*) FROM rental;
```
