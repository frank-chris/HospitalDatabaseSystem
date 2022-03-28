import MySQLdb.cursors

def list_to_string(list):
    corr_str = " ".join(str(x) for x in list)
    corr_str = "(" + corr_str + ")"
    return corr_str

def show_tables(mysql):
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SHOW TABLES")
    res = cursor.fetchall()
    return res

def desc_table(mysql, tablename):
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("DESC %s", (tablename, ))
    res = cursor.fetchall()
    return res

def insert(mysql, tablename, columnlist, val_list):
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cols_string = list_to_string(columnlist)
    vals_string = list_to_string(val_list)
    cursor.execute("INSERT INTO %s %s VALUES %s", (tablename, cols_string, vals_string))
    res = cursor.fetchall()
    return res

print(list_to_string([1, 2, 3]))