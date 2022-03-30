from flask import Flask, render_template, request, redirect, url_for
from flask_mysqldb import MySQL
from sql_helper import *
from table import nested_list_to_html_table

app = Flask(__name__)
app.debug = True

app.secret_key = 'mango'

# Enter your database connection details below
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'tempuser'
app.config['MYSQL_PASSWORD'] = '123+Temppass'
app.config['MYSQL_DB'] = 'hospitaldb'

# Intialize MySQL
mysql = MySQL(app)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/', methods=['POST'])
def choose():
    if request.form.get("start"):
        return redirect(url_for('commands'))
    else:
        return render_template('index.html')

@app.route('/commands')
def commands():
    return render_template('commands.html')

@app.route('/commands', methods=['POST'])
def choose_command():
    if request.form.get("insert"):
        return redirect(url_for('insert'))
    elif request.form.get("update"):
        return redirect(url_for('update'))
    elif request.form.get("delete"):
        return redirect(url_for('delete'))
    else:
        return render_template('commands.html')

@app.route('/insert', methods=['POST', 'GET'])
def insert():
    table_name = ''
    if request.method == 'POST' and 'table' in request.form:
        if 'insert_describe' in request.form:
            table_name = request.form['table']
            table = nested_list_to_html_table(desc_table(mysql, table_name))
            return render_template('insert.html', table=table, table_name=table_name)
        elif 'insert_execute' in request.form and 'columns' in request.form and 'values' in request.form:
            table_name = request.form['table']
            columns = request.form['columns']
            values = request.form['values']
            try:
                tables = insert_to_table(mysql, table_name, columns.split(','), values.split(','))
            except Exception as e:
                return render_template('invalid.html', e=str(e.args[1]))
            tables = [nested_list_to_html_table(t) for t in tables]
            return render_template('insert_results.html', tables=tables, table_name=table_name)

    table = nested_list_to_html_table(show_tables(mysql))
    return render_template('insert.html', table=table, table_name=table_name)

@app.route('/update', methods=['POST', 'GET'])
def update():
    table_name = ''
    if request.method == 'POST' and 'table' in request.form:
        if 'update_describe' in request.form:
            table_name = request.form['table']
            table = nested_list_to_html_table(desc_table(mysql, table_name))
            return render_template('update.html', table=table, table_name=table_name)
        elif 'update_execute' in request.form and 'column' in request.form and 'value' in request.form and 'where' in request.form:
            table_name = request.form['table']
            column = request.form['column']
            value = request.form['value']
            where = request.form['where']
            try:
                tables = update_table(mysql, table_name, column, value, where)
            except Exception as e:
                return render_template('invalid.html', e=str(e.args[1]))
            tables = [nested_list_to_html_table(t) for t in tables]
            return render_template('update_results.html', tables=tables, table_name=table_name)

    table = nested_list_to_html_table(show_tables(mysql))
    return render_template('update.html', table=table, table_name=table_name)

@app.route('/delete', methods=['POST', 'GET'])
def delete():
    table_name = ''
    if request.method == 'POST' and 'table' in request.form:
        if 'delete_describe' in request.form:
            table_name = request.form['table']
            table = nested_list_to_html_table(desc_table(mysql, table_name))
            return render_template('delete.html', table=table, table_name=table_name)
        elif 'delete_execute' in request.form and 'where' in request.form:
            table_name = request.form['table']
            where = request.form['where']
            try:
                tables = delete_from_table(mysql, table_name, where)
            except Exception as e:
                return render_template('invalid.html', e=str(e.args[1]))
            tables = [nested_list_to_html_table(t) for t in tables]
            return render_template('delete_results.html', tables=tables, table_name=table_name)


    table = nested_list_to_html_table(show_tables(mysql))
    return render_template('delete.html', table=table, table_name=table_name)

if __name__ == '__main__':
    app.run()