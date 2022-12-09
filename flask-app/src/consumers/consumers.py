from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


consumers = Blueprint('consumers', __name__)

# Get all customers from the DB
@consumers.route('/consumers', methods=['GET'])
def get_customers():
    cursor = db.get_db().cursor()
    cursor.execute('select * from Consumer')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get customer detail for customer with particular userID
@consumers.route('/consumer/<userID>', methods=['GET'])
def get_reviews(userID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Consumer where ConsumerID = {0}'.format(userID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# View all reviews from database
@consumers.route('/reviews', methods=['GET'])
def get_customer():
    cursor = db.get_db().cursor()
    cursor.execute('select * from Review')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Allow customer to leave a review of an order
# idea -> enter customerID and orderID to validate, then allow customer to leave a rating and write a review of an order
@consumers.route('consumers/review')
def review():
    return """
                <h2>Leave an Order Review</h2>
                <form action="/cns/review" method="POST">
                <h2>ID Confirmations</h2>
                <label for="consumerID">Please enter your ID:</label><br>
                <input type="text" id="consumerID" name="consumerID" value=""><br>
                <label for="orderID">Please enter your Order ID:</label><br>
                <input type="text" id="orderID" name="orderID" value=""><br>
                <label for="employeeID">Please enter the ID of the employee you wish to review:</label><br>
                <input type="text" id="employeeID" name="employeeID" value=""><br>
                <label for="ratingID">Please enter a 6 digit number:</label><br>
                <input type="text" id="ratingID" name="ratingID" value=""><br>
                <h2>Leave Review</h2>
                <label for="rating">Enter a rating (1-10):</label><br>
                <input type="rating" id="Stock" name="rating" value=""><br>
                <label for="description">Enter a description:</label><br>
                <input type="text" id="description" name="description" value=""><br>
                <input type="submit" value="Submit">
                </review>
                """

# gather all product info and new stock and update in database
@consumers.route("/review", methods = ['POST'])
def post_updateform():
    current_app.logger.info(request.form)
    cursor = db.get_db().cursor()
    consumerID = request.form['consumerID']
    orderID = request.form['orderID']
    employeeID = request.form['employeeID']
    ratingID = request.form['ratingID']
    rating = request.form['rating']
    description = request.form['description']
    query = f'INSERT INTO Review (reviewID, Rating, Description, orderID, employeeID, consumerID) VALUES ({ratingID}, {rating}, "{description}", {orderID}, {employeeID}, {consumerID})'
    cursor.execute(query)
    db.get_db().commit()
    return f'Successfully created review {ratingID}'