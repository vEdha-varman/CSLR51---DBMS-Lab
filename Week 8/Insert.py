import mysql.connector as mysql_client

db = mysql_client.connect(
    host="localhost",
    user="root",
    passwd="",
    database="storehouse"
)
# print(db)
# 2 namae properNoun 4 1444.0 .14 2020-02-04 2020-02-05
# 4 chalk writingTool 50 30.00 .16 2020-06-06 2040-06-06

query = "INSERT INTO products VALUES (%s, %s, %s, %s, %s, %s, %s, %s);"
value = (input("Enter prod_id, name, category, quantity, price, discount, dom, doe in order with spaces::\n").split())
cmd = db.cursor()
cmd.execute(query, value)

db.commit()
print(cmd.rowcount, "rows inserted")
# print(query % value)
