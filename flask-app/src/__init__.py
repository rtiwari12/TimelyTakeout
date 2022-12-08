# Some set up for the application 

from flask import Flask
from flaskext.mysql import MySQL

# MySQL object that we will use in other parts of the API
db = MySQL()


def create_app():
    app = Flask(__name__)
    
    # secret key that will be used for securely signing the session 
    # cookie and can be used for any other security related needs by 
    # extensions or your application
    app.config['SECRET_KEY'] = 'someCrazyS3cR3T!Key.!'

    # for the DB object to be able to connect to MySQL.
    app.config['MYSQL_DATABASE_USER'] = 'webapp'
    app.config['MYSQL_DATABASE_PASSWORD'] = open('/secrets/db_password.txt').readline()
    app.config['MYSQL_DATABASE_HOST'] = 'db'
    app.config['MYSQL_DATABASE_PORT'] = 3306
    app.config['MYSQL_DATABASE_DB'] = 'TimelyTakeout'
    # Initialize the database object with the settings above. 
    db.init_app(app)
    
    # Import the various routes
    from src.consumers.consumers import consumers
    from src.employees.employees  import employees
    from src.store.store import store
    from src.store_mgr.store_mgr import store_mgr

    # Register the routes that we just imported so they can be properly handled
    app.register_blueprint(consumers,   url_prefix='/cns')
    app.register_blueprint(employees,    url_prefix='/emp')
    app.register_blueprint(store,  url_prefix='/str')
    app.register_blueprint(store_mgr,   url_prefix='/stmgr')

    return app