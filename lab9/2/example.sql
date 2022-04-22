SELECT * FROM get_customers(500, 10); -- ERROR: Start has to be smaller that end
SELECT * FROM get_customers(-5, 10); -- ERROR: Incorrect start/end
SELECT * FROM get_customers(1, 10); -- OK
