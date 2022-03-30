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
app.config['MYSQL_DB'] = 'graduation'

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
    if request.method == 'POST' and 'table' in request.form:
        if 'insert_describe' in request.form:
            table_name = request.form['table']
            table = nested_list_to_html_table(desc_table(mysql, table_name))
            return render_template('insert.html', table=table)
        elif 'insert_execute' in request.form and 'columns' in request.form and 'values' in request.form:
            table_name = request.form['table']
            columns = request.form['columns']
            values = request.form['values']
            tables = insert_to_table(mysql, table_name, columns.split(','), values.split(','))
            tables = [nested_list_to_html_table(t) for t in tables]
            return render_template('insert_results.html', tables=tables)

    table = nested_list_to_html_table(show_tables(mysql))
    return render_template('insert.html', table=table)

@app.route('/update')
def update():
    return render_template('update.html')

@app.route('/delete')
def delete():
    return render_template('delete.html')

if __name__ == '__main__':
    app.run()