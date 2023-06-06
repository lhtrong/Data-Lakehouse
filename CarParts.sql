-- Clean the database
DROP TABLE IF EXISTS Part_in_Order;
DROP TABLE IF EXISTS Supplier;
DROP TABLE IF EXISTS Brand;
DROP TABLE IF EXISTS Part;
DROP TABLE IF EXISTS Part_for_Car;
DROP TABLE IF EXISTS Part_Supplier;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Customer_Statut;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Car_Manufacturer;
DROP TABLE IF EXISTS Car;
DROP TABLE IF EXISTS Part_Maker;

-- Create the Schema
CREATE TABLE IF NOT EXISTS Customer_Statut(
            statut_id INT NOT NULL PRIMARY KEY,
            statut VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Customer(
            customer_id INT NOT NULL PRIMARY KEY,
            statut_id INT NOT NULL,
            individual_or_organization VARCHAR(50) NOT NULL,
            organisation_name varchar(50),
            individual_first_name varchar(50),
            individual_last_name VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Orders(
            order_id INT NOT NULL PRIMARY KEY,
            customer_id INT NOT NULL,
            amount_due INT NOT NULL
            );
         
CREATE TABLE IF NOT EXISTS Car_Manufacturer(
            car_manufacturer_id INT NOT NULL PRIMARY KEY,
            name VARCHAR(50) NOT NULL
            );
           
CREATE TABLE IF NOT EXISTS Car(
            car_id INT NOT NULL PRIMARY KEY,
            car_manufacturer_id INT NOT NULL,
            date_of_manufacture DATE NOT NULL,
            model VARCHAR(50) NOT NULL
            );
           
CREATE TABLE IF NOT EXISTS Supplier(
            supplier_id INT NOT NULL PRIMARY KEY,
            name VARCHAR(50) NOT NULL,
            street_address VARCHAR(50) NOT NULL,
            town VARCHAR(50) NOT NULL,
            country VARCHAR(50) NOT NULL,
            postcode INT NOT NULL,
            phone VARCHAR(50) NOT NULL
);
           
CREATE TABLE IF NOT EXISTS Brand(
            brand_id INT NOT NULL PRIMARY KEY,
            name VARCHAR(50) NOT NULL
);
           
CREATE TABLE IF NOT EXISTS Part_Maker(
            part_maker_id INT NOT NULL PRIMARY KEY,
            name VARCHAR(50) NOT NULL
);
           
CREATE TABLE IF NOT EXISTS Part(
        part_id INT NOT NULL PRIMARY KEY,
        brand_id INT NOT NULL,
        supplier_id INT NOT NULL,
        part_group_id INT NOT NULL,
        part_maker_id INT NOT NULL,
        part_name VARCHAR(50) NOT NULL,
        main_supplier_name VARCHAR(50) NOT NULL,
        price_to_us INT NOT NULL,
        price_to_customer INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Part_for_Car(
            car_id INT NOT NULL,
            part_id INT NOT NULL
);
           
CREATE TABLE IF NOT EXISTS Part_Supplier(
        part_supplier_id INT NOT NULL PRIMARY KEY,
        part_id INT NOT NULL,
        supplier_id INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Part_in_Order(
            part_in_order_id INT NOT NULL,
            order_id INT NOT NULL,
            part_supplier_id INT NOT NULL,
            actual_sale_price INT NOT NULL,
            quantity INT NOT NULL
);

INSERT INTO Customer_Statut(statut_id, statut) VALUES
(1, 'Regular'),
(2, 'VIP'),
(3, 'Premium');

INSERT INTO Customer(customer_id, statut_id, individual_or_organization, organisation_name, individual_first_name, individual_last_name) VALUES
(1, 1, 'individual', NULL, 'John', 'Doe'),
(2, 2, 'individual', NULL, 'Jane', 'Smith'),
(3, 3, 'organization', 'ACME Inc.', NULL, NULL),
(4, 1, 'organization', 'XYZ Corp.', NULL, NULL);

INSERT INTO Orders(order_id, customer_id, amount_due) VALUES
(1, 1, 100),
(2, 2, 500),
(3, 3, 1000);

INSERT INTO Car_Manufacturer(car_manufacturer_id, name) VALUES
(1, 'Toyota'),
(2, 'Ford'),
(3, 'Honda');

INSERT INTO Car(car_id, car_manufacturer_id, date_of_manufacture, model) VALUES
(1, 1, '2020-01-01', 'Camry'),
(2, 2, '2019-05-01', 'Mustang'),
(3, 3, '2021-03-01', 'Accord');

INSERT INTO Supplier(supplier_id, name, street_address, town, country, postcode, phone) VALUES
(1, 'ABC Parts', '123 Main St', 'Anytown', 'USA', '12345', '555-1234'),
(2, 'XYZ Supplies', '456 Elm St', 'Othertown', 'USA', '67890', '555-5678'),
(3, '123 Auto Parts', '789 Oak St', 'Sometown', 'USA', '54321', '555-4321');

INSERT INTO Brand(brand_id, name) VALUES
(1, 'ACME'),
(2, 'XYZ');

INSERT INTO Part_Maker(part_maker_id, name) VALUES
(1, 'Maker1'),
(2, 'Maker2');

INSERT INTO Part(part_id, brand_id, supplier_id, part_group_id, part_maker_id, part_name, main_supplier_name, price_to_us, price_to_customer) VALUES
(1, 1, 1, 1, 1, 'Part1', 'ABC Parts', 10, 20),
(2, 1, 1, 1, 2, 'Part2', 'ABC Parts', 15, 25),
(3, 2, 2, 2, 1, 'Part3', 'XYZ Supplies', 20, 30),
(4, 2, 2, 2, 2, 'Part4', 'XYZ Supplies', 25, 35);

INSERT INTO Part_for_Car(car_id, part_id) VALUES
(1, 1),
(1, 3),
(2, 2),
(2, 4),
(3, 1),
(3, 4);

INSERT INTO Part_Supplier(part_supplier_id, part_id, supplier_id) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 2),
(4, 4, 2);

INSERT INTO Part_in_Order(part_in_order_id, order_id, part_supplier_id, actual_sale_price, quantity) VALUES
(1, 1, 1, 20, 2),
(2, 1, 4, 35, 1),
(3, 2, 2, 25, 4),
(4, 3, 3, 30, 5);