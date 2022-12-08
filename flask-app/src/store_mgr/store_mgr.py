from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


store_mgr = Blueprint('store_mgr', __name__)

# get all store managers
@store_mgr.route('/store_mgr', methods=['GET'])
def test():
    cursor = db.get_db().cursor()
    cursor.execute('select * from StoreManager')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


# apply to be a store manager with a relevant store
# idea -> receive store info and mgr info, add to database if not duplicated
@store_mgr.route('/store_mgr/apply')
def add_store():
    return """
        <h2>Store Info</h2>

        <form action="/stmgr/applyform" method="POST">
        <label for="Store">Store name:</label><br>
        <input type="text" id="Store" name="Store" value=""><br>
        <label for="Street">Street:</label><br>
        <input type="text" id="Street" name="Street" value=""><br>
        
        <label for="City">City:</label><br>
        <input type="text" id="City" name="City" value=""><br>
        <label for="State">State:</label><br>
        <input type="text" id="State" name="State" value=""><br>
        
        <label for="Country">Country:</label><br>
        <input type="text" id="Country" name="Country" value=""><br>
        <label for="ZIP">ZIP:</label><br>
        <input type="text" id="ZIP" name="ZIP" value=""><br>
        <label for="Store ID">Enter 6 digit Store ID:</label><br>
        <input type="text" id="Store ID" name="Store ID" value=""><br>
        <br>
        <h2>Manager Info</h2>
        <label for="first">First name:</label><br>
        <input type="text" id="first" name="first" value=""><br>
        <label for="last">Last name:</label><br>
        <input type="text" id="last" name="last" value=""><br><br>
        <label for="mgr_id">Enter 6 digit Manager ID:</label><br>
        <input type="text" id="mgr_id" name="mgr_id" value=""><br><br>
        <input type="submit" value="Submit">
        </applyform>
        """

# gather all store and manager info and add to database
@store_mgr.route("/applyform", methods = ['POST'])
def post_applyform():
    current_app.logger.info(request.form)
    cursor = db.get_db().cursor()
    store = request.form['Store']
    street = request.form['Street']
    city = request.form['City']
    state = request.form['State']
    country = request.form['Country']
    zip_code = request.form['ZIP']
    store_id = request.form['Store ID']
    first_name = request.form['first']
    last_name = request.form['last']
    mgr_id = request.form['mgr_id']
    query = f'INSERT INTO StoreManager(ManagerID, lastName, firstName) VALUES (\"{mgr_id}\", \"{last_name}\", \"{first_name}\")'
    cursor.execute(query)
    db.get_db().commit()
    query = f'INSERT INTO Store(storeID, Name, Street, City, State, Country, Zip, managerID) VALUES (\"{store_id}\", \"{store}\", \"{street}\", \"{city}\", \"{state}\", \"{country}\", \"{zip_code}\", \"{mgr_id}\")'
    cursor.execute(query)
    db.get_db().commit()
    return f'Successfully added new Store "{store}" and new manager "{first_name}" with id {mgr_id}'

# update store inventory
# idea -> 1) log in with store name, mgr first name, mgr last name, mgr id
#         2) receive product and new stock, update in database
@store_mgr.route('/store_mgr/update')
def update_inventory():
    return """
            <h2>Update Inventory</h2>

            <form action="/stmgr/updateform" method="POST">
            <h2>Store Info</h2>
            <label for="Store">Store name:</label><br>
            <input type="text" id="Store" name="Store" value=""><br>
            
            <label for="StoreID">Store ID:</label><br>
            <input type="text" id="StoreID" name="StoreID" value=""><br>
            <h2>Product Info</h2>
            <label for="Product">Product name:</label><br>
            <input type="text" id="Product" name="Product" value=""><br>
            
            <label for="ProductID">Product ID:</label><br>
            <input type="text" id="ProductID" name="ProductID" value=""><br>
            
            <label for="Stock">Updated Stock:</label><br>
            <input type="text" id="Stock" name="Stock" value=""><br>
            <h2>Confirm Status</h2>
            <label for="mgr_id">Please confirm with your manager id:</label><br>
            <input type="text" id="mgr_id" name="mgr_id" value=""><br>
            
            <input type="submit" value="Submit">
            </updateform>
            """

# gather all product info and new stock and update in database
@store_mgr.route("/updateform", methods = ['POST'])
def post_updateform():
    current_app.logger.info(request.form)
    cursor = db.get_db().cursor()
    store = request.form['Store']
    storeID = request.form['StoreID']
    product = request.form['Product']
    productID = request.form['ProductID']
    stock = request.form['Stock']
    mgr_id = request.form['mgr_id']
    query = f'UPDATE Product SET stock = {stock} WHERE StoreID = {storeID} AND productName = \"{product}\" AND productID = {productID}'
    cursor.execute(query)
    db.get_db().commit()
    return f'Successfully updated the stock of {product} in {store} to {stock}'