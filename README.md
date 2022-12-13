Product Pitch Link: https://youtu.be/2HvzjrypxU4

Welcome to TimelyTakeout! Our product will offer a grocery delivery service that combines  
the best interests of consumers, employees, and store owners alike. TimelyTakeout will
allow consumers to select products from a store’s inventory to add to an order, and 
place said orders using a chosen address and payment method to be carried out by 
employees. The manager of each store that uses TimelyTakeout will also interact with 
the application to ensure that products can be ordered and delivered as efficiently as 
possible. With this product, we hope to provide a simple yet effective service for 
virtual grocery shopping that surpasses the many shortcomings of existing services.
Consumers should be able to easily interact with the application, employees should
be able to easily carry out orders and manage the money they earn from doing so, 
and store managers should be easily able to adjust their store’s online inventory.

TimelyTakeout's current implementation contains routes for the consumer persona that
currently allow us to get info of all customers from the database ('get'), get info of a 
particular customer ('get'), view all reviews that have been left ('get'), and enable 
customers to leave a review of an order ('post'). For the employee persona, the current 
routes allow us to access a certain employee from the database ('get'), get all existing 
payments ('get'), and get all transactions involving a certain employee ('get'), in hopes
of implementing bank account transfer capabilities in the future. The routes for a store 
manager allow access to all store managers from within the database ('get'), allow the 
ability to apply a new store and store manager ('post'), and allow a store manager to update 
their store's inventory ('post'). Finally, we are also able to access all stores from the 
database ('get'), their names ('get'), as well as all the products within a certain store 
('get'). 

<img width="324" alt="image" src="https://user-images.githubusercontent.com/113547817/207406395-2d70a063-1312-4103-ae63-80ccaa4596af.png">


## How to setup and start the containers
**Important** - you need Docker Desktop installed

1. Clone this repository.  
1. Create a file named `db_root_password.txt` in the `secrets/` folder and put inside of it the root password for MySQL. 
1. Create a file named `db_password.txt` in the `secrets/` folder and put inside of it the password you want to use for the `webapp` user. 
1. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.  
1. Build the images with `docker compose build`
1. Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`. 







