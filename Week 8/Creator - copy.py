import mysql.connector as mysql_client

db = mysql_client.connect(
    host="localhost",
    user="pma",
    passwd=""
)
# print(db)

