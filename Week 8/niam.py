import mysql.connector
from mysql.connector import Error
import pandas as pd

pw = ""     # IMPORTANT! Put your MySQL Terminal password here.
db = "storehouse"               # This is the name of the database we will create


def main():
    init()
    while True:
        print("""
        1. insert value
        2. search by name
        3. search in category
        4. update price
        5. discounts by category
        6. delete product invalid expiry
        7. notify free shipping
        8. print table
        9. quit
        """)
        op = input("enter operation: ")

        if op == "1":
            insert_value()
        elif op == "2":
            search_by_name()
        elif op == "3":
            search_by_category()
        elif op == "4":
            update_price()
        elif op == "5":
            view_category_discounts()
        elif op == "6":
            del_invalid_doe()
        elif op == "7":
            free_shipping_check()
        elif op == "8":
            print_prod_table()
        elif op == "9":
            break
        else:
            print('invalid operation')



def create_server_connection(host_name, user_name, user_password):
    connection = None
    try:
        connection = mysql.connector.connect(
            host=host_name,
            user=user_name,
            passwd=user_password
        )
        print("MySQL Database connection successful")
    except Error as err:
        print(f"Error: '{err}'")

    return connection


def create_database(connection, query):
    cursor = connection.cursor()
    try:
        cursor.execute(query)
        print("Database created successfully")
    except Error as err:
        print(f"Error: '{err}'")


def init():
    connection = create_server_connection("localhost", "root", pw)
    create_database_query = "CREATE DATABASE w8"
    create_database(connection, create_database_query)

    create_product_table = """
    CREATE TABLE products (
      product_id INT PRIMARY KEY,
      product_name VARCHAR(40) NOT NULL,
      category VARCHAR(40),
      quantity INT,
      price INT,
      discount FLOAT,
      dom DATE,
      doe DATE
      );
     """

    connection = create_db_connection("localhost", "root", pw, db)  # Connect to the Database
    execute_query(connection, create_product_table)  # Execute our defined query


def create_db_connection(host_name, user_name, user_password, db_name):
    connection = None
    try:
        connection = mysql.connector.connect(
            host=host_name,
            user=user_name,
            passwd=user_password,
            database=db_name
        )
        print("MySQL Database connection successful")
    except Error as err:
        print(f"Error: '{err}'")

    return connection


def execute_query(connection, query):
    cursor = connection.cursor()
    try:
        cursor.execute(query)
        connection.commit()
        print("Query successful")
    except Error as err:
        print(f"Error: '{err}'")


def read_query(connection, query):
    cursor = connection.cursor()
    result = None
    try:
        cursor.execute(query)
        result = cursor.fetchall()
        return result
    except Error as err:
        print(f"Error: '{err}'")


def print_results_df(results, columns):
    from_db = []

    for result in results:
        result = list(result)
        from_db.append(result)

    df = pd.DataFrame(from_db, columns=columns)
    print(df)


def print_prod_table():
    print_table = f"""
    SELECT *
    FROM products;
    # """

    connection = create_db_connection("localhost", "root", pw, db)
    results = read_query(connection, print_table)

    columns = ["product_id", "product_name", "category", "quantity", "price", "discount", "dom", "doe"]

    print("product TABLE")
    print_results_df(results, columns)


def insert_value():
    pid = input('Enter product id: ')
    pname = input('Enter product name: ')
    category = input('Enter category: ')
    qty = input('Enter quantity: ')
    price = input('Enter price: ')
    discount = input('Enter discount: ')
    dom = input('Enter manufacture date: ')
    doe = input('Enter expiry date: ')

    if pname != 'NULL':
        pname = f"'{pname}'"

    if category != 'NULL':
        category = f"'{category}'"

    if dom != 'NULL':
        dom = f"'{dom}'"

    if doe != 'NULL':
        doe = f"'{doe}'"

    add_product = f"""
    INSERT INTO product VALUES
    ({pid}, {pname}, {category}, {qty}, {price}, {discount}, {dom}, {doe})
    """

    connection = create_db_connection("localhost", "root", pw, db)
    execute_query(connection, add_product)


def search_by_name():
    pname = input('Enter name of product to search: ')

    if pname != 'NULL':
        pname = f"'{pname}'"

    find = f"""
    SELECT *
    FROM product
    WHERE product_name = {pname};
    # """

    connection = create_db_connection("localhost", "root", pw, db)
    results = read_query(connection, find)

    columns = ["product_id", "product_name", "category", "quantity", "price", "discount", "dom", "doe"]

    print_results_df(results, columns)


def search_by_category():
    category = input('Enter category of products to search: ')

    if category != 'NULL':
        category = f"'{category}'"

    search_in_category = f"""
    SELECT *
    FROM product
    WHERE category = {category};
    # """

    connection = create_db_connection("localhost", "root", pw, db)
    results = read_query(connection, search_in_category)

    columns = ["product_id", "product_name", "category", "quantity", "price", "discount", "dom", "doe"]

    print_results_df(results, columns)


def update_price():
    pid = input('enter product id: ')
    price = input('enter new price: ')

    update = f"""
    UPDATE product
    SET price = {price}
    WHERE product_id = {pid};
    """

    connection = create_db_connection("localhost", "root", pw, db)
    execute_query(connection, update)


def view_category_discounts():
    category = input('Enter name of category to view discounts: ')

    if category != 'NULL':
        category = f"'{category}'"

    if category == 'NULL':
        provide_discount = f"""
        SELECT category, discount
        FROM product
        WHERE category IS NULL;
        # """

    else:
        provide_discount = f"""
        SELECT category, discount
        FROM product
        WHERE category = {category};
        # """

    connection = create_db_connection("localhost", "root", pw, db)
    results = read_query(connection, provide_discount)

    columns = ["category", "discount"]

    print_results_df(results, columns)


def del_invalid_doe():
    delete = """
    DELETE FROM product WHERE doe IS NULL;
    """

    connection = create_db_connection("localhost", "root", pw, db)
    execute_query(connection, delete)


def free_shipping_check():
    total_product_price = """
    SELECT SUM(price * (0.01*discount) * quantity) AS total_price
    FROM product
    """

    connection = create_db_connection("localhost", "root", pw, db)
    results = read_query(connection, total_product_price)

    columns = ["total_price"]
    print_results_df(results, columns)

    if results[0][0] > 1000:
        print('Free Shipping')

    else:
        print('No Free Shipping')


def drop_db():
    dropDB = """
    DROP DATABASE w8;
    """

    connection = create_db_connection("localhost", "root", pw, db)
    execute_query(connection, dropDB)


if __name__ == "__main__":
    main()
