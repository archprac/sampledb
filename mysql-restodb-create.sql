
-- DROP DATABASE IF EXISTS restodb;

CREATE DATABASE IF NOT EXISTS restodb;

-- CREATE USER IF NOT EXISTS 'testuser'@'%' IDENTIFIED BY 'testuser';
-- CREATE USER IF NOT EXISTS 'app'@'localhost' IDENTIFIED BY '********';

DROP VIEW IF EXISTS restodb.daily_menu_order_report;
DROP TRIGGER IF EXISTS restodb.customers_trig_upd;
DROP TABLE IF EXISTS restodb.order_menus;
DROP TABLE IF EXISTS restodb.menu_products;
DROP TABLE IF EXISTS restodb.products;
DROP TABLE IF EXISTS restodb.menus;
DROP TABLE IF EXISTS restodb.order_deliveres;
DROP TABLE IF EXISTS restodb.orders;
DROP TABLE IF EXISTS restodb.orderer_customers;
DROP TABLE IF EXISTS restodb.orderer_reserves;
DROP TABLE IF EXISTS restodb.orderer_visits;
DROP TABLE IF EXISTS restodb.orderers;
DROP TABLE IF EXISTS restodb.seats;
DROP TABLE IF EXISTS restodb.customers;
DROP TABLE IF EXISTS restodb.staff_rolls;
DROP TABLE IF EXISTS restodb.shifts;
DROP TABLE IF EXISTS restodb.staff_accesses;
DROP TABLE IF EXISTS restodb.staffs;
DROP TABLE IF EXISTS restodb.rolls;
DROP TABLE IF EXISTS restodb.gates;
DROP TABLE IF EXISTS restodb.calendar;

CREATE TABLE restodb.calendar (
    calendar_date DATE PRIMARY KEY,
    calendar_type_cd INT,
    open_time TIME,
    close_time TIME,
    calendar_comment VARCHAR(1000)
);

CREATE TABLE restodb.products (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(255) NOT NULL,
    provide_cd INT NOT NULL,
    product_overview VARCHAR(4000),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    deleted_at DATETIME(2),
    UNIQUE(product_name, deleted_at)
) AUTO_INCREMENT = 1000;

CREATE INDEX products_idx1 ON restodb.products (product_name);

CREATE TABLE restodb.menus (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    menu_name VARCHAR(255) NOT NULL,
    menu_type_cd INT,
    provide_cd INT NOT NULL,
    order_start_time TIME,
    order_stop_time TIME,
    menu_price DECIMAL(10, 2) NOT NULL,
    menu_overview VARCHAR(4000),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    deleted_at DATETIME(2)
) AUTO_INCREMENT = 1000;

CREATE TABLE restodb.menu_products (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    menu_id INT NOT NULL,
    product_id INT NOT NULL,
    display_order INT NOT NULL,
    FOREIGN KEY (menu_id) REFERENCES restodb.menus(id),
    FOREIGN KEY (product_id) REFERENCES restodb.products(id)
) AUTO_INCREMENT = 1000;

CREATE TABLE restodb.seats (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    seet_name VARCHAR(1000) NOT NULL,
    seat_type_cd INT NOT NULL,
    seet_count INT NOT NULL,
    seat_comment VARCHAR(4000)
) AUTO_INCREMENT = 1000;

CREATE TABLE restodb.customers (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    customer_status_cd INT,
    customer_first_name VARCHAR(255),
    customer_last_name VARCHAR(255),
    gender_cd INT,
    customer_address VARCHAR(255),
    customer_email_address VARCHAR(255),
    customer_phone_number VARCHAR(255),
    integrated_customer_id INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    deleted_at DATETIME(2),
    UNIQUE(customer_email_address, deleted_at),
    UNIQUE(customer_phone_number, deleted_at),
    FOREIGN KEY (integrated_customer_id) REFERENCES restodb.customers(id)
) AUTO_INCREMENT = 1000;

CREATE INDEX customers_idx1 ON restodb.customers (customer_first_name, customer_last_name);

DELIMITER //
CREATE TRIGGER restodb.customers_trig_upd
AFTER UPDATE ON restodb.customers 
FOR EACH ROW
BEGIN
    IF OLD.integrated_customer_id IS NULL
        AND NEW.integrated_customer_id IS NOT NULL
    THEN
        UPDATE restodb.customers c 
        SET c.integrated_customer_id = NEW.integrated_customer_id
        WHERE c.integrated_customer_id = id;
    END IF;
END//
DELIMITER ;

CREATE TABLE restodb.orderers (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    notice VARCHAR(4000),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    deleted_at DATETIME(2)
) AUTO_INCREMENT = 1000;

CREATE TABLE restodb.orderer_customers (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    orderer_id INT NOT NULL,
    customer_id INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    deleted_at DATETIME(2),
    FOREIGN KEY (orderer_id) REFERENCES restodb.orderers(id),
    FOREIGN KEY (customer_id) REFERENCES restodb.customers(id)
) AUTO_INCREMENT = 1000;

CREATE TABLE restodb.orderer_reserves (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    orderer_id INT NOT NULL,
    seat_id INT,
    reserve_status_cd INT,
    reserve_start_time DATETIME,
    reserve_end_time DATETIME,
    number_of_people INT,
    FOREIGN KEY (orderer_id) REFERENCES restodb.orderers(id),
    FOREIGN KEY (seat_id) REFERENCES restodb.seats(id)
) AUTO_INCREMENT = 1000;

CREATE INDEX orderer_reserves_idx1 ON restodb.orderer_reserves (orderer_id, seat_id);

CREATE TABLE restodb.orderer_visits (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    orderer_id INT NOT NULL,
    seat_id INT,
    check_in DATETIME,
    check_out DATETIME,
    number_of_people INT,
    notice VARCHAR(4000),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    deleted_at DATETIME(2),
    FOREIGN KEY (orderer_id) REFERENCES restodb.orderers(id),
    FOREIGN KEY (seat_id) REFERENCES restodb.seats(id)
) AUTO_INCREMENT = 1000;

CREATE INDEX orderer_visits_idx1 ON restodb.orderer_visits (orderer_id, seat_id);

CREATE TABLE restodb.staffs (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    contract_type_cd INT NOT NULL,
    staff_first_name VARCHAR(255) NOT NULL,
    staff_last_name VARCHAR(255) NOT NULL,
    gender_cd INT,
    staff_address VARCHAR(255),
    staff_email_address VARCHAR(255),
    staff_phone_number VARCHAR(255),
    effective_date DATETIME,
    expiration_date DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    deleted_at DATETIME(2),
    UNIQUE(staff_email_address, deleted_at),
    UNIQUE(staff_phone_number, deleted_at)
) AUTO_INCREMENT = 1000;

CREATE INDEX staffs_idx1 ON restodb.staffs (staff_last_name, staff_first_name);

CREATE TABLE restodb.rolls (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    roll_name VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    deleted_at DATETIME(2),
    UNIQUE(roll_name, deleted_at)
) AUTO_INCREMENT = 1000;

CREATE INDEX rolls_idx1 ON restodb.rolls (roll_name);

CREATE TABLE restodb.staff_rolls (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    staff_id INT NOT NULL,
    roll_id INT NOT NULL,
    effective_date DATETIME,
    expiration_date DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    deleted_at DATETIME(2),
    FOREIGN KEY (staff_id) REFERENCES restodb.staffs(id),
    FOREIGN KEY (roll_id) REFERENCES restodb.rolls(id),
    UNIQUE(staff_id, roll_id, deleted_at)
) AUTO_INCREMENT = 1000;

CREATE INDEX staff_rolls_idx1 ON restodb.staff_rolls (staff_id, roll_id);

CREATE TABLE restodb.orders (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    orderer_id INT,
    order_datetime DATETIME NOT NULL,
    order_type_cd INT NOT NULL, 
    order_status_cd INT,
    accepted_staff_id INT NOT NULL, 
    cleared_staff_id INT NOT NULL, 
    amount DECIMAL(10, 2) NOT NULL,
    discount DECIMAL(10, 2) DEFAULT 0,
    notice VARCHAR(4000),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    deleted_at DATETIME(2),
    FOREIGN KEY (orderer_id) REFERENCES restodb.orderers(id),
    FOREIGN KEY (accepted_staff_id) REFERENCES restodb.staffs(id),
    FOREIGN KEY (cleared_staff_id) REFERENCES restodb.staffs(id)
) AUTO_INCREMENT = 1000;

CREATE TABLE restodb.order_deliveres (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    delivery_staff_id INT NOT NULL, 
    FOREIGN KEY (order_id) REFERENCES restodb.orders(id),
    FOREIGN KEY (delivery_staff_id) REFERENCES restodb.staffs(id)
) AUTO_INCREMENT = 1000;

CREATE TABLE restodb.order_menus (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    menu_id INT NOT NULL,
    order_count INT NOT NULL,
    notice VARCHAR(4000),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    deleted_at DATETIME(2),
    FOREIGN KEY (order_id) REFERENCES restodb.orders(id),
    FOREIGN KEY (menu_id) REFERENCES restodb.menus(id)
) AUTO_INCREMENT = 1000;

CREATE TABLE restodb.shifts (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    staff_id INT,
    shift_start_datetime DATETIME,
    shift_end_datetime DATETIME,
    shift_status_cd INT,
    shift_comment VARCHAR(1000),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    deleted_at DATETIME(2),
    FOREIGN KEY (staff_id) REFERENCES restodb.staffs(id)
) AUTO_INCREMENT = 1000;

CREATE TABLE restodb.gates (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    gate_name VARCHAR(500) NOT NULL,
    gate_type_cd INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    deleted_at DATETIME(2)
) AUTO_INCREMENT = 1000;

CREATE TABLE restodb.staff_accesses (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    staff_id INT NOT NULL,
    gate_id INT NOT NULL,
    access_type_cd INT NOT NULL,
    access_datetime DATETIME NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    deleted_at DATETIME(2),
    FOREIGN KEY (staff_id) REFERENCES restodb.staffs(id),
    FOREIGN KEY (gate_id) REFERENCES restodb.gates(id)
) AUTO_INCREMENT = 1000;

CREATE VIEW restodb.daily_menu_order_report AS
SELECT 
    c.calendar_date,
    m.menu_name,
    COUNT(*) AS order_count,
    SUM(o.amount) total_amount,
    SUM(o.discount) total_discount
FROM restodb.calendar c
    JOIN restodb.orders o ON CAST(o.order_datetime AS DATE) = c.calendar_date
    JOIN restodb.order_menus om ON om.order_id = o.id
    JOIN restodb.menus m ON m.id = om.menu_id
WHERE om.deleted_at IS NULL
  AND o.deleted_at IS NULL
GROUP BY c.calendar_date, m.id, m.menu_name
ORDER BY c.calendar_date, m.id, m.menu_name;
