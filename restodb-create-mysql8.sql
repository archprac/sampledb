CREATE DATABASE IF NOT EXISTS restodb;

DROP VIEW IF EXISTS restodb.daily_menu_order_report;
DROP TABLE IF EXISTS restodb.order_menus;
DROP TABLE IF EXISTS restodb.menu_products;
DROP TABLE IF EXISTS restodb.products;
DROP TABLE IF EXISTS restodb.menus;
DROP TABLE IF EXISTS restodb.order_deliveres;
DROP TABLE IF EXISTS restodb.orders;
DROP TABLE IF EXISTS restodb.customer_addresses;
DROP TABLE IF EXISTS restodb.customer_reserves;
DROP TABLE IF EXISTS restodb.customer_visits;
DROP TABLE IF EXISTS restodb.customers;
DROP TABLE IF EXISTS restodb.seats;
DROP TABLE IF EXISTS restodb.addresses;
DROP TABLE IF EXISTS restodb.staff_rolls;
DROP TABLE IF EXISTS restodb.shifts;
DROP TABLE IF EXISTS restodb.staff_accesses;
DROP TABLE IF EXISTS restodb.staffs;
DROP TABLE IF EXISTS restodb.rolls;
DROP TABLE IF EXISTS restodb.gates;
DROP TABLE IF EXISTS restodb.calendar;

CREATE TABLE restodb.calendar (
    calendar_date DATE NOT NULL,
    calendar_type_cd INT NOT NULL,
    open_time TIME,
    close_time TIME,
    calendar_comment VARCHAR(1000),
    CONSTRAINT pk_calendar PRIMARY KEY(calendar_date)
);

CREATE TABLE restodb.products (
    id INT AUTO_INCREMENT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    product_type_cd INT NOT NULL,
    lead_time INT NOT NULL,
    product_overview VARCHAR(4000),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    deleted_at DATETIME(2),
    CONSTRAINT pk_products PRIMARY KEY(id)
) AUTO_INCREMENT = 1000;

CREATE INDEX idx_products_01 ON restodb.products (product_name);

CREATE TABLE restodb.menus (
    id INT AUTO_INCREMENT NOT NULL,
    menu_name VARCHAR(255) NOT NULL,
    menu_type_cd INT,
    provide_cd INT NOT NULL,
    order_start_time TIME,
    order_stop_time TIME,
    menu_price DECIMAL(10, 2) NOT NULL,
    menu_overview VARCHAR(4000),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    deleted_at DATETIME(2),
    CONSTRAINT pk_menus PRIMARY KEY(id),
    CONSTRAINT ck_menus_01 CHECK (order_start_time < order_stop_time)
) AUTO_INCREMENT = 1000;

CREATE TABLE restodb.menu_products (
    id INT AUTO_INCREMENT NOT NULL,
    menu_id INT NOT NULL,
    product_id INT NOT NULL,
    display_order INT,
    CONSTRAINT pk_menu_products PRIMARY KEY(id),
    CONSTRAINT fk_menu_products_01 FOREIGN KEY (menu_id) REFERENCES restodb.menus(id),
    CONSTRAINT fk_menu_products_02 FOREIGN KEY (product_id) REFERENCES restodb.products(id)
) AUTO_INCREMENT = 1000;

CREATE TABLE restodb.seats (
    id INT AUTO_INCREMENT NOT NULL,
    seet_name VARCHAR(1000) NOT NULL,
    seat_type_cd INT NOT NULL,
    seet_count INT NOT NULL,
    seat_comment VARCHAR(4000),
    CONSTRAINT pk_seats PRIMARY KEY(id)
) AUTO_INCREMENT = 1000;

CREATE TABLE restodb.addresses  (
    id INT AUTO_INCREMENT NOT NULL,
    addres_status_cd INT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    gender_cd INT,
    address VARCHAR(255),
    email_address VARCHAR(255),
    phone_number VARCHAR(255),
    integrated_addres_id INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    deleted_at DATETIME(2),
    CONSTRAINT pk_addresses PRIMARY KEY(id),
    CONSTRAINT fk_addresses_01 FOREIGN KEY (integrated_addres_id) REFERENCES restodb.addresses (id)
) AUTO_INCREMENT = 1000;

CREATE INDEX idx_addresses_01 ON restodb.addresses (first_name, last_name);

DELIMITER /
CREATE TRIGGER restodb.addresses_trig_upd
AFTER UPDATE ON restodb.addresses
FOR EACH ROW
BEGIN
    IF OLD.integrated_addres_id IS NULL
        AND NEW.integrated_addres_id IS NOT NULL
    THEN
        UPDATE restodb.addresses c 
        SET c.integrated_addres_id = NEW.integrated_addres_id
        WHERE c.integrated_addres_id = OLD.id;
    END IF;
END;
/
DELIMITER ;

CREATE TABLE restodb.customers (
    id INT AUTO_INCREMENT NOT NULL,
    notice VARCHAR(4000),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    deleted_at DATETIME(2),
    CONSTRAINT pk_customers PRIMARY KEY(id)
) AUTO_INCREMENT = 1000;

CREATE TABLE restodb.customer_addresses (
    id INT AUTO_INCREMENT NOT NULL,
    addres_id INT NOT NULL,
    customer_id INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    deleted_at DATETIME(2),
    CONSTRAINT pk_customer_addresses PRIMARY KEY(id),
    CONSTRAINT fk_customer_addresses_01 FOREIGN KEY (addres_id) REFERENCES restodb.addresses(id),
    CONSTRAINT fk_customer_addresses_02 FOREIGN KEY (customer_id) REFERENCES restodb.customers(id)
) AUTO_INCREMENT = 1000;

CREATE TABLE restodb.customer_reserves (
    id INT AUTO_INCREMENT NOT NULL,
    customer_id INT NOT NULL,
    seat_id INT,
    reserve_status_cd INT,
    reserve_start_time DATETIME,
    reserve_end_time DATETIME,
    number_of_people INT,
    CONSTRAINT pk_customer_reserves PRIMARY KEY(id),
    CONSTRAINT fk_customer_reserves_01 FOREIGN KEY (customer_id) REFERENCES restodb.customers(id),
    CONSTRAINT fk_customer_reserves_02 FOREIGN KEY (seat_id) REFERENCES restodb.seats(id),
    CONSTRAINT ck_customer_reserves_01 CHECK (reserve_start_time < reserve_end_time)
) AUTO_INCREMENT = 1000;

CREATE INDEX idx_customer_reserves_01 ON restodb.customer_reserves (customer_id, seat_id);

CREATE TABLE restodb.customer_visits (
    id INT AUTO_INCREMENT NOT NULL,
    customer_id INT NOT NULL,
    seat_id INT,
    check_in DATETIME,
    check_out DATETIME,
    number_of_people INT,
    notice VARCHAR(4000),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    deleted_at DATETIME(2),
    CONSTRAINT pk_customer_visits PRIMARY KEY(id),
    CONSTRAINT fk_customer_visits_01 FOREIGN KEY (customer_id) REFERENCES restodb.customers(id),
    CONSTRAINT fk_customer_visits_02 FOREIGN KEY (seat_id) REFERENCES restodb.seats(id),
    CONSTRAINT ck_customer_visits_01 CHECK (check_in < check_out)
) AUTO_INCREMENT = 1000;

CREATE INDEX idx_customer_visits_01 ON restodb.customer_visits (customer_id, seat_id);

CREATE TABLE restodb.staffs (
    id INT AUTO_INCREMENT NOT NULL,
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
    CONSTRAINT pk_staffs PRIMARY KEY(id)
) AUTO_INCREMENT = 1000;

CREATE INDEX idx_staffs_01 ON restodb.staffs (staff_last_name, staff_first_name);

CREATE TABLE restodb.rolls (
    id INT AUTO_INCREMENT NOT NULL,
    roll_name VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    deleted_at DATETIME(2),
    CONSTRAINT pk_rolls PRIMARY KEY(id)
) AUTO_INCREMENT = 1000;

CREATE INDEX idx_rolls_01 ON restodb.rolls (roll_name);

CREATE TABLE restodb.staff_rolls (
    id INT AUTO_INCREMENT NOT NULL,
    staff_id INT NOT NULL,
    roll_id INT NOT NULL,
    effective_date DATETIME,
    expiration_date DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    deleted_at DATETIME(2),
    CONSTRAINT pk_staff_rolls PRIMARY KEY(id),
    CONSTRAINT fk_staff_rolls_01 FOREIGN KEY (staff_id) REFERENCES restodb.staffs(id),
    CONSTRAINT fk_staff_rolls_02 FOREIGN KEY (roll_id) REFERENCES restodb.rolls(id)
) AUTO_INCREMENT = 1000;

CREATE INDEX idx_staff_rolls_01 ON restodb.staff_rolls (staff_id, roll_id);

CREATE TABLE restodb.orders (
    id INT AUTO_INCREMENT NOT NULL,
    customer_id INT,
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
    CONSTRAINT pk_orders PRIMARY KEY(id),
    CONSTRAINT fk_orders_01 FOREIGN KEY (customer_id) REFERENCES restodb.customers(id),
    CONSTRAINT fk_orders_02 FOREIGN KEY (accepted_staff_id) REFERENCES restodb.staffs(id),
    CONSTRAINT fk_orders_03 FOREIGN KEY (cleared_staff_id) REFERENCES restodb.staffs(id)
) AUTO_INCREMENT = 1000;

CREATE TABLE restodb.order_deliveres (
    id INT AUTO_INCREMENT NOT NULL,
    order_id INT NOT NULL,
    delivery_staff_id INT NOT NULL, 
    CONSTRAINT pk_order_deliveres PRIMARY KEY(id),
    CONSTRAINT fk_order_deliveres_01 FOREIGN KEY (order_id) REFERENCES restodb.orders(id),
    CONSTRAINT fk_order_deliveres_02 FOREIGN KEY (delivery_staff_id) REFERENCES restodb.staffs(id)
) AUTO_INCREMENT = 1000;

CREATE TABLE restodb.order_menus (
    id INT AUTO_INCREMENT NOT NULL,
    order_id INT NOT NULL,
    menu_id INT NOT NULL,
    order_count INT NOT NULL,
    notice VARCHAR(4000),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    deleted_at DATETIME(2),
    CONSTRAINT pk_order_menus PRIMARY KEY(id),
    CONSTRAINT fk_order_menus_01 FOREIGN KEY (order_id) REFERENCES restodb.orders(id),
    CONSTRAINT fk_order_menus_02 FOREIGN KEY (menu_id) REFERENCES restodb.menus(id)
) AUTO_INCREMENT = 1000;

CREATE TABLE restodb.shifts (
    id INT AUTO_INCREMENT NOT NULL,
    staff_id INT,
    shift_start_datetime DATETIME,
    shift_end_datetime DATETIME,
    shift_status_cd INT,
    shift_comment VARCHAR(1000),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    deleted_at DATETIME(2),
    CONSTRAINT pk_shifts PRIMARY KEY(id),
    CONSTRAINT fk_shifts_01 FOREIGN KEY (staff_id) REFERENCES restodb.staffs(id),
    CONSTRAINT ck_shifts_01 CHECK (shift_start_datetime < shift_end_datetime)
) AUTO_INCREMENT = 1000;

CREATE TABLE restodb.gates (
    id INT AUTO_INCREMENT NOT NULL,
    gate_name VARCHAR(500) NOT NULL,
    gate_type_cd INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    deleted_at DATETIME(2),
    CONSTRAINT pk_gates PRIMARY KEY(id)
) AUTO_INCREMENT = 1000;

CREATE TABLE restodb.staff_accesses (
    id INT AUTO_INCREMENT NOT NULL,
    staff_id INT NOT NULL,
    gate_id INT NOT NULL,
    access_type_cd INT NOT NULL,
    access_datetime DATETIME NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    deleted_at DATETIME(2),
    CONSTRAINT pk_staff_accesses PRIMARY KEY(id),
    CONSTRAINT fk_staff_accesses_01 FOREIGN KEY (staff_id) REFERENCES restodb.staffs(id),
    CONSTRAINT fk_staff_accesses_02 FOREIGN KEY (gate_id) REFERENCES restodb.gates(id)
) AUTO_INCREMENT = 1000;

CREATE VIEW restodb.daily_menu_order_report AS
SELECT 
    c.calendar_date,
    m.menu_name,
    COUNT(*) AS order_count,
    SUM(o.amount) AS total_amount,
    SUM(o.discount) AS total_discount
FROM restodb.calendar c
    JOIN restodb.orders o ON CAST(o.order_datetime AS DATE) = c.calendar_date
    JOIN restodb.order_menus om ON om.order_id = o.id
    JOIN restodb.menus m ON m.id = om.menu_id
WHERE om.deleted_at IS NULL
  AND o.deleted_at IS NULL
GROUP BY c.calendar_date, m.id, m.menu_name
ORDER BY c.calendar_date, m.id, m.menu_name;
