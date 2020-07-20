from flask import g
import pymysql

def get_db():

    if 'db' not in g:
        conn = pymysql.connect('localhost','root','test','qa')
    return g.db

def close_db(e=None):
    db = g.pop('db', None)

    if db is not None:
        db.close()