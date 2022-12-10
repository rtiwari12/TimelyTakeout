-- Create a new database.
create database TimelyTakeout;

-- Via the Docker Compose file, a special user called webapp will 
-- be created in MySQL. We are going to grant that user 
-- all privilages to the new database we just created.
grant all privileges on TimelyTakeout.* to 'webapp'@'%';
flush privileges;

-- Move into the database we just created.
use TimelyTakeout;

-- DDL
CREATE TABLE Consumer
(
    consumerID INTEGER NOT NULL UNIQUE,
    firstName  TEXT    NOT NULL,
    lastName   TEXT    NOT NULL,
    City       TEXT    NOT NULL,
    State      TEXT    NOT NULL,
    Street     TEXT    NOT NULL,
    Zip        INTEGER NOT NULL,
    Country    TEXT    NOT NULL,
    Payment    TEXT    NOT NULL,
    PRIMARY KEY (consumerID)
);

CREATE TABLE Employee
(
    employeeID INTEGER NOT NULL UNIQUE,
    lastName   TEXT    NOT NULL,
    firstName  TEXT    NOT NULL,
    managerID  INTEGER,
    FOREIGN KEY (managerID) REFERENCES Employee (employeeID),
    PRIMARY KEY (employeeID)
);
CREATE TABLE Orders
(
    itemTotal  Decimal(10,2)    NOT NULL,
    tip        Decimal(10,2)    NOT NULL,
    total      Decimal(10,2)    NOT NULL,
    orderID    INTEGER NOT NULL UNIQUE,
    employeeID INTEGER NOT NULL,
    consumerID INTEGER NOT NULL,
    FOREIGN KEY (consumerID) REFERENCES Consumer (consumerID),
    FOREIGN KEY (employeeID) REFERENCES Employee (employeeID),
    PRIMARY KEY (orderID)
);
CREATE TABLE Payment
(
    employeeID      INTEGER NOT NULL,
    paymentNum      INTEGER NOT NULL UNIQUE,
    transactionDate TEXT    NOT NULL,
    transactionAmt  Decimal(10,2)    NOT NULL,
    accountNum      TEXT NOT NULL,
    PRIMARY KEY (paymentNum),
    FOREIGN KEY (employeeID) REFERENCES Employee (employeeID)
);
CREATE TABLE ProductType
(
    TypeID   INTEGER NOT NULL UNIQUE,
    typeName TEXT    NOT NULL,
    Units    INTEGER    NOT NULL,
    PRIMARY KEY (TypeID)
);
CREATE TABLE Review
(
    reviewID    INTEGER NOT NULL UNIQUE,
    Rating      INTEGER NOT NULL,
    Description TEXT    NOT NULL,
    orderID     INTEGER NOT NULL UNIQUE,
    employeeID  INTEGER NOT NULL,
    consumerID  INTEGER NOT NULL,
    FOREIGN KEY (consumerID) REFERENCES Consumer (consumerID),
    FOREIGN KEY (employeeID) REFERENCES Employee (employeeID),
    FOREIGN KEY (orderID) REFERENCES Orders (orderID),
    PRIMARY KEY (reviewID)
);
CREATE TABLE StoreManager
(
    ManagerID INTEGER NOT NULL UNIQUE,
    lastName  TEXT    NOT NULL,
    firstName TEXT    NOT NULL,
    PRIMARY KEY (ManagerID)
);
CREATE TABLE Store
(
    StoreID   INTEGER NOT NULL UNIQUE,
    Name      TEXT    NOT NULL,
    Street    TEXT    NOT NULL,
    City      TEXT    NOT NULL,
    State     TEXT    NOT NULL,
    Country   TEXT    NOT NULL,
    Zip       INTEGER NOT NULL,
    ManagerID INTEGER NOT NULL UNIQUE,
    FOREIGN KEY (ManagerID) REFERENCES StoreManager (ManagerID),
    PRIMARY KEY (StoreID)
);
CREATE TABLE Product
(
    productID   INTEGER NOT NULL UNIQUE,
    productName TEXT    NOT NULL,
    stock       INTEGER NOT NULL,
    OrderID     INTEGER NOT NULL,
    TypeID      INTEGER NOT NULL,
    StoreID     INTEGER NOT NULL,
    FOREIGN KEY (TypeID) REFERENCES ProductType (TypeID),
    FOREIGN KEY (StoreID) REFERENCES Store (StoreID),
    FOREIGN KEY (OrderID) REFERENCES Orders (orderID),
    PRIMARY KEY (productID)
);
CREATE TABLE Rating
(
    ratingID    INTEGER NOT NULL UNIQUE,
    Description TEXT    NOT NULL,
    Stars       INTEGER NOT NULL,
    ProductID   INTEGER NOT NULL UNIQUE,
    FOREIGN KEY (ProductID) REFERENCES Product (productID),
    PRIMARY KEY (ratingID)
);
CREATE TABLE Supplier
(
    SupplierID INTEGER NOT NULL UNIQUE,
    Name       TEXT    NOT NULL,
    Street     TEXT    NOT NULL,
    City       TEXT    NOT NULL,
    State      TEXT    NOT NULL,
    Country    TEXT    NOT NULL,
    Zip        INTEGER NOT NULL,
    PRIMARY KEY (SupplierID)
);
CREATE TABLE StoreSupplier
(
    StoreID    INTEGER NOT NULL,
    SupplierID INTEGER NOT NULL,
    supplyDate TEXT    NOT NULL,
    FOREIGN KEY (StoreID) REFERENCES Store (StoreID),
    FOREIGN KEY (SupplierID) REFERENCES Supplier (SupplierID),
    PRIMARY KEY (StoreID, SupplierID)
);

-- sample data.
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (1, 'Cristiano', 'Boutell', 'Chicago', 'Illinois', '84 Spaight Park', 60681, 'United States', 'mastercard');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (2, 'Elianora', 'Hannam', 'Cleveland', 'Ohio', '4 Dottie Lane', 44111, 'United States', 'mastercard');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (3, 'Ricca', 'Myott', 'Canton', 'Ohio', '876 Mesta Road', 44720, 'United States', 'visa');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (4, 'Milka', 'Rhys', 'Topeka', 'Kansas', '8 Bartelt Center', 66611, 'United States', 'mastercard');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (5, 'Mikel', 'Crebbin', 'Cleveland', 'Ohio', '36014 Oriole Park', 44118, 'United States', 'mastercard');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (6, 'Ulises', 'Burress', 'Charlotte', 'North Carolina', '193 Brickson Park Crossing', 28272, 'United States', 'mastercard');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (7, 'Kelly', 'Marham', 'Saint Louis', 'Missouri', '65810 Service Lane', 63104, 'United States', 'americanexpress');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (8, 'Constancia', 'Williscroft', 'Phoenix', 'Arizona', '0247 Debra Pass', 85030, 'United States', 'mastercard');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (9, 'Antonella', 'Pearn', 'Baltimore', 'Maryland', '0 Longview Avenue', 21211, 'United States', 'americanexpress');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (10, 'Emlynne', 'Kibard', 'Roanoke', 'Virginia', '279 Bultman Terrace', 24014, 'United States', 'visa');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (11, 'Susi', 'Woller', 'Reno', 'Nevada', '97 Ludington Pass', 89510, 'United States', 'visa');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (12, 'Rozella', 'Perfitt', 'Burbank', 'California', '58287 Karstens Alley', 91520, 'United States', 'americanexpress');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (13, 'Beaufort', 'Huxton', 'Pasadena', 'California', '6259 Eliot Alley', 91103, 'United States', 'mastercard');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (14, 'Elke', 'Spittles', 'El Paso', 'Texas', '64552 Lighthouse Bay Avenue', 88546, 'United States', 'visa');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (15, 'Kippy', 'Kinsell', 'Atlanta', 'Georgia', '04231 Burning Wood Park', 30336, 'United States', 'visa');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (16,'Sam','Rominov','Columbus','Ohio','18084 Declaration Terrace',12232,'United States','americanexpress');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (17,'Ingrim','Blakeney','San Jose','California','13230 Garrison Road',86839,'United States','diners-club-enroute');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (18,'Deloria','Baldin','Nashville','Tennessee','95 Maple Pass',43987,'United States','diners-club-enroute');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (19,'Erick','Tripean','Sarasota','Florida','3081 Welch Place',79821,'United States','maestro');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (20,'Belva','Carslaw','Youngstown','Ohio','8852 Debs Circle',08462,'United States','jcb');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (21,'Alexis','Tabram','Atlanta','Georgia','6 Maywood Drive',34074,'United States','china-unionpay');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (22,'Brina','Lavin','Fort Lauderdale','Florida','0 Garrison Point',66839,'United States','maestro');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (23,'Lew','Brando','Montgomery','Alabama','82379 Scoville Hill',7-5418,'United States','diners-club-enroute');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (24,'Devland','McGruar','San Jose','California','7848 Lindbergh Place',49404,'United States','diners-club-enroute');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (25,'Ingram','Duce','Staten Island','New York','50856 Vidon Drive',29218,'United States','mastercard');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (26,'Eran','Nibloe','Nashville','Tennessee','3 Spenser Court',53268,'United States','mastercard');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (27,'Albrecht','McHale','Houston','Texas','76 Novick Drive',22218,'United States','jcb');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (28,'Ewell','Bowman','Omaha','Nebraska','384 Mockingbird Hill',71289,'United States','jcb');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (29,'Carissa','Coakley','El Paso','Texas','65886 Graceland Center',24341,'United States','china-unionpay');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (30,'Riccardo','Gunton','Lancaster','Pennsylvania','63725 Bellgrove Road',19524,'United States','jcb');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (31,'Harman','Querree','Fort Lauderdale','Florida','48349 Petterle Court',17780,'United States','mastercard');


insert into Employee (employeeID, firstName, lastName, managerID) values (1, 'Jerrie', 'Littefair', null);
insert into Employee (employeeID, firstName, lastName, managerID) values (2, 'Marylynne', 'Downe', 1);
insert into Employee (employeeID, firstName, lastName, managerID) values (3, 'Clem', 'Stutte', 2);
insert into Employee (employeeID, firstName, lastName, managerID) values (4, 'Daloris', 'Stelljes', 2);
insert into Employee (employeeID, firstName, lastName, managerID) values (5, 'Dagny', 'Alway', 2);
insert into Employee (employeeID, firstName, lastName, managerID) values (6, 'Georas', 'Hands', 2);
insert into Employee (employeeID, firstName, lastName, managerID) values (7, 'Nalani', 'Ioan', 3);
insert into Employee (employeeID, firstName, lastName, managerID) values (8, 'Ewart', 'Ubsdale', 3);
insert into Employee (employeeID, firstName, lastName, managerID) values (9, 'Christye', 'Heatlie', 3);
insert into Employee (employeeID, firstName, lastName, managerID) values (10, 'Ardath', 'Salliere', 3);
insert into Employee (employeeID, firstName, lastName, managerID) values (11, 'Sigfried', 'Hanster', 3);
insert into Employee (employeeID, firstName, lastName, managerID) values (12, 'Bianca', 'Halsho', 3);
insert into Employee (employeeID, firstName, lastName, managerID) values (13, 'Ardelle', 'Touson', 2);
insert into Employee (employeeID, firstName, lastName, managerID) values (14, 'Gerick', 'Gammill', 1);
insert into Employee (employeeID, firstName, lastName, managerID) values (15, 'Scotti', 'Downes', 1);
insert into Employee (employeeID, firstName, lastName, managerID) values (16,'Violette','Danbye',3);
insert into Employee (employeeID, firstName, lastName, managerID) values (17,'Lavina','Hornig',2);
insert into Employee (employeeID, firstName, lastName, managerID) values (18,'Tamera','Ussher',1);
insert into Employee (employeeID, firstName, lastName, managerID) values (19,'Donica','Lelliott',3);
insert into Employee (employeeID, firstName, lastName, managerID) values (20,'Mathe','Bashford',2);
insert into Employee (employeeID, firstName, lastName, managerID) values (21,'Claudianus','Orteaux',1);
insert into Employee (employeeID, firstName, lastName, managerID) values (22,'Terza','Roeby',3);
insert into Employee (employeeID, firstName, lastName, managerID) values (23,'Shepperd','Brazear',2);
insert into Employee (employeeID, firstName, lastName, managerID) values (24,'Sarah','Gruby',1);
insert into Employee (employeeID, firstName, lastName, managerID) values (25,'Rosabella','Taunton',3);
insert into Employee (employeeID, firstName, lastName, managerID) values (26,'Jinny','Gerrish',2);
insert into Employee (employeeID, firstName, lastName, managerID) values (27,'Linoel','Heaviside',1);
insert into Employee (employeeID, firstName, lastName, managerID) values (28,'Babbette','Jeanenet',3);
insert into Employee (employeeID, firstName, lastName, managerID) values (29,'Drucill','Skullet',2);
insert into Employee (employeeID, firstName, lastName, managerID) values (30,'Arlan','Hambric',1);


insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (1, 18.0, 61.67, 84.29, 15, 10);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (2, 87.55, 36.07, 56.8, 14, 11);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (3, 7.64, 95.01, 91.79, 13, 12);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (4, 8.69, 83.61, 4.91, 12, 13);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (5, 22.81, 79.34, 9.64, 11, 14);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (6, 10.37, 87.58, 2.63, 10, 15);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (7, 55.94, 88.7, 84.87, 9, 1);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (8, 80.28, 40.75, 45.59, 8, 2);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (9, 69.62, 48.86, 22.49, 7, 3);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (10, 69.75, 22.99, 9.83, 6, 4);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (11, 63.37, 39.84, 42.91, 5, 5);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (12, 18.26, 22.77, 51.6, 4, 6);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (13, 93.8, 30.91, 73.86, 3, 7);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (14, 96.58, 80.64, 9.19, 2, 8);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (15, 85.82, 71.05, 91.95, 1, 9);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (16, 46.65, 4.05, 60.43, 14, 4);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (17,116.09,15.71,118.36,11,1);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (18,88.42,11.52,151.86,5,13);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (19,136.61,5.64,62.55,13,19);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (20,97.82,11.86,65.91,27,21);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (21,94.44,12.51,63.03,19,12);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (22,75.74,11.05,136.32,13,29);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (23,64.76,15.2,160.78,23,26);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (24,70.29,3.61,108.96,23,28);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (25,67.85,19.68,79.87,28,26);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (26,63.2,18.94,177.64,10,20);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (27,108.91,8.93,141.47,27,16);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (28,56.45,10.91,111.75,25,22);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (29,116.18,7.41,81.13,20,20);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (30,133.5,6.05,191.78,4,29);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (31,67.82,3.21,139.79,16,11);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (32,61.85,23.34,103.97,19,7);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (33,135.42,15.13,101.14,24,3);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (34,122.8,6.06,92.67,26,11);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (35,68.86,1.27,82.21,13,6);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (36,91.65,23.79,91.73,17,7);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (37,69.89,7.58,135.52,5,9);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (38,139.54,11.12,165.33,29,19);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (39,54.3,15.6,78.29,11,22);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (40,75.94,11.47,126.44,8,8);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (41,136.24,15.49,131.67,8,19);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (42,123.44,14.95,151.59,17,23);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (43,98.01,14.35,96.98,27,21);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (44,100.63,21.84,188.11,9,28);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (45,63.49,2.75,116.95,30,14);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (46,131.91,8.91,108.56,2,22);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (47,80.49,22.02,70.95,7,14);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (48,114.52,2.35,174.11,29,5);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (49,114.63,11.16,171.76,14,10);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (50,126.71,6.81,170.37,4,2);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (51,132.6,6.12,117.3,20,27);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (52,86.31,23.48,178.14,9,15);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (53,110.25,4.13,159.76,30,10);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (54,149.54,8.2,151.51,9,27);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (55,50.91,6.88,157.21,12,24);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (56,91.83,13.3,179.53,1,28);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (57,73.88,9.54,187.09,18,18);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (58,142.98,9.14,98.45,25,5);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (59,68.53,20.62,166.26,4,10);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (60,135.22,18.13,62.57,1,2);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (61,149.86,24.74,131.44,23,25);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (62,126.17,8.53,153.58,4,21);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (63,102.01,1.75,194.31,7,8);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (64,72.82,20.97,102.87,13,12);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (65,142.83,2.94,133.85,30,3);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (66,128.54,17.74,98.59,14,16);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (67,136.99,1.74,150.55,27,2);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (68,89.76,13.57,76.1,4,9);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (69,111.51,17.11,159.6,14,16);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (70,145.68,10.71,101.27,23,24);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (71,66.9,10.08,173.98,30,26);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (72,51.21,4.02,198.2,29,19);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (73,104.72,6.62,199.53,30,7);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (74,91.86,2.36,156.46,8,27);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (75,87.0,7.32,163.39,12,14);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (76,93.03,7.74,86.84,6,8);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (77,105.25,14.17,180.87,16,20);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (78,93.22,13.44,169.94,20,17);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (79,63.51,18.03,191.15,13,4);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (80,109.87,14.25,69.55,6,12);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (81,84.12,10.91,103.54,11,20);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (82,68.32,1.83,159.57,26,27);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (83,73.17,15.24,134.78,23,7);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (84,127.28,21.33,195.66,25,7);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (85,94.15,17.06,184.15,3,22);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (86,62.98,3.82,190.13,26,30);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (87,143.6,16.98,170.8,20,5);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (88,60.1,10.16,197.76,27,25);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (89,97.08,11.97,132.87,23,28);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (90,136.0,6.93,180.5,10,3);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (91,127.01,11.28,166.59,9,3);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (92,137.6,7.25,162.85,3,2);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (93,67.29,14.52,127.24,17,2);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (94,112.47,4.74,104.52,20,1);
insert into Orders (OrderID, itemTotal, tip, Total, employeeID, consumerID) values (95,61.36,23.53,188.57,27,18);

insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (15, 1, '2021-05-27', 124.42, '5007666531281848');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (14, 2, '2022-09-10', 423.48, '4017959477916100');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (13, 3, '2020-07-14', 304.64, '5002352830292415');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (12, 4, '2021-08-07', 10.78, '4041375576360');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (11, 5, '2021-08-16', 147.01, '4041593225584');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (10, 6, '2021-08-09', 454.74, '337941468187140');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (9, 7, '2022-07-24', 119.91, '374288850079467');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (8, 8, '2021-08-24', 294.44, '4041373872769181');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (7, 9, '2020-10-04', 276.87, '4041596512599028');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (6, 10, '2022-01-17', 231.58, '337941653468941');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (5, 11, '2022-07-27', 226.57, '337941723779970');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (4, 12, '2020-10-18', 205.86, '4017958554388');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (3, 13, '2021-06-16', 313.1, '4041594881998368');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (2, 14, '2022-06-08', 337.44, '4041371237314');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (1, 15, '2021-05-30', 388.7, '4727319465732');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (13,16,'2/2/2022',167.64,'5655997935876433');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (30,17,'3/5/2022',76.21,'2775524545316146');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (25,18,'8/23/2022',10.43,'9207063365404338');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (23,19,'3/10/2022',147.79,'9397003200136665');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (24,20,'10/19/2022',133.02,'6211792854784348');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (24,21,'11/24/2022',54.78,'9453099563120909');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (23,22,'9/9/2022',14.93,'74753355723246560');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (13,23,'3/23/2022',118.9,'2410927793244406');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (27,24,'6/23/2022',59.27,'7788414498232679');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (14,25,'10/30/2022',102.52,'8402995579798559');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (21,26,'6/24/2022',181.41,'7761708289256258');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (14,27,'4/17/2022',45.18,'6959852882550358');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (1,28,'7/13/2022',122.16,'3428462274073977');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (30,29,'4/18/2022',129.97,'5651114566639103');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (13,30,'4/9/2022',144.5,'7417681828159997');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (15,31,'11/17/2022',193.49,'7383350363206331');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (29,32,'1/13/2022',144.13,'1524122709062226');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (15,33,'7/27/2022',134.65,'4738650870423382');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (19,34,'2/28/2022',115.21,'2068623274450031');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (18,35,'1/25/2022',47.27,'7984700057349584');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (2,36,'4/17/2022',94.31,'3934548636401626');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (9,37,'5/24/2022',102.27,'6841610184667024');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (29,38,'11/23/2022',43.5,'5598945307777128');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (28,39,'4/28/2022',140.39,'6811221162509032');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (8,40,'9/17/2022',47.81,'8748308378159193');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (6,41,'10/2/2022',29.83,'3617128715637588');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (4,42,'4/7/2022',68.43,'8793400313968759');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (19,43,'5/27/2022',34.5,'7369083288040833');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (15,44,'7/9/2022',78.93,'7236589149844116');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (14,45,'11/23/2022',42.66,'2994457297516439');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (8,46,'8/7/2022',180.28,'2627703731917861');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (19,47,'10/28/2022',81.01,'2400273669669446');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (16,48,'11/21/2022',130.63,'5762181968240784');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (19,49,'12/17/2021',11.03,'9251492268977541');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (8,50,'11/14/2022',106.95,'4480249384036739');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (25,51,'6/4/2022',150.41,'2976380633159787');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (14,52,'3/5/2022',98.36,'9903068559780308');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (6,53,'3/3/2022',146.48,'8989322491028757');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (27,54,'2/10/2022',33.82,'1723551073828785');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (24,55,'3/11/2022',145.78,'9676983955586285');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (27,56,'12/2/2022',34.59,'5560609006019093');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (28,57,'12/29/2021',87.63,'2252187671628450');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (21,58,'2/13/2022',129.03,'6766004650874577');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (10,59,'5/24/2022',75.34,'2490790523312037');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (8,60,'8/26/2022',192.24,'5870087806515984');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (9,61,'6/14/2022',199.76,'2725948110928891');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (7,62,'6/6/2022',186.16,'1183234172212714');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (25,63,'3/18/2022',181.88,'4025221742404756');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (8,64,'7/12/2022',111.08,'5408041632574682');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (20,65,'9/26/2022',178.43,'5170922317724210');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (17,66,'12/28/2021',2.87,'1800769671734770');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (24,67,'5/17/2022',17.93,'7195178616194217');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (5,68,'3/11/2022',44.75,'3414481840332590');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (18,69,'12/11/2021',24.88,'7034146406712059');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (16,70,'10/26/2022',63.19,'4132504548596712');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (4,71,'12/14/2021',184.64,'1752619068726458');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (22,72,'10/9/2022',65.77,'5169853378976712');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (5,73,'8/5/2022',38.79,'7143021726613410');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (13,74,'2/19/2022',164.29,'3450216590821605');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (28,75,'5/21/2022',166.46,'5378033543136732');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (11,76,'1/4/2022',23.4,'3735037188220805');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (6,77,'8/12/2022',106.49,'5144490528754496');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (5,78,'11/12/2022',48.07,'7185852904205558');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (4,79,'8/15/2022',88.61,'5936916896156907');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (22,80,'1/21/2022',175.84,'1811799086692283');

insert into ProductType (typeID, typeName, Units) values (1, 'Wild Guave', 16.52);
insert into ProductType (typeID, typeName, Units) values (2, 'Robust Spineflower', 43.21);
insert into ProductType (typeID, typeName, Units) values (3, 'Eve''s Necklacepod', 30.26);
insert into ProductType (typeID, typeName, Units) values (4, 'Foothill Flatsedge', 17.52);
insert into ProductType (typeID, typeName, Units) values (5, 'Inland Sedge', 28.5);
insert into ProductType (typeID, typeName, Units) values (6, 'Obedient Plant', 45.66);
insert into ProductType (typeID, typeName, Units) values (7, 'Northern Moonwort', 22.7);
insert into ProductType (typeID, typeName, Units) values (8, 'Trematodon Moss', 6.64);
insert into ProductType (typeID, typeName, Units) values (9, 'Stokesia', 10.16);
insert into ProductType (typeID, typeName, Units) values (10, 'Sacred Bamboo', 25.38);
insert into ProductType (typeID, typeName, Units) values (11, 'Lemon Saptree', 27.32);
insert into ProductType (typeID, typeName, Units) values (12, 'Slender Cinquefoil', 23.11);
insert into ProductType (typeID, typeName, Units) values (13, 'Pinkroot', 35.89);
insert into ProductType (typeID, typeName, Units) values (14, 'Thurber''s Penstemon', 38.43);
insert into ProductType (typeID, typeName, Units) values (15, 'Bloody Geranium', 8.68);
insert into ProductType (typeID, typeName, Units) values (16,"Pork - Loin, Boneless",77);
insert into ProductType (typeID, typeName, Units) values (17,'Glass Clear 8 Oz',44);
insert into ProductType (typeID, typeName, Units) values (18,'Spice - Paprika',141);
insert into ProductType (typeID, typeName, Units) values (19,'Pastry - Baked Scones - Mini',177);
insert into ProductType (typeID, typeName, Units) values (20,'Longos - Grilled Salmon With Bbq',18);
insert into ProductType (typeID, typeName, Units) values (21,'Puff Pastry - Slab',182);
insert into ProductType (typeID, typeName, Units) values (22,'Rice - Jasmine Sented',69);
insert into ProductType (typeID, typeName, Units) values (23,'Foil Cont Round',67);
insert into ProductType (typeID, typeName, Units) values (24,'Chocolate - Unsweetened',85);
insert into ProductType (typeID, typeName, Units) values (25,'Cheese - Le Cheve Noir',55);
insert into ProductType (typeID, typeName, Units) values (26,'Muffin Mix - Corn Harvest',17);
insert into ProductType (typeID, typeName, Units) values (27,'Cornflakes',129);
insert into ProductType (typeID, typeName, Units) values (28,'Beef - Cow Feet Split',61);
insert into ProductType (typeID, typeName, Units) values (29,'Beans - Kidney White',198);
insert into ProductType (typeID, typeName, Units) values (30,'Island Oasis - Peach Daiquiri',156);
insert into ProductType (typeID, typeName, Units) values (31,'Pimento - Canned',185);
insert into ProductType (typeID, typeName, Units) values (32,'Cloves - Ground',84);
insert into ProductType (typeID, typeName, Units) values (33,'Quail - Jumbo',7);
insert into ProductType (typeID, typeName, Units) values (34,'Red Currants',104);
insert into ProductType (typeID, typeName, Units) values (35,"Juice - V8, Tomato",17);
insert into ProductType (typeID, typeName, Units) values (36,'Lotus Rootlets - Canned',121);
insert into ProductType (typeID, typeName, Units) values (37,'Tomato - Green',187);
insert into ProductType (typeID, typeName, Units) values (38,"Bread - Pumpernickle, Rounds",127);
insert into ProductType (typeID, typeName, Units) values (39,'Corn - Mini',21);
insert into ProductType (typeID, typeName, Units) values (40,'White Fish - Filets',130);
insert into ProductType (typeID, typeName, Units) values (41,'Drambuie',17);
insert into ProductType (typeID, typeName, Units) values (42,'Wine - Chateau Aqueria Tavel',48);
insert into ProductType (typeID, typeName, Units) values (43,"Tray - Foam, Square 4 - S",58);
insert into ProductType (typeID, typeName, Units) values (44,'Lemon Tarts',190);
insert into ProductType (typeID, typeName, Units) values (45,"Soup - Campbells, Minestrone",192);
insert into ProductType (typeID, typeName, Units) values (46,'French Pastry - Mini Chocolate',168);
insert into ProductType (typeID, typeName, Units) values (47,'Pork - Back Ribs',157);
insert into ProductType (typeID, typeName, Units) values (48,'Wine - Zinfandel Rosenblum',99);
insert into ProductType (typeID, typeName, Units) values (49,'Lamb - Shoulder',58);
insert into ProductType (typeID, typeName, Units) values (50,"Lamb - Leg, Boneless",42);
insert into ProductType (typeID, typeName, Units) values (51,'Beans - Green',176);
insert into ProductType (typeID, typeName, Units) values (52,'Icecream Cone - Areo Chocolate',7);
insert into ProductType (typeID, typeName, Units) values (53,'Coffee - Almond Amaretto',75);
insert into ProductType (typeID, typeName, Units) values (54,'Sauce - Rosee',131);
insert into ProductType (typeID, typeName, Units) values (55,'Sugar - Palm',65);
insert into ProductType (typeID, typeName, Units) values (56,'Cheese - Cream Cheese',93);
insert into ProductType (typeID, typeName, Units) values (57,'Wine - Zinfandel California 2002',84);
insert into ProductType (typeID, typeName, Units) values (58,'Oil - Olive',57);
insert into ProductType (typeID, typeName, Units) values (59,"Rice Pilaf, Dry,package",128);
insert into ProductType (typeID, typeName, Units) values (60,'Raisin - Golden',199);
insert into ProductType (typeID, typeName, Units) values (61,'Pecan Raisin - Tarts',15);
insert into ProductType (typeID, typeName, Units) values (62,'Dr. Pepper - 355ml',114);
insert into ProductType (typeID, typeName, Units) values (63,'Yucca',129);
insert into ProductType (typeID, typeName, Units) values (64,'Wine - Rhine Riesling Wolf Blass',124);
insert into ProductType (typeID, typeName, Units) values (65,'Salt - Kosher',56);
insert into ProductType (typeID, typeName, Units) values (66,'Walkers Special Old Whiskey',40);
insert into ProductType (typeID, typeName, Units) values (67,'Shopper Bag - S - 4',59);
insert into ProductType (typeID, typeName, Units) values (68,'Kippers - Smoked',46);
insert into ProductType (typeID, typeName, Units) values (69,"Schnappes - Peach, Walkers",104);
insert into ProductType (typeID, typeName, Units) values (70,'Tomato - Plum With Basil',41);
insert into ProductType (typeID, typeName, Units) values (71,'Bread - Italian Roll With Herbs',31);
insert into ProductType (typeID, typeName, Units) values (72,'Corn Meal',92);
insert into ProductType (typeID, typeName, Units) values (73,'Oranges',67);
insert into ProductType (typeID, typeName, Units) values (74,'Coffee - Irish Cream',161);
insert into ProductType (typeID, typeName, Units) values (75,'Zucchini - Green',118);
insert into ProductType (typeID, typeName, Units) values (76,'Nantucket - 518ml',140);
insert into ProductType (typeID, typeName, Units) values (77,'Yucca',177);
insert into ProductType (typeID, typeName, Units) values (78,"Mushroom - Chantrelle, Fresh",27);
insert into ProductType (typeID, typeName, Units) values (79,'Bread - Flat Bread',127);
insert into ProductType (typeID, typeName, Units) values (80,"Split Peas - Green, Dry",160);

insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (8, 3, 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.', 1, 15, 2);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (410, 6, 'In quis justo.', 2, 14, 4);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (47, 8, 'Nulla tellus.', 3, 13, 6);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (360, 7, 'Mauris sit amet eros.', 4, 12, 8);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (414, 5, 'In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy.', 5, 11, 10);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (467, 5, 'In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem.', 6, 10, 12);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (487, 10, 'Maecenas ut massa quis augue luctus tincidunt.', 7, 9, 14);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (51, 2, 'Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh.', 8, 8, 15);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (107, 7, 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', 9, 7, 13);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (38, 5, 'Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus.', 10, 6, 11);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (470, 5, 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam.', 11, 5, 9);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (196, 8, 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.', 12, 4, 7);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (361, 3, 'Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat.', 13, 3, 5);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (82, 10, 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', 14, 2, 3);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (227, 6, 'Aliquam erat volutpat. In congue.', 15, 1, 1);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (29725,54,'wkFfWdQKMMOR95T6okocElE60asHRoIjvFZNoWY',16,18,30);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (27907,9,'ihCnJmerk98E5B2vd13W68qPVSnObOWOkZYehcuk',17,30,6);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (88034,10,'beTC7w1h6D7xx8zV6Yg8lzRlgyYAB7M2AtIV7CZW',18,12,28);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (67156,5,'BisfgIE3o4pfKNWXZsC7Mnt6uar03KCB5Fkk2nDE',19,9,15);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (67335,49,'JIxkx9ELGe2ApsWt1roZtlVKGkYfFLffVTR7I02',20,21,19);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (75983,9,'YPsG3XFUX0UTKLGIIwuX7PB0fZP1t1L6KD2yVdLT',21,13,1);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (28169,10,'QKvvco93r3b4sdmLtRRTXfXctc0SGz2tKVJ4RMNZ',22,5,3);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (27523,4,'MFFwsJlB9Xala6pfnWcPPrAyF5cIOVCsgSMYHLqz',23,16,28);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (60880,10,'YF66SOv14vAkzrsiLeQL4pr0aMgD5kZ8Tk9uekK6',24,23,24);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (20676,4,'eCo4gp3DfpXysPlNQP6phtwlIbANhuTjrDMRXeaD',25,25,21);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (23183,3,'MPUthuC0gyoarA81BbiH6WeCSX2niSKjL39lbPbE',26,30,21);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (61513,104,'gS1DPeFSDs7MOFJgVCBcXyrmH1nzDdXCMrC8rnC',27,19,26);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (82164,4,'KMGTUhrYt9SnKpb73g9sZySjF1zByevbfaCEzSxV',28,14,30);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (37421,8,'YoLsqR7Uf9UvfH5kuinZInJFhs1RWyWZ3662nWGr',29,24,10);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (86388,4,'oKqYf3AEJ4JrfK7ewltmHKmzkOsFqD4pn4iOgrwV',30,10,28);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (81898,10,'jjq5a6XcRiAzRvMC1PACS1LZX5lDQTW5o0G27G7r',31,22,27);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (10762,30,'ZkU4aSgePIdYHUOntlK1MbKR4VMZfCQtE6nvago',32,9,19);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (68489,7,'ireq8V6zkx4eUVAPwH5f2la40TECcF7IC9el2LOo',33,20,3);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (85504,4,'KrMqPUBBJ2yjy0gtcFs6i3zP7gcRCHfrk1Wb2Za0',34,24,27);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (28134,4,'Vveph5kNv2PaMWcvRYva9KbYzRIT6XRALjYP20fe',35,19,4);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (46289,6,'GIWIQK7OyBA5DyJ8EmJbTJ0rsp2A1z14CD6jP7HC',36,4,16);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (13741,10,'Fg3CyZ0MNcESlKXLwUE70wVLMbFC0Y4kUiu6mfb8',37,18,13);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (53060,72,'clERMOCq77jY4Pm2PLycvRhTH5sxLPCwU1C6DGh',38,2,25);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (42270,30,'MlbxVkWNfChyEKj6nxCueLMRcgILXPi5bvEhHYu',39,23,27);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (11171,1,'Ha3sFrhgT4oDGwlhtymdpcxkbHQfhMGPHwJJR6wO',40,10,3);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (53019,2,'IWr0TqfCxxYJWWcGGHwjECWPbX7bQRTbj9KjDtZK',41,3,2);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (89029,7,'BzLxXZqveIjQzYkDsUk7LH53SC2tJOEEWmEW66xO',42,14,24);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (54541,1,'a35ifMZJGvQxdc2MQ5XKIjMCv8pRFKz6mPt18A3U',43,4,5);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (52111,3,'L1V3gc7G8vEUZM18jOrAHR7reECSeNyWmvLXg4PF',44,7,2);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (46480,40,'SVjIaX5n34Munmd074T6eFMRFFLtNXqPJLfZUS2',45,16,22);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (82116,5,'xB75Jxz8PsIRjEvqCHzbPRf6adgK4SCTaGqHEprW',46,11,9);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (91911,7,'YNAhOIR5Xz70hnSrHd8kJ7NPWomZqZlGAOBxraho',47,11,23);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (81951,10,'MDruBUOiqd6lmvdEtOkMmoJBONMttk2yLE6wrwIG',48,9,19);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (61871,7,'HN4NJOL6ZJQhm7JNVfiej2HEtz7vDZ2RGGOiCnZb',49,9,21);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (32526,1,'KEKEWoocZc5PmHmCuQciK1uQjmoyH6GhLiMo0flA',50,16,7);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (34901,6,'Bl4cpG8jJCOncSMBRxn6UPAfScWZvURfVuJosN4C',51,17,21);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (68058,8,'kvOyfSUrOXHoaxsdUlbkkUdRDvnJQfvtzvkJZb0D',52,27,15);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (51801,1,'C1kx8qhbV8HPLgswmAhjqvPGP8ORp2qy9XLIq3on',53,18,20);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (40558,4,'hy17l2HW9WLkLNNyMNid6H4C1a8sxWqQUDwT9X8Z',54,27,8);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (13691,34,'tn8L5zvMosMz8XqVThWHIYDv35JiLPSmQgEzGlR',55,17,28);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (30909,9,'NlmnWf204Xqkp4enwWiWSgiS6xnQVutdJtmWPosT',56,26,4);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (30212,5,'c6a1ltVRJlEWVgPhpmNhlYYgVuWtdoYLiA5VISiq',57,17,2);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (84078,107,'gDFIxIeKlgzzEIrkpkDhYOlw8PawgZnfkScHwwU',58,3,29);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (45459,2,'UPkUHIU9wfPi4HzmI8F8wBXK4dM87nPirCBc9Y5H',59,14,21);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (48623,8,'t76OfHhJrW2giebbMJpiYrLLOP9M0SWRLM22io4W',60,12,27);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (53887,5,'CENfyHL45cOXK6jEo4I3WRY8W48QLQtf5423XCvc',61,4,27);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (56620,1,'qCnYEWir8XfqbFtLHeSYXfqaM6Gg0IbFT0V15kRl',62,3,11);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (11645,6,'yKKtgPtXjJUY74ngJFGeEHqvKAlWjD2ReIeXgciV',63,17,22);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (51808,10,'xtDa6iPDSEjWVSS3GfEQS4edvsvKKKkkHJEBcddH',64,19,26);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (93912,7,'fHcbmvFc90mjHe9NPSLqktdfGqrrp0z2vn9llV3L',65,15,25);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (15884,1,'i9c4fUgh44BEN0wgV86nkDjLYwnDYN7ycMUIxj2x',66,12,15);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (47082,10,'REtc0M0QSgPjqPOY4Rknr3dua1YOdRGWtZJ4R6LX',67,30,11);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (45907,7,'axlfqvHc64wL5j8MC7eVBUJ94QRgZKRZ8iQCQmfY',68,3,4);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (87907,14,'JQ1g8z0hzN6mpdsAMEkZL4LU6rdrcQbtLWEnLJK',69,28,5);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (17349,6,'CEkmIKO3NxISlBzn0yk8wVO0gDuBhfw0eXqlgbzV',70,16,7);
insert into Review (reviewID, Rating, Description, orderID, employeeID, consumerID) values (93325,10,'JAL9qQa5sHocd1BdeP35LBKqpcr3LhJwsCbd8L4a',71,25,28);

insert into StoreManager (managerID, lastName, firstName) values (178, 'Jillions', 'Quintilla');
insert into StoreManager (managerID, lastName, firstName) values (284, 'Fillis', 'Redd');
insert into StoreManager (managerID, lastName, firstName) values (179, 'Shallow', 'Evyn');
insert into StoreManager (managerID, lastName, firstName) values (446, 'Borrott', 'Leta');
insert into StoreManager (managerID, lastName, firstName) values (263, 'Kyncl', 'Virgil');
insert into StoreManager (managerID, lastName, firstName) values (243, 'Casewell', 'Laverna');
insert into StoreManager (managerID, lastName, firstName) values (211, 'Bennit', 'Sibyl');
insert into StoreManager (managerID, lastName, firstName) values (201, 'Iwanczyk', 'Daron');
insert into StoreManager (managerID, lastName, firstName) values (331, 'Bamber', 'Tulley');
insert into StoreManager (managerID, lastName, firstName) values (159, 'Tomala', 'Ad');
insert into StoreManager (managerID, lastName, firstName) values (36, 'Ohms', 'Deeann');
insert into StoreManager (managerID, lastName, firstName) values (293, 'Mackneis', 'Saleem');
insert into StoreManager (managerID, lastName, firstName) values (355, 'Pruvost', 'Elwood');
insert into StoreManager (managerID, lastName, firstName) values (316, 'Feldhuhn', 'Marty');
insert into StoreManager (managerID, lastName, firstName) values (91, 'Gras', 'Abe');
insert into StoreManager (managerID, lastName, firstName) values (1,'Drusilla','Sappson');
insert into StoreManager (managerID, lastName, firstName) values (2,'Winslow','Allonby');
insert into StoreManager (managerID, lastName, firstName) values (3,'Adler','Feavyour');
insert into StoreManager (managerID, lastName, firstName) values (4,'De','Martino');
insert into StoreManager (managerID, lastName, firstName) values (5,'Dory','Battman');
insert into StoreManager (managerID, lastName, firstName) values (6,'Cyndie','Burnand');
insert into StoreManager (managerID, lastName, firstName) values (7,'Isa','Gravener');
insert into StoreManager (managerID, lastName, firstName) values (8,'Jaclyn','MacGill');
insert into StoreManager (managerID, lastName, firstName) values (9,'Corry','Lodder');
insert into StoreManager (managerID, lastName, firstName) values (10,'Ranna','Heggie');
insert into StoreManager (managerID, lastName, firstName) values (11,'Marnia','Chattey');
insert into StoreManager (managerID, lastName, firstName) values (12,'Alexandros','Adamovsky');
insert into StoreManager (managerID, lastName, firstName) values (13,'Hally','Manilo');
insert into StoreManager (managerID, lastName, firstName) values (14,'Eddie','Nansom');
insert into StoreManager (managerID, lastName, firstName) values (15,'Eamon','Flatt');
insert into StoreManager (managerID, lastName, firstName) values (16,'Dody','Petersen');
insert into StoreManager (managerID, lastName, firstName) values (17,'Wallie','Horche');
insert into StoreManager (managerID, lastName, firstName) values (18,'Juliane','Doggett');
insert into StoreManager (managerID, lastName, firstName) values (19,'Cheri','Coggill');
insert into StoreManager (managerID, lastName, firstName) values (20,'Benny','Walster');
insert into StoreManager (managerID, lastName, firstName) values (21,'Alford','Orris');
insert into StoreManager (managerID, lastName, firstName) values (22,'Novelia','De Maine');
insert into StoreManager (managerID, lastName, firstName) values (23,'Konstanze','Simoncini');
insert into StoreManager (managerID, lastName, firstName) values (24,'Dosi','Knellen');
insert into StoreManager (managerID, lastName, firstName) values (25,'Norbert','Muzzollo');
insert into StoreManager (managerID, lastName, firstName) values (26,'Nealy','Life');
insert into StoreManager (managerID, lastName, firstName) values (27,'Viole','Mustill');
insert into StoreManager (managerID, lastName, firstName) values (28,'Euell','Shevill');
insert into StoreManager (managerID, lastName, firstName) values (29,'Alfy','Picker');
insert into StoreManager (managerID, lastName, firstName) values (30,'Ginelle','Cornehl');

insert into Store (storeID, Name, Street, City, State, Country, Zip, managerID) values (261, 'Kaymbo', '3 Doe Crossing Lane', 'Tyler', 'Texas', 'United States', '75799', 178);
insert into Store (storeID, Name, Street, City, State, Country, Zip, managerID) values (325, 'Linktype', '07869 Donald Place', 'Port Washington', 'New York', 'United States', '11054', 284);
insert into Store (storeID, Name, Street, City, State, Country, Zip, managerID) values (445, 'Divape', '296 Del Mar Center', 'Bronx', 'New York', 'United States', '10469', 179);
insert into Store (storeID, Name, Street, City, State, Country, Zip, managerID) values (418, 'Vipe', '64650 Moulton Junction', 'Boston', 'Massachusetts', 'United States', '02119', 446);
insert into Store (storeID, Name, Street, City, State, Country, Zip, managerID) values (151, 'Jetpulse', '36233 Gateway Road', 'New York City', 'New York', 'United States', '10024', 263);
insert into Store (storeID, Name, Street, City, State, Country, Zip, managerID) values (409, 'Feedfire', '3 Meadow Vale Street', 'Cleveland', 'Ohio', 'United States', '44111', 243);
insert into Store (storeID, Name, Street, City, State, Country, Zip, managerID) values (499, 'Quimba', '12 Troy Trail', 'Newark', 'Delaware', 'United States', '19725', 211);
insert into Store (storeID, Name, Street, City, State, Country, Zip, managerID) values (336, 'Linkbridge', '5568 Graceland Avenue', 'Youngstown', 'Ohio', 'United States', '44511', 201);
insert into Store (storeID, Name, Street, City, State, Country, Zip, managerID) values (315, 'Rhynyx', '2 Loeprich Circle', 'Dayton', 'Ohio', 'United States', '45490', 331);
insert into Store (storeID, Name, Street, City, State, Country, Zip, managerID) values (490, 'Omba', '01 Prairieview Drive', 'Chicago', 'Illinois', 'United States', '60657', 159);
insert into Store (storeID, Name, Street, City, State, Country, Zip, managerID) values (334, 'Shufflester', '4 Carpenter Circle', 'Charleston', 'West Virginia', 'United States', '25331', 36);
insert into Store (storeID, Name, Street, City, State, Country, Zip, managerID) values (447, 'Skinix', '629 Hovde Avenue', 'Las Vegas', 'Nevada', 'United States', '89160', 293);
insert into Store (storeID, Name, Street, City, State, Country, Zip, managerID) values (122, 'Gevee', '3604 Coleman Point', 'New York City', 'New York', 'United States', '10004', 355);
insert into Store (storeID, Name, Street, City, State, Country, Zip, managerID) values (272, 'Skyba', '71 Muir Trail', 'Homestead', 'Florida', 'United States', '33034', 316);
insert into Store (storeID, Name, Street, City, State, Country, Zip, managerID) values (318, 'Quatz', '076 Amoth Hill', 'New York City', 'New York', 'United States', '10160', 91);
insert into Store (storeID, Name, Street, City, State, Country, Zip, managerID) values (1,'Collins-Ortiz','529 Vernon Hill','New Orleans','Louisiana','United States',63117,1);
insert into Store (storeID, Name, Street, City, State, Country, Zip, managerID) values (2,'Pollich Inc','419 Pawling Way','Glendale','California','United States',86468,2);
insert into Store (storeID, Name, Street, City, State, Country, Zip, managerID) values (3,"Lakin, Goldner and Ortiz",'2421 Dahle Junction','Cleveland','Ohio','United States',18887,3);
insert into Store (storeID, Name, Street, City, State, Country, Zip, managerID) values (4,"Hermiston, Weber and Klein",'326 Shopko Alley','Memphis','Tennessee','United States',29633,4);
insert into Store (storeID, Name, Street, City, State, Country, Zip, managerID) values (5,'Kshlerin-Oberbrunner','4572 Autumn Leaf Plaza','San Diego','California','United States',37378,5);
insert into Store (storeID, Name, Street, City, State, Country, Zip, managerID) values (6,"Littel, Lindgren and Farrell",'8 Loftsgordon Way','Los Angeles','California','United States',84306,6);
insert into Store (storeID, Name, Street, City, State, Country, Zip, managerID) values (7,"Reinger, Collier and Ondricka",'3 Melrose Street','Charleston','West Virginia','United States',04846,7);
insert into Store (storeID, Name, Street, City, State, Country, Zip, managerID) values (8,"Pfannerstill, McDermott and McCullough",'123 Weeping Birch Way','Philadelphia','Pennsylvania','United States',57837,8);
insert into Store (storeID, Name, Street, City, State, Country, Zip, managerID) values (9,'Crist-Ritchie','48600 Independence Lane','North Little Rock','Arkansas','United States',79476,9);
insert into Store (storeID, Name, Street, City, State, Country, Zip, managerID) values (10,'Hauck Group','666 Westridge Circle','Boise','Idaho','United States',50539,10);
insert into Store (storeID, Name, Street, City, State, Country, Zip, managerID) values (11,"Nitzsche, Schmidt and Waelchi",'583 Mosinee Crossing','Denver','Colorado','United States',63031,11);
insert into Store (storeID, Name, Street, City, State, Country, Zip, managerID) values (12,'Bogan LLC','916 Autumn Leaf Trail','Bakersfield','California','United States',29341,12);
insert into Store (storeID, Name, Street, City, State, Country, Zip, managerID) values (13,'Jacobs-Bartoletti','332 Reinke Crossing','New York City','New York','United States',78867,13);
insert into Store (storeID, Name, Street, City, State, Country, Zip, managerID) values (14,'Abshire-Wisozk','649 Katie Lane','Bethesda','Maryland','United States',89090,14);
insert into Store (storeID, Name, Street, City, State, Country, Zip, managerID) values (15,'Beahan-Durgan','02886 Thierer Drive','Austin','Texas','United States',67488,15);

insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (5, 'Topical 60 Sec Sodium Fluoride', 671, 15, 1, 261);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (40, 'Bio Cherry Plum', 722, 14, 2, 325);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (93, 'ONDANSETRON HYDROCHLORIDE', 842, 13, 3, 445);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (58, 'kirkland signature aller fex', 241, 12, 4, 418);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (88, 'CENTER-AL - HOUSE DUST', 632, 11, 5, 151);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (89, 'Diclofenac Sodium', 142, 10, 6, 409);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (85, 'Virus 2000', 260, 9, 7, 499);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (24, 'Spironolactone and Hydrochlorothiazide', 222, 8, 8, 336);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (97, 'PureLife APF', 427, 7, 9, 315);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (17, 'Trihexyphenidyl Hydrochloride', 804, 6, 10, 490);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (92, 'Otic Care Antipyrine and Benzocaine', 59, 5, 11, 334);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (3, 'good sense pain reliefchildrens', 927, 4, 12, 447);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (41, 'OXYGEN', 746, 3, 13, 122);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (94, 'Dobutamine Hydrochloride in Dextrose', 164, 2, 14, 272);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (48, 'CeraVe', 102, 1, 15, 318);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (10,'METHYLPREDNISOLONE',500,44,49,9);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (11,'Accupril',223,6,12,13);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (12,'Fentanyl Citrate',116,39,24,10);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (13,'Jantoven',357,28,40,4);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (14,'SHISEIDO PURENESS MATIFYING COMPACT OIL-FREE (REFILL)',221,23,30,5);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (15,'Levothyroxine Sodium',153,42,12,9);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (16,'Potassium Chloride in Dextrose and Sodium Chloride',146,2,36,11);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (18,'Quinapril',333,36,11,9);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (19,'ULMUS AMERICANA POLLEN',449,42,37,5);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (20,'Treatment Set TS348467',323,20,31,4);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (21,'OUHI CELL POWER NO 1 ESSENCE',230,8,43,3);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (22,'Metformin Hydrochloride',186,20,21,2);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (23,'LYSODREN',243,7,35,3);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (25,'Leg Cramps - Swelling',132,12,41,12);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (26,'risedronate sodium',53,19,21,6);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (27,'Dapsone',173,48,36,12);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (28,'Up and UP Sensitive Toothpaste Enamel Strengthening formula plus whitening',448,8,15,10);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (29,'Baclofen',389,35,31,12);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (30,'Ear Inflammation Plus',170,42,48,5);

insert into Rating (ratingID, Description, Stars, ProductID) values (97, 'Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor.', 4, 5);
insert into Rating (ratingID, Description, Stars, ProductID) values (480, 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl.', 2, 40);
insert into Rating (ratingID, Description, Stars, ProductID) values (329, 'Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia.', 3, 93);
insert into Rating (ratingID, Description, Stars, ProductID) values (320, 'Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus.', 3, 58);
insert into Rating (ratingID, Description, Stars, ProductID) values (420, 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis.', 3, 88);
insert into Rating (ratingID, Description, Stars, ProductID) values (172, 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis.', 1, 89);
insert into Rating (ratingID, Description, Stars, ProductID) values (490, 'Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.', 5, 85);
insert into Rating (ratingID, Description, Stars, ProductID) values (477, 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis.', 1, 24);
insert into Rating (ratingID, Description, Stars, ProductID) values (144, 'Sed accumsan felis.', 3, 97);
insert into Rating (ratingID, Description, Stars, ProductID) values (442, 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', 3, 17);
insert into Rating (ratingID, Description, Stars, ProductID) values (29, 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.', 2, 92);
insert into Rating (ratingID, Description, Stars, ProductID) values (341, 'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.', 4, 3);
insert into Rating (ratingID, Description, Stars, ProductID) values (183, 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem.', 4, 41);
insert into Rating (ratingID, Description, Stars, ProductID) values (489, 'Donec ut mauris eget massa tempor convallis.', 5, 94);
insert into Rating (ratingID, Description, Stars, ProductID) values (465, 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue.', 2, 48);
insert into Rating (ratingID, Description, Stars, ProductID) values (1,'ONnKkYdXmUKgPGQhsWWod20X4Gotcj',6,10);
insert into Rating (ratingID, Description, Stars, ProductID) values (2,'Wv4foBvlU9yv0PN3iOFUD22OrH',6,11);
insert into Rating (ratingID, Description, Stars, ProductID) values (3,'AUWPSiHKDuiGU6osxLdREGoAOZz22k',6,12);
insert into Rating (ratingID, Description, Stars, ProductID) values (4,'siVs3n75lPj4Nv9PixjZ5tGmGfjCoD',10,13);
insert into Rating (ratingID, Description, Stars, ProductID) values (5,'WvmJ7X6sWwZ5czkgHyFfQuGzVx9F4E',7,14);
insert into Rating (ratingID, Description, Stars, ProductID) values (6,'p01zIonjNog4oRiSygB18dXIb7ojHC',6,15);
insert into Rating (ratingID, Description, Stars, ProductID) values (7,'FtesNtTd6cfydk6uUxxoDRqE5lbEP8',7,16);
insert into Rating (ratingID, Description, Stars, ProductID) values (9,'RvZP33ZeX2DudgvQItGTJE4IOYMP5',10,18);
insert into Rating (ratingID, Description, Stars, ProductID) values (10,'iYETFgBM8gEhVRsZDFqowm4N5agQWA',7,19);
insert into Rating (ratingID, Description, Stars, ProductID) values (11,'QFKt3PdGHk8K3yXtsDV1Pa6YboHapN',6,20);
insert into Rating (ratingID, Description, Stars, ProductID) values (12,'DOT0D0hXkUyl4TzJPmeJKgQnyQYtWU',7,21);
insert into Rating (ratingID, Description, Stars, ProductID) values (13,'ITLef9OBkxjH8XIvzfS3MukyNT5mBI',4,22);
insert into Rating (ratingID, Description, Stars, ProductID) values (14,'up4rYQGGKkVQjnz9PnRBsZl0XZHG8l',5,23);
insert into Rating (ratingID, Description, Stars, ProductID) values (16,'KHp0bQtPJwkhstbisQctzB7bwTa3MI',5,25);
insert into Rating (ratingID, Description, Stars, ProductID) values (17,'jGLD46DftT1lJ1MFR0Vn0InsOEPM',9,26);
insert into Rating (ratingID, Description, Stars, ProductID) values (18,'T9Oppuy39LvxQAQ2BvCuHzk5Vzw4yI',8,27);
insert into Rating (ratingID, Description, Stars, ProductID) values (19,'QqRFYQH7ofXg7pg6HJA1mgL5SShlQU',6,28);
insert into Rating (ratingID, Description, Stars, ProductID) values (20,'pHGvvWchWf4jQVetaniXznmLalsP7Y',9,29);

insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (413, 'Gigaclub', '921 Ohio Lane', 'Tucson', 'Arizona', 'United States', 85715);
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (191, 'Jetpulse', '1 Fairview Parkway', 'Washington', 'District of Columbia', 'United States', 20591);
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (481, 'Zava', '6230 Heffernan Parkway', 'Charlotte', 'North Carolina', 'United States', 28278);
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (290, 'Avaveo', '8166 Montana Circle', 'Chicago', 'Illinois', 'United States', 60624);
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (12, 'Voomm', '77033 Coolidge Road', 'Dayton', 'Ohio', 'United States', 45414);
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (430, 'Wikivu', '288 Monterey Trail', 'Midland', 'Texas', 'United States', 79710);
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (90, 'Linktype', '00 Heath Park', 'Seminole', 'Florida', 'United States', 34642);
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (461, 'Gigabox', '71922 Fallview Junction', 'Saint Petersburg', 'Florida', 'United States', 33742);
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (423, 'Ooba', '2 Brentwood Parkway', 'Sacramento', 'California', 'United States', 95833);
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (307, 'Kare', '7 Fallview Plaza', 'Denton', 'Texas', 'United States', 76205);
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (446, 'Bluejam', '254 Fremont Park', 'Sacramento', 'California', 'United States', 94297);
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (395, 'Voomm', '9 Little Fleur Lane', 'Hot Springs National Park', 'Arkansas', 'United States', 71914);
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (70, 'Babbleset', '7 3rd Crossing', 'Glendale', 'Arizona', 'United States', 85311);
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (201, 'Youbridge', '30 Fisk Terrace', 'Birmingham', 'Alabama', 'United States', 35210);
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (63, 'Meevee', '85 Sutherland Terrace', 'Houston', 'Texas', 'United States', 77060);
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (13,'Orn-Schmeler','39 Texas Pass','Beaumont','Texas','United States',17888);
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (14,'Kunde-Renner','17652 Superior Crossing','Camden','New Jersey','United States',43749);
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (15,"Rohan, Runolfsson and McKenzie",'687 Eastlawn Lane','Springfield','Illinois','United States',86152);
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (16,'Zboncak Group','9 Basil Terrace','Los Angeles','California','United States',89149);
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (17,'Hyatt-Lowe','531 Lighthouse Bay Crossing','El Paso','Texas','United States',28294);
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (18,'Casper Group','8373 Mayer Lane','Humble','Texas','United States',51698);
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (19,'Mohr-Sipes','2638 Kings Lane','Houston','Texas','United States',59789);
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (20,'Little and Sons','6360 Michigan Junction','Wilmington','Delaware','United States',10403);
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (21,"Ondricka, Stiedemann and Boyer",'5347 Lakeland Park','Colorado Springs','Colorado','United States',26195);
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (22,'Roob Inc','15 Luster Junction','Lexington','Kentucky','United States',64811);
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (23,'Toy-Steuber','16 Clemons Court','New York City','New York','United States',95723);
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (24,"Conroy, Lowe and Glover",'8253 Sauthoff Road','Charleston','West Virginia','United States',73313);
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (25,"Johns, Bechtelar and Nienow",'08 Utah Hill','Dallas','Texas','United States',72934);
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (26,'Daugherty-Hagenes','03345 Cascade Drive','Huntington','West Virginia','United States',42450);
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (27,"Zulauf, Kilback and Herman",'21 Arizona Park','Bakersfield','California','United States',29099);
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (28,'Rolfson LLC','9 Michigan Junction','Saginaw','Michigan','United States',69174);
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (29,'Quitzon and Sons','404 Utah Drive','Warren','Ohio','United States',77413);
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (30,'Morissette-Frami','38 Graceland Hill','Conroe','Texas','United States',49555);

insert into StoreSupplier (storeID, supplierID, supplydate) values (261, 413, '2020-03-10');
insert into StoreSupplier (storeID, supplierID, supplydate) values (325, 191, '2020-07-29');
insert into StoreSupplier (storeID, supplierID, supplydate) values (445, 481, '2022-07-11');
insert into StoreSupplier (storeID, supplierID, supplydate) values (418, 290, '2021-01-23');
insert into StoreSupplier (storeID, supplierID, supplydate) values (151, 12, '2019-09-27');
insert into StoreSupplier (storeID, supplierID, supplydate) values (409, 430, '2021-05-14');
insert into StoreSupplier (storeID, supplierID, supplydate) values (499, 90, '2021-09-04');
insert into StoreSupplier (storeID, supplierID, supplydate) values (336, 461, '2022-07-28');
insert into StoreSupplier (storeID, supplierID, supplydate) values (315, 423, '2022-11-02');
insert into StoreSupplier (storeID, supplierID, supplydate) values (490, 307, '2020-03-20');
insert into StoreSupplier (storeID, supplierID, supplydate) values (334, 446, '2021-08-28');
insert into StoreSupplier (storeID, supplierID, supplydate) values (447, 395, '2021-11-24');
insert into StoreSupplier (storeID, supplierID, supplydate) values (122, 70, '2022-08-13');
insert into StoreSupplier (storeID, supplierID, supplydate) values (272, 201, '2019-11-17');
insert into StoreSupplier (storeID, supplierID, supplydate) values (318, 63, '2020-04-27');
insert into StoreSupplier (storeID, supplierID, supplydate) values (5,30,'2/23/2022');
insert into StoreSupplier (storeID, supplierID, supplydate) values (10,25,'4/8/2022');
insert into StoreSupplier (storeID, supplierID, supplydate) values (5,28,'11/13/2022');
insert into StoreSupplier (storeID, supplierID, supplydate) values (14,18,'2/23/2022');
insert into StoreSupplier (storeID, supplierID, supplydate) values (11,23,'1/10/2022');
insert into StoreSupplier (storeID, supplierID, supplydate) values (9,19,'6/28/2022');
insert into StoreSupplier (storeID, supplierID, supplydate) values (10,22,'4/4/2022');
insert into StoreSupplier (storeID, supplierID, supplydate) values (10,15,'11/23/2022');
insert into StoreSupplier (storeID, supplierID, supplydate) values (14,26,'10/22/2022');
insert into StoreSupplier (storeID, supplierID, supplydate) values (1,16,'6/22/2022');
insert into StoreSupplier (storeID, supplierID, supplydate) values (13,29,'6/17/2022');
insert into StoreSupplier (storeID, supplierID, supplydate) values (8,16,'8/10/2022');
insert into StoreSupplier (storeID, supplierID, supplydate) values (2,28,'7/26/2022');
insert into StoreSupplier (storeID, supplierID, supplydate) values (9,17,'3/4/2022');
insert into StoreSupplier (storeID, supplierID, supplydate) values (13,15,'9/8/2022');
insert into StoreSupplier (storeID, supplierID, supplydate) values (12,22,'4/27/2022');
insert into StoreSupplier (storeID, supplierID, supplydate) values (2,15,'12/20/2021');
insert into StoreSupplier (storeID, supplierID, supplydate) values (13,27,'3/31/2022');
insert into StoreSupplier (storeID, supplierID, supplydate) values (4,13,'4/16/2022');
insert into StoreSupplier (storeID, supplierID, supplydate) values (10,27,'2/22/2022');
insert into StoreSupplier (storeID, supplierID, supplydate) values (15,13,'4/12/2022');
insert into StoreSupplier (storeID, supplierID, supplydate) values (8,19,'3/27/2022');
insert into StoreSupplier (storeID, supplierID, supplydate) values (14,22,'6/6/2022');
insert into StoreSupplier (storeID, supplierID, supplydate) values (4,17,'1/18/2022');
insert into StoreSupplier (storeID, supplierID, supplydate) values (8,27,'2/10/2022');
insert into StoreSupplier (storeID, supplierID, supplydate) values (1,15,'5/18/2022');
insert into StoreSupplier (storeID, supplierID, supplydate) values (9,30,'10/5/2022');