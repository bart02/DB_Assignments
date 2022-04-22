1. Create Function to retrieve addresses that contains “11” and city_id between 400-600
    ```sql
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
    ```
1. Alter table and add new columns
    ```sql
    ALTER TABLE address
    ADD "longitude" double precision NULL,
    ADD "latitude" double precision NULL;
    ```
1. Call the function from Python script and use geoPy to generate longitude and latitude and Create Query to update Address table with new values. Any area that geoPy not recognize put 0,0 for both values.  
See [update_coords.py](update_coords.py)
1. Script output
    ```
    b'UPDATE address SET longitude = 0, latitude = 0 WHERE address_id = 6;'
    b'UPDATE address SET longitude = 0, latitude = 0 WHERE address_id = 127;'
    b'UPDATE address SET longitude = 0, latitude = 0 WHERE address_id = 245;'
    b'UPDATE address SET longitude = 119.652066, latitude = 45.5294187 WHERE address_id = 297;'
    b'UPDATE address SET longitude = 24.94371497711272, latitude = 54.65967825 WHERE address_id = 324;'
    b'UPDATE address SET longitude = 0, latitude = 0 WHERE address_id = 366;'
    b'UPDATE address SET longitude = 0, latitude = 0 WHERE address_id = 378;'
    b'UPDATE address SET longitude = 119.2624129, latitude = 35.092307 WHERE address_id = 379;'
    b'UPDATE address SET longitude = 0, latitude = 0 WHERE address_id = 507;'
    b'UPDATE address SET longitude = 50.1116357, latitude = 26.2844342 WHERE address_id = 511;'
    b'UPDATE address SET longitude = 0.6900118, latitude = 51.5364227 WHERE address_id = 528;'
    b'UPDATE address SET longitude = 26.097821545712875, latitude = 44.4345383 WHERE address_id = 602;'
    b'UPDATE address SET longitude = 0, latitude = 0 WHERE address_id = 603;'
    b'UPDATE address SET longitude =  -82.400844, latitude = 36.125749 WHERE address_id = 4;'
    ```