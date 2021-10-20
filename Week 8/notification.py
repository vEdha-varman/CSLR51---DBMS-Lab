import mysql.connector as mysql_client

db = mysql_client.connect(
    host="localhost",
    user="root",
    passwd="",
    database="storehouse"
)
# print(db)
# 1 namae properNoun 4 1444.0 .14 2020-02-02 2020-02-03

query = "SELECT price, discount FROM products"
# value = (input("Enter category of the product(s)::\n"))
cmd = db.cursor()
cmd.execute(query)

records = cmd.fetchall()
for record in records:
    print("Free shipping" if record[0]*(1-record[1]) > 1000.00 else "Shipping charges not included")
    # print(record[0] * (1 - record[1]))
print(cmd.rowcount, "rows hit")
# print((query % value == "SELECT * FROM products WHERE `prod_name` = 'namae'"))

cmd.close()
db.close()
