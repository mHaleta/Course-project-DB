import cx_Oracle
from dao.credentials import *
from time import gmtime, strftime


def show_advertisements():
    connection = cx_Oracle.connect(username, password, databaseName)
    cursor = connection.cursor()
    query = 'select * from table(SHOW.show_advertisements())'
    cursor.execute(query)
    result = cursor.fetchall()
    cursor.close()
    connection.close()
    return result


def find_adverts_by_product(product):
    connection = cx_Oracle.connect(username, password, databaseName)
    cursor = connection.cursor()
    query = 'select * from table(SHOW.find_adverts_by_product(\'{}\'))'.format(product)
    cursor.execute(query)
    result = cursor.fetchall()
    cursor.close()
    connection.close()
    return result


def find_adverts_by_vendor(vendor):
    connection = cx_Oracle.connect(username, password, databaseName)
    cursor = connection.cursor()
    query = 'select * from table(SHOW.find_adverts_by_vendor(\'{}\'))'.format(vendor)
    cursor.execute(query)
    result = cursor.fetchall()
    cursor.close()
    connection.close()
    return result


def is_advert_exists(login, name):
    connection = cx_Oracle.connect(username, password, databaseName)
    cursor = connection.cursor()
    res = cursor.callfunc('INSERT_INTO_TABLES.is_advert_exists', cx_Oracle.STRING, [login, name])
    cursor.close()
    connection.close()
    return res

def get_advert_by_id(ad_id, login):
    connection = cx_Oracle.connect(username, password, databaseName)
    cursor = connection.cursor()
    res = cursor.callfunc('DELETE_FROM_TABLES.get_advert_by_id', cx_Oracle.STRING, [ad_id, login])
    cursor.close()
    connection.close()
    return res


def add_advertisement(login, name, price, quantity, description):
    connection = cx_Oracle.connect(username, password, databaseName)
    cursor = connection.cursor()
    date = strftime("%H:%M:%S %d.%m.%Y", gmtime())

    args = [date, login, name, price, quantity, description]
    cursor.callproc('INSERT_INTO_TABLES.add_advertisement', args)

    cursor.close()
    connection.close()

def delete_advert_by_id(ad_id):
    connection = cx_Oracle.connect(username, password, databaseName)
    cursor = connection.cursor()
    res = cursor.callproc('DELETE_FROM_TABLES.delete_from_advertisement', [ad_id])
    cursor.close()
    connection.close()
    return res
