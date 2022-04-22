CREATE OR REPLACE FUNCTION get_customers(start integer, endd integer)
RETURNS TABLE (customer_id integer, 
               store_id	smallint,
               first_name character varying,
               last_name character varying,
               email character varying,
               address_id smallint,
               activebool boolean,
               create_date date,
               last_update timestamp,
               active integer)
LANGUAGE plpgsql AS 
$$
BEGIN
   ASSERT (start > 0 AND start < 600 AND endd > 0 AND endd < 600), 'Incorrect start/end';
   ASSERT start < endd, 'Start has to be smaller that end';
   RETURN QUERY
   SELECT a.customer_id, a.store_id, a.first_name, a.last_name, a.email, a.address_id, a.activebool, a.create_date, a.last_update, a.active FROM (
      SELECT c.*, ROW_NUMBER() OVER (ORDER BY c.address_id) AS row FROM customer c
   ) a
   WHERE row >= start AND row <= endd;
END
$$;