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
    employeeID      INTEGER NOT NULL UNIQUE,
    paymentNum      INTEGER NOT NULL UNIQUE,
    transactionDate DATE    NOT NULL,
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
    OrderID     INTEGER NOT NULL UNIQUE,
    TypeID      INTEGER NOT NULL UNIQUE,
    StoreID     INTEGER NOT NULL UNIQUE,
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
    StoreID    INTEGER NOT NULL UNIQUE,
    SupplierID INTEGER NOT NULL UNIQUE,
    supplyDate DATE    NOT NULL,
    FOREIGN KEY (StoreID) REFERENCES Store (StoreID),
    FOREIGN KEY (SupplierID) REFERENCES Supplier (SupplierID),
    PRIMARY KEY (StoreID, SupplierID)
);

-- sample data.
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (1, 'Cristiano', 'Boutell', 'Chicago', 'Illinois', '84 Spaight Park', '60681', 'United States', 'mastercard');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (2, 'Elianora', 'Hannam', 'Cleveland', 'Ohio', '4 Dottie Lane', '44111', 'United States', 'mastercard');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (3, 'Ricca', 'Myott', 'Canton', 'Ohio', '876 Mesta Road', '44720', 'United States', 'visa');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (4, 'Milka', 'Rhys', 'Topeka', 'Kansas', '8 Bartelt Center', '66611', 'United States', 'mastercard');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (5, 'Mikel', 'Crebbin', 'Cleveland', 'Ohio', '36014 Oriole Park', '44118', 'United States', 'mastercard');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (6, 'Ulises', 'Burress', 'Charlotte', 'North Carolina', '193 Brickson Park Crossing', '28272', 'United States', 'mastercard');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (7, 'Kelly', 'Marham', 'Saint Louis', 'Missouri', '65810 Service Lane', '63104', 'United States', 'americanexpress');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (8, 'Constancia', 'Williscroft', 'Phoenix', 'Arizona', '0247 Debra Pass', '85030', 'United States', 'mastercard');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (9, 'Antonella', 'Pearn', 'Baltimore', 'Maryland', '0 Longview Avenue', '21211', 'United States', 'americanexpress');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (10, 'Emlynne', 'Kibard', 'Roanoke', 'Virginia', '279 Bultman Terrace', '24014', 'United States', 'visa');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (11, 'Susi', 'Woller', 'Reno', 'Nevada', '97 Ludington Pass', '89510', 'United States', 'visa');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (12, 'Rozella', 'Perfitt', 'Burbank', 'California', '58287 Karstens Alley', '91520', 'United States', 'americanexpress');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (13, 'Beaufort', 'Huxton', 'Pasadena', 'California', '6259 Eliot Alley', '91103', 'United States', 'mastercard');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (14, 'Elke', 'Spittles', 'El Paso', 'Texas', '64552 Lighthouse Bay Avenue', '88546', 'United States', 'visa');
insert into Consumer (ConsumerID, firstName, lastName, City, State, Street, Zip, Country, Payment) values (15, 'Kippy', 'Kinsell', 'Atlanta', 'Georgia', '04231 Burning Wood Park', '30336', 'United States', 'visa');

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

insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (15, 6, '2021-05-27', 124.42, '5007666531281848');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (14, 35, '2022-09-10', 423.48, '4017959477916100');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (13, 92, '2020-07-14', 304.64, '5002352830292415');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (12, 15, '2021-08-07', 10.78, '4041375576360');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (11, 36, '2021-08-16', 147.01, '4041593225584');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (10, 95, '2021-08-09', 454.74, '337941468187140');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (9, 14, '2022-07-24', 119.91, '374288850079467');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (8, 47, '2021-08-24', 294.44, '4041373872769181');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (7, 59, '2020-10-04', 276.87, '4041596512599028');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (6, 77, '2022-01-17', 231.58, '337941653468941');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (5, 56, '2022-07-27', 226.57, '337941723779970');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (4, 1, '2020-10-18', 205.86, '4017958554388');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (3, 85, '2021-06-16', 313.1, '4041594881998368');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (2, 72, '2022-06-08', 337.44, '4041371237314');
insert into Payment (employeeID, paymentNum, transactionDate, transactionAmt, accountNum) values (1, 61, '2021-05-30', 388.7, '4727319465732');

insert into ProductType (typeID, typeName, Units) values (2, 'Wild Guave', 16.52);
insert into ProductType (typeID, typeName, Units) values (19, 'Robust Spineflower', 43.21);
insert into ProductType (typeID, typeName, Units) values (4, 'Eve''s Necklacepod', 30.26);
insert into ProductType (typeID, typeName, Units) values (26, 'Foothill Flatsedge', 17.52);
insert into ProductType (typeID, typeName, Units) values (5, 'Inland Sedge', 28.5);
insert into ProductType (typeID, typeName, Units) values (23, 'Obedient Plant', 45.66);
insert into ProductType (typeID, typeName, Units) values (13, 'Northern Moonwort', 22.7);
insert into ProductType (typeID, typeName, Units) values (7, 'Trematodon Moss', 6.64);
insert into ProductType (typeID, typeName, Units) values (27, 'Stokesia', 10.16);
insert into ProductType (typeID, typeName, Units) values (28, 'Sacred Bamboo', 25.38);
insert into ProductType (typeID, typeName, Units) values (39, 'Lemon Saptree', 27.32);
insert into ProductType (typeID, typeName, Units) values (43, 'Slender Cinquefoil', 23.11);
insert into ProductType (typeID, typeName, Units) values (11, 'Pinkroot', 35.89);
insert into ProductType (typeID, typeName, Units) values (15, 'Thurber''s Penstemon', 38.43);
insert into ProductType (typeID, typeName, Units) values (12, 'Bloody Geranium', 8.68);


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

insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (5, 'Topical 60 Sec Sodium Fluoride', 671, 15, 2, 261);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (40, 'Bio Cherry Plum', 722, 14, 19, 325);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (93, 'ONDANSETRON HYDROCHLORIDE', 842, 13, 4, 445);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (58, 'kirkland signature aller fex', 241, 12, 26, 418);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (88, 'CENTER-AL - HOUSE DUST', 632, 11, 5, 151);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (89, 'Diclofenac Sodium', 142, 10, 23, 409);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (85, 'Virus 2000', 260, 9, 13, 499);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (24, 'Spironolactone and Hydrochlorothiazide', 222, 8, 7, 336);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (97, 'PureLife APF', 427, 7, 27, 315);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (17, 'Trihexyphenidyl Hydrochloride', 804, 6, 28, 490);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (92, 'Otic Care Antipyrine and Benzocaine', 59, 5, 39, 334);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (3, 'good sense pain reliefchildrens', 927, 4, 43, 447);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (41, 'OXYGEN', 746, 3, 11, 122);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (94, 'Dobutamine Hydrochloride in Dextrose', 164, 2, 15, 272);
insert into Product (productID, productName, stock, orderID, TypeID, StoreID) values (48, 'CeraVe', 102, 1, 12, 318);

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


insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (413, 'Gigaclub', '921 Ohio Lane', 'Tucson', 'Arizona', 'United States', '85715');
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (191, 'Jetpulse', '1 Fairview Parkway', 'Washington', 'District of Columbia', 'United States', '20591');
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (481, 'Zava', '6230 Heffernan Parkway', 'Charlotte', 'North Carolina', 'United States', '28278');
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (290, 'Avaveo', '8166 Montana Circle', 'Chicago', 'Illinois', 'United States', '60624');
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (12, 'Voomm', '77033 Coolidge Road', 'Dayton', 'Ohio', 'United States', '45414');
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (430, 'Wikivu', '288 Monterey Trail', 'Midland', 'Texas', 'United States', '79710');
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (90, 'Linktype', '00 Heath Park', 'Seminole', 'Florida', 'United States', '34642');
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (461, 'Gigabox', '71922 Fallview Junction', 'Saint Petersburg', 'Florida', 'United States', '33742');
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (423, 'Ooba', '2 Brentwood Parkway', 'Sacramento', 'California', 'United States', '95833');
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (307, 'Kare', '7 Fallview Plaza', 'Denton', 'Texas', 'United States', '76205');
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (446, 'Bluejam', '254 Fremont Park', 'Sacramento', 'California', 'United States', '94297');
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (395, 'Voomm', '9 Little Fleur Lane', 'Hot Springs National Park', 'Arkansas', 'United States', '71914');
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (70, 'Babbleset', '7 3rd Crossing', 'Glendale', 'Arizona', 'United States', '85311');
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (201, 'Youbridge', '30 Fisk Terrace', 'Birmingham', 'Alabama', 'United States', '35210');
insert into Supplier (supplierID, Name, Street, City, State, Country, Zip) values (63, 'Meevee', '85 Sutherland Terrace', 'Houston', 'Texas', 'United States', '77060');

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