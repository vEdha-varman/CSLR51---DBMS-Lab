import mysql.connector as mysql_client

db = mysql_client.connect(
    host="localhost",
    user="root",
    passwd="",
    database="storehouse"
)
# print(db)
# 1 namae properNoun 4 1444.0 .14 2020-02-02 2020-02-03

query = "SELECT * FROM products WHERE `prod_name` = '%s'"
value = (input("Enter name of the product::\n"))
cmd = db.cursor()
cmd.execute(query % value)

records = cmd.fetchall()
for record in records:
    print(record)
print(cmd.rowcount, "rows hit")
# print((query % value == "SELECT * FROM products WHERE `prod_name` = 'namae'"))
