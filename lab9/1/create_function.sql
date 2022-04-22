CREATE OR REPLACE FUNCTION retrieve_addresses()
RETURNS TABLE (address_id integer, address character varying)
LANGUAGE plpgsql AS 
$$
BEGIN
   RETURN QUERY
   SELECT a.address_id, a.address
   FROM address AS a
   WHERE a.address LIKE '%11%' AND a.city_id >= 400 AND a.city_id <= 600;
END
$$;