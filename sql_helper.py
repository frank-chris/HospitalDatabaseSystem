import MySQLdb.cursors

def convert(raw_out, type):
    '''
    Converts the format returned by cursor.fetchall() to something more palatable for the user

    input
    raw_out: unprocessed output of cursor.fetchall()
    type: type of sql command used

    Return
    res: Format specified for the web app
    '''

    res = []

    if type == "col_names":
        res.append(['Columns in the table'])
        for col_name in raw_out:
            res.append([col_name['COLUMN_NAME']])

    if type == "show":
        res.append(['Tables in the database'])
        for t in raw_out:
            res.append(list(t.values()))

    if type == "desc":
        res.append(list(raw_out[0].keys()))
        for t in raw_out:
            res.append(list(t.values()))

    if type == "select":
        res.append(list(raw_out[0].keys()))
        for t in raw_out:
            res.append(list(t.values()))

    return res

def col_names(mysql, tablename, db_name="hospitalDB"):
    '''
    Obtains the names of all columns of the table as a list

    mysql: mysql connection object
    tablename: name of the table whose columns we have to find
    db_name: name of the database to be used ("hospitalDB")

    Return
    res: Returns a list containing the names of all columns
    '''
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA=%s and TABLE_NAME=%s", (db_name, tablename,))
    res = cursor.fetchall()
    res = convert(res, "col_names")
    return res

def list_to_string(list):
    '''
    Converts list to string, surrounded by round brackets. Helper for insert.
    list: Input list that is to be converted to a string.

    Return
    corr_str: String corresponding to list, with round brackets added
    '''
    corr_str = ",".join(str(x) for x in list)
    corr_str = "(" + corr_str + ")"
    return corr_str

def use_database(mysql, db_name='hospitalDB'):
    '''
    Selects database

    mysql: mysql connection object
    db_name: name of the database to be used ("hospitalDB")
    '''
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("USE %s", db_name)
    cursor.fetchall()

def show_tables(mysql):
    '''
    Shows all tables of the given database
    mysql: mysql connection object

    Return
    res: List of tables in the database
    '''
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SHOW TABLES")
    res = cursor.fetchall()
    res = convert(res, "show")
    return res

def desc_table(mysql, tablename):
    '''
    List of dictionaries describing the table
    
    Format: (Field (or col_name), Type (dtype), Null (allowed or not), Key, Default, Extra)

    mysql: mysql connection object
    tablename: name of the table whose columns we have to find

    Return
    res: Overview of the table. Dictionaries of the format specified above.
    '''
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("DESC " + tablename)
    res = cursor.fetchall()
    res = convert(res, "desc")
    return res

def select_with_headers(mysql, tablename):
    '''
    Display all the contents of the table
    mysql: mysql connection object
    tablename: name of the table whose columns we have to find
    
    Return
    res: List of lists, first is list of column names, followed by list of rows in the table
    '''
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT * FROM " + tablename)
    rows = cursor.fetchall()
    rows = convert(rows, "select")
    res = rows # error prone
    return res

def insert_to_table(mysql, tablename, columnlist, val_list):
    '''
    Inserts a row into the specified table
    mysql: mysql connection object
    tablename: name of the table whose columns we have to findcolumnlist: List of columns of the table
    columnlist: List of columns in which to insert all values
    val_list: List of corresponding values to be inserted

    Return
    res1: Contents of the table before the insert statement, as a list of lists
    res2: Contents of the table after the insert statement, as a list of lists
    '''
    res1 = select_with_headers(mysql, tablename) # before the operation
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cols_string = list_to_string(columnlist)
    vals_string = list_to_string(val_list)
    cursor.execute("INSERT INTO " + tablename + " " + cols_string + " VALUES " + vals_string)
    mysql.connection.commit()
    cursor.fetchall()
    res2 = select_with_headers(mysql, tablename) # after the operation
    
    return res1, res2

def delete_from_table(mysql, tablename, where_condition):
    '''
    Deletes all rows (satisfying the where condition)
    mysql: mysql connection object
    tablename: name of the table whose columns we have to findcolumnlist: List of columns of the table
    where_condition: entire where condition in the mysql format, including ANDs and ORs, as a string
    
    Return
    res1: Contents of the table before the delete statement, as a list of lists
    res2: Contents of the table after the delete statement, as a list of lists
    '''
    res1 = select_with_headers(mysql, tablename) # before the operation
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("DELETE FROM " + tablename + " WHERE " + where_condition)
    mysql.connection.commit()
    cursor.fetchall()
    res2 = select_with_headers(mysql, tablename) # after the operation
    return res1, res2

def update_table(mysql, tablename, set_statement,  where_condition):
    '''
    Updates all rows according to the set statement (satisfying the where condition)
    mysql: mysql connection object
    tablename: name of the table whose columns we have to findcolumnlist: List of columns of the table
    set_statement: string containing the assignment statement for the update statement
    where_condition: entire where condition, including ANDs and ORs, as a string
    
    Return
    res1: Contents of the table before the update statement, as a list of lists
    res2: Contents of the table after the update statement, as a list of lists
    '''
    res1 = select_with_headers(mysql, tablename) # before the operation
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("UPDATE " + tablename +" SET " + set_statement + " WHERE " + where_condition)
    mysql.connection.commit()
    cursor.fetchall()
    res2 = select_with_headers(mysql, tablename) # after the operation
    return res1, res2