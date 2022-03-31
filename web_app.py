from flask import Flask, render_template, request, redirect, url_for, session
from flask_mysqldb import MySQL
from sql_helper import *
from html_helper import *

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
        return redirect(url_for('pick_table'))
    else:
        return render_template('index.html')

@app.route('/pick_table', methods=['POST', 'GET'])
def pick_table():
    table_name = ''
    if session.get('table_name'):
        session.pop('table_name', None)
    options = nested_list_to_html_select(show_tables(mysql))
    if request.method == 'POST' and 'table' in request.form:
        if 'describe' in request.form:
            table_name = request.form['table']
            table = nested_list_to_html_table(desc_table(mysql, table_name))
            return render_template('pick_table.html', table=table, table_name=table_name, options=options)
        elif 'pick' in request.form:
            session['table_name'] = request.form['table']
            return redirect(url_for('edit'))

    table = nested_list_to_html_table(show_tables(mysql))
    return render_template('pick_table.html', table=table, table_name=table_name, options=options)


@app.route('/edit', methods=['POST', 'GET'])
def edit():
    table_name = session['table_name']
    operation = None
    form_html = ''
    if request.method == 'POST' and 'insert_form' in request.form:
        operation = 'insert'
        table = nested_list_to_html_table(select_with_headers(mysql, table_name), buttons=True)
        form_html = get_insert_form(select_with_headers(mysql, table_name)[0])
        return render_template('edit.html', table=table, table_name=table_name, operation=operation, form_html=form_html)
    elif request.method == 'POST' and 'insert_execute' in request.form:
        columns = select_with_headers(mysql, table_name)[0]
        values = []
        for col in columns:
            val = request.form[col]
            if val.isnumeric():
                values.append(val)
            else:
                values.append("\'" + val + "\'")
        try:
            tables = insert_to_table(mysql, table_name, columns, values)
        except Exception as e:
            return render_template('invalid.html', e=str(e))
        tables = [nested_list_to_html_table(t) for t in tables]
        return render_template('insert_results.html', tables=tables, table_name=table_name)
    elif request.method == 'POST' and 'delete_button' in request.form:
        values = request.form['delete_button'].split(',')
        values = [val if val.isnumeric() else "\'" + val + "\'" for val in values]
        columns = select_with_headers(mysql, table_name)[0]
        where = []
        for col, val in zip(columns, values):
            where.append(col + " = " + val)
        where = " AND ".join(where)
        try:
            tables = delete_from_table(mysql, table_name, where)
        except Exception as e:
            return render_template('invalid.html', e=str(e))
        tables = [nested_list_to_html_table(t) for t in tables]
        return render_template('delete_results.html', tables=tables, table_name=table_name)
    elif request.method == 'POST' and 'update_button' in request.form:
        operation = 'update'
        table = nested_list_to_html_table(select_with_headers(mysql, table_name), buttons=True)
        values = request.form['update_button'].split(',')
        form_html = get_update_form(select_with_headers(mysql, table_name)[0], values)
        values = [val if val.isnumeric() else "\'" + val + "\'" for val in values]
        columns = select_with_headers(mysql, table_name)[0]
        where = []
        for col, val in zip(columns, values):
            where.append(col + " = " + val)
        where = " AND ".join(where)
        session['update_where'] = where
        return render_template('edit.html', table=table, table_name=table_name, operation=operation, form_html=form_html)
    elif request.method == 'POST' and 'update_execute' in request.form:
        columns = select_with_headers(mysql, table_name)[0]
        values = []
        for col in columns:
            val = request.form[col]
            if val.isnumeric():
                values.append(val)
            else:
                values.append("\'" + val + "\'")
        
        set_statement = []
        for col, val in zip(columns, values):
            set_statement.append(col + " = " + val)
        set_statement = ", ".join(set_statement)

        try:
            tables = update_table(mysql, table_name, set_statement, session['update_where'])
        except Exception as e:
            return render_template('invalid.html', e=str(e))
        tables = [nested_list_to_html_table(t) for t in tables]
        if session.get('update_where'):
            session.pop('update_where', None)
        return render_template('update_results.html', tables=tables, table_name=table_name)


    table = nested_list_to_html_table(select_with_headers(mysql, table_name), buttons=True)
    return render_template('edit.html', table=table, table_name=table_name, operation=operation, form_html=form_html)

if __name__ == '__main__':
    app.run()