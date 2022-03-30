from flask import Flask, render_template, request, redirect, url_for
from flask_mysqldb import MySQL
import MySQLdb.cursors

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

@app.route('/insert')
def insert():
    return render_template('insert.html')

@app.route('/update')
def update():
    return render_template('update.html')

@app.route('/delete')
def delete():
    return render_template('delete.html')

if __name__ == '__main__':
    app.run()