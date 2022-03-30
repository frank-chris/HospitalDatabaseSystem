import MySQLdb.cursors



def convert(raw_out, type):
    res = []

    if type == "col_names":
        for col_name in raw_out:
            res.append(col_name[0])

    if type == "show":
        for t in raw_out:
            res.append(t[0])

    if type == "desc":
        for t in raw_out:
            row = dict()
            row['Field'] = t[0]
            row['Type'] = t[1]
            row['Null'] = t[2]
            row['Key'] = t[3]
            row['Default'] = t[4]
            row['Extra'] = t[5]
            res.append(row)

    if type == "select":
        for t in raw_out:
            row = list(t)
            res.append(row)

    return res

def col_names(mysql, tablename, db_name="hospitalDB"):
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT `COLUMN_NAME`  FROM `INFORMATION_SCHEMA`.`COLUMNS`  WHERE `TABLE_SCHEMA`='%s' and `TABLE_NAME`='%s'", db_name, tablename)
    res = cursor.fetchall()
    res = convert(res, "col_names")
    return res

def list_to_string(list):
    corr_str = " ".join(str(x) for x in list)
    corr_str = "(" + corr_str + ")"
    return corr_str

def show_tables(mysql):
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SHOW TABLES")
    res = cursor.fetchall()
    res = convert(res, "show")
    return res

def desc_table(mysql, tablename):
    '''
    return: list of dictionaries -> (Field (or col_name), Type (dtype), Null (allowed or not), Key, Default, Extra)
    '''
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("DESC %s", (tablename, ))
    res = cursor.fetchall()
    res = convert(res, "desc")
    return res

def select_with_headers(mysql, tablename):
    column_names = col_names(mysql, tablename)
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT * FROM %s", (tablename))
    rows = cursor.fetchall()
    rows = convert(rows, "select")
    res = [column_names] + rows # error prone
    return res

def insert(mysql, tablename, columnlist, val_list):
    res1 = select_with_headers(mysql, tablename) # before the operation
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cols_string = list_to_string(columnlist)
    vals_string = list_to_string(val_list)
    cursor.execute("INSERT INTO %s %s VALUES %s", (tablename, cols_string, vals_string))
    cursor.fetchall()
    res2 = select_with_headers(mysql, tablename) # after the operation
    
    return res1, res2

def delete(mysql, tablename, where_condition):
    res1 = select_with_headers(mysql, tablename) # before the operation
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("DELETE FROM %s WHERE %s", (tablename, where_condition))
    cursor.fetchall()
    res2 = select_with_headers(mysql, tablename) # after the operation
    return res1, res2

def update(mysql, tablename, column, val,  where_condition):
    res1 = select_with_headers(mysql, tablename) # before the operation
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("UPDATE %s SET %s = %s WHERE %s", (tablename, column, val, where_condition))
    cursor.fetchall()
    res2 = select_with_headers(mysql, tablename) # after the operation


print(list_to_string([1, 2, 3]))