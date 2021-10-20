import mysql.connector as mysql_client
from datetime import date

db = mysql_client.connect(
    host="localhost",
    user="root",
    passwd="",
    database="storehouse"
)
# print(db)
# 1 namae properNoun 4 1444.0 .14 2020-02-02 2020-02-03

query = "DELETE FROM products WHERE `date_of_expiry` < '%s'"
# value = (input("Enter DoE of the product::\n"))
cmd = db.cursor()
query_ = "SELECT * FROM products"
cmd.execute(query % date.today().strftime("%Y-%m-%d"))  # date.today().strftime("%Y-%m-%d"))

db.commit()

cmd.execute(query_)
records = cmd.fetchall()
for record in records:
    print(record)
print(cmd.rowcount, "rows hit")
# print((query % value == "SELECT * FROM products WHERE `prod_name` = 'namae'"))
