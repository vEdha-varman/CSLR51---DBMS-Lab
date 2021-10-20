import mysql.connector as mysql_client

db = mysql_client.connect(
    host="localhost",
    user="root",
    passwd="",
    database="storehouse"
)
# print(db)
# 1 namae properNoun 4 1444.0 .14 2020-02-02 2020-02-03

query = "UPDATE `products` SET `price` = %s WHERE `prod_id` = %s"
value = (input("Enter the ID, new_price of the product::\n").split())
cmd = db.cursor()
cmd.execute(query % (float(value[1]), int(value[0])))

db.commit()

cmd.execute("SELECT * FROM products")
records = cmd.fetchall()
for record in records:
    print(record)
print(cmd.rowcount, "rows hit")
# print((query % value == "SELECT * FROM products WHERE `prod_name` = 'namae'"))
