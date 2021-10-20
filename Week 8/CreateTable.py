import mysql.connector as mysql_client

db = mysql_client.connect(
    host="localhost",
    user="root",
    passwd="",
    database="storehouse"
)
# print(db)

query = "CREATE TABLE IF NOT EXISTS products (" \
        "prod_id INT PRIMARY KEY," \
        "prod_name VARCHAR(255) NOT NULL," \
        "category VARCHAR(50) NOT NULL," \
        "quantity INT DEFAULT 0," \
        "price FLOAT NOT NULL," \
        "discount FLOAT DEFAULT 0," \
        "date_of_manufacture DATE NOT NULL," \
        "date_of_expiry DATE NOT NULL)"
cmd = db.cursor()
cmd.execute(query)
