SELECT COUNT(*) AS count_returned_late FROM rental AS r
JOIN inventory AS i ON r.inventory_id = i.inventory_id
JOIN film AS f ON i.film_id = f.film_id
WHERE EXTRACT(DAY FROM (r.return_date - r.rental_date)) >= f.rental_duration;

SELECT COUNT(*) AS count_returned_on_time FROM rental AS r
JOIN inventory AS i ON r.inventory_id = i.inventory_id
JOIN film AS f ON i.film_id = f.film_id
WHERE EXTRACT(DAY FROM (r.return_date - r.rental_date)) < f.rental_duration;

SELECT COUNT(*) AS count_not_returned FROM rental
WHERE return_date IS NULL;