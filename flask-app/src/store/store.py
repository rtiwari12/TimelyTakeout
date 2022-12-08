from flask import Blueprint, request, jsonify, make_response
import json
from src import db


store = Blueprint('store', __name__)

# Get all stores from the DB
@store.route('/stores', methods=['GET'])
def get_stores():
    cursor = db.get_db().cursor()
    cursor.execute('select * from Store')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get all products within a specific store
@store.route('/store/<storeName>', methods=['GET'])
def get_store(storeName):
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products from a certain store
    cursor.execute(f"SELECT * FROM Product WHERE StoreID=(SELECT storeID FROM Store WHERE Name = '{storeName}')")

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers.
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)