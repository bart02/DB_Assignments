import psycopg2
from geopy.geocoders import Nominatim

geolocator = Nominatim(user_agent="db", timeout=100)

con = psycopg2.connect(database="assignment0", user="postgres",
                       password="example", host="127.0.0.1", port="5432")
cur = con.cursor()
cur.callproc('retrieve_addresses')

for e in cur.fetchall():
    location = geolocator.geocode(e[1])
    lat = location.latitude if location is not None else 0
    lon = location.longitude if location is not None else 0
    cur.execute('''UPDATE address SET longitude = %s, latitude = %s WHERE address_id = %s;''', (lon, lat, e[0]))
    print(e, (lat, lon))

con.commit()
cur.close()
con.close()
