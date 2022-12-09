from flask import Blueprint, request, jsonify, make_response
import json
from src import db


employees = Blueprint('employees', __name__)

# Get employee detail for employee with particular employeeID
@employees.route('/employee/<userID>', methods=['GET'])
def get_employee(userID):
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a certain employee
    cursor.execute('select * from Employee where employeeID = {0}'.format(userID))

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

# Get all payments in the database
@employees.route('/payments', methods=['GET'])
def get_payments():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for transactions
    cursor.execute('select * from Payment')

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

# Get all transactions involving the specified employee
@employees.route('/employee/<userID>/balance', methods=['GET'])
def get_employee_balance(userID):
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for transactions
    cursor.execute('select * from Payment where EmployeeID = {0}'.format(userID))

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
