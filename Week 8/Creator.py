import mysql.connector as mysql_client

db = mysql_client.connect(
    host="localhost",
    user="root",
    passwd=""
)
# print(db)

query = "CREATE DATABASE IF NOT EXISTS storehouse"
cmd = db.cursor()
cmd.execute(query)
