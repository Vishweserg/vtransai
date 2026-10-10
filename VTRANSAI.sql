mysql> USE VtransAI
Database changed
mysql> CREATE TABLE IF NOT EXISTS vehicles(
    ->    vehicle_id INT PRIMARY KEY AUTO_INCREMENT,
    ->    vehicle_no VARCHAR(20) UNIQUE,
    ->    vehicle_type VARCHAR(50),
    ->    capacity DECIMAL(6,2),
    ->    current_city VARCHAR(100),
    ->    availability VARCHAR(20),
    ->    condition_status VARCHAR(30),
    ->    mileage_km INT,
    ->    fuel_efficiency_kmpl DECIMAL(5,2),
    ->    driver_name VARCHAR(100)
    -> );
Query OK, 0 rows affected (0.09 sec)

mysql> SHOW TABLES;
+--------------------+
| Tables_in_vtransai |
+--------------------+
| vehicles           |
+--------------------+
1 row in set (0.05 sec)

mysql> INSERT INTO vehicles
    -> (vehicle_no, vehicle_type, capacity, current_city, availability, condition_status, mileage_km, fuel_efficiency_kmpl, driver_name)
    -> VALUES
    -> ('TN01AB1001','Heavy Truck', 10, 'Chennai', 'AVAILABLE', 'GOOD', 45000, 3.5, 'Driver A'),
    -> ('TN01AB1002', 'Medium Truck', 5, 'Chennai', 'AVAILABLE', 'GOOD', 28000, 7.0, 'Driver B'),
    -> ('TN01AB1003', 'Mini Truck', 2, 'Vellore', 'AVAILABLE', 'GOOD', 18000, 10.0, 'Driver C'),
    -> ('TN01AB1004', 'Heavy Truck', 12, 'Vellore', 'UNAVAILABLE', 'POOR', 95000, 4.0, 'Driver D'),
    -> ('TN01AB1005', 'Medium Truck', 4, 'Bengaluru', 'AVAILABLE', 'WARNING', 70000, 6.0, 'Driver E');
Query OK, 5 rows affected (0.05 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> SELECT*FROM vehicles;
+------------+------------+--------------+----------+--------------+--------------+------------------+------------+----------------------+-------------+
| vehicle_id | vehicle_no | vehicle_type | capacity | current_city | availability | condition_status | mileage_km | fuel_efficiency_kmpl | driver_name |
+------------+------------+--------------+----------+--------------+--------------+------------------+------------+----------------------+-------------+
|          1 | TN01AB1001 | Heavy Truck  |    10.00 | Chennai      | AVAILABLE    | GOOD             |      45000 |                 3.50 | Driver A    |
|          2 | TN01AB1002 | Medium Truck |     5.00 | Chennai      | AVAILABLE    | GOOD             |      28000 |                 7.00 | Driver B    |
|          3 | TN01AB1003 | Mini Truck   |     2.00 | Vellore      | AVAILABLE    | GOOD             |      18000 |                10.00 | Driver C    |
|          4 | TN01AB1004 | Heavy Truck  |    12.00 | Vellore      | UNAVAILABLE  | POOR             |      95000 |                 4.00 | Driver D    |
|          5 | TN01AB1005 | Medium Truck |     4.00 | Bengaluru    | AVAILABLE    | WARNING          |      70000 |                 6.00 | Driver E    |
+------------+------------+--------------+----------+--------------+--------------+------------------+------------+----------------------+-------------+
5 rows in set (0.00 sec)

mysql> CREATE TABLE IF NOT EXISTS maintenance(
    ->     maintenance_id INT PRIMARY KEY AUTO_INCREMENT,
    ->     vehicle_id INT NOT NULL,
    ->     last_service_date DATE,
    ->     next_service_date DATE,
    ->     maintenance_status VARCHAR(50),
    ->     details VARCHAR(300),
    ->     FOREIGN KEY(vehicle_id)
    ->         REFERENCES vehicles(vehicle_id)
    -> );
Query OK, 0 rows affected (0.04 sec)

mysql> UPDATE maintenance
    -> \c
mysql> ALTER TABLE maintenance
    -> ADD COLUMN parts_replaced VARCHAR(300),
    -> ADD COLUMN odometer_km INT,
    -> ADD COLUMN next_service_km INT;
Query OK, 0 rows affected (0.09 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> DESCRIBE maintenance;
+--------------------+--------------+------+-----+---------+----------------+
| Field              | Type         | Null | Key | Default | Extra          |
+--------------------+--------------+------+-----+---------+----------------+
| maintenance_id     | int          | NO   | PRI | NULL    | auto_increment |
| vehicle_id         | int          | NO   | MUL | NULL    |                |
| last_service_date  | date         | YES  |     | NULL    |                |
| next_service_date  | date         | YES  |     | NULL    |                |
| maintenance_status | varchar(50)  | YES  |     | NULL    |                |
| details            | varchar(300) | YES  |     | NULL    |                |
| parts_replaced     | varchar(300) | YES  |     | NULL    |                |
| odometer_km        | int          | YES  |     | NULL    |                |
| next_service_km    | int          | YES  |     | NULL    |                |
+--------------------+--------------+------+-----+---------+----------------+
9 rows in set (0.02 sec)

mysql> USE VtransAI;
Database changed
mysql> SHOW TABLES;
+--------------------+
| Tables_in_vtransai |
+--------------------+
| maintenance        |
| vehicles           |
+--------------------+
2 rows in set (0.00 sec)

mysql> CREATE TABLE IF NOT EXISTS trips(
    -> trip_id INT PRIMARY KEY AUTO_INCREMENT,
    -> source_city VARCHAR(100),
    -> destination_city VARCHAR(100),
    -> distance_km DECIMAL(8,2),
    -> required_capacity_ton DECIMAL(6,2),
    -> delivery_date DATE,
    -> trip_status VARCHAR(30),
    -> assigned_veicle_id INT,
    -> FOREIGN KEY(assigned_vehicle_id)
    ->    REFERENCES vehicles(vehicle_id)
    -> );
ERROR 1072 (42000): Key column 'assigned_vehicle_id' doesn't exist in table
mysql> assigned_vehicle_id INT,
    -> \c
mysql> CREATE TABLE IF NOT EXISTS trips(
    ->     trip_id INT PRIMARY KEY AUTO_INCREMENT,
    ->     source_city VARCHAR(100),
    ->     destination_city VARCHAR(100),
    ->     distance_km DECIMAL(8,2),
    ->     required_capacity_ton DECIMAL(6,2),
    ->     delivery_date DATE,
    ->     trip_status VARCHAR(30),
    ->     assigned_vehicle_id INT, -- Fixed typo here
    ->     FOREIGN KEY(assigned_vehicle_id) REFERENCES vehicles(vehicle_id)
    -> \c
mysql> CREATE TABLE IF NOT EXISTS trips(
    ->     trip_id INT PRIMARY KEY AUTO_INCREMENT,
    ->     source_city VARCHAR(100),
    ->     destination_city VARCHAR(100),
    ->     distance_km DECIMAL(8,2),
    ->     required_capacity_ton DECIMAL(6,2),
    ->     delivery_date DATE,
    ->     trip_status VARCHAR(30),
    ->     assigned_vehicle_id INT,
    ->     FOREIGN KEY(assigned_vehicle_id) REFERENCES vehicles(vehicle_id)
    -> );
Query OK, 0 rows affected (0.07 sec)

mysql> CREATE TABLE IF NOT EXISTS drivers(
    ->    driver_id INT PRIMARY KEY AUTO_INCREMENT,
    ->    driver_name VARCHAR(100),
    ->    phone_number VARCHAR(15),
    ->    licence_no VARCHAR(30),
    ->    current_city VARCHAR(20),
    ->    expererience_years INT,
    -> );
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ')' at line 8
mysql> CREATE TABLE IF NOT EXISTS drivers (
    ->     driver_id INT PRIMARY KEY AUTO_INCREMENT,
    ->     driver_name VARCHAR(100) NOT NULL,
    ->     phone_number VARCHAR(15),
    ->     license_number VARCHAR(30) UNIQUE,
    ->     license_expiry_date DATE,
    ->     experience_years INT,
    ->     driver_status VARCHAR(20),
    ->     current_city VARCHAR(100)
    -> );
Query OK, 0 rows affected (0.07 sec)

mysql> SHOW TABLES;
+--------------------+
| Tables_in_vtransai |
+--------------------+
| drivers            |
| maintenance        |
| trips              |
| vehicles           |
+--------------------+
4 rows in set (0.00 sec)

mysql> SELECT*FROM vehicles;
+------------+------------+--------------+----------+--------------+--------------+------------------+------------+----------------------+-------------+
| vehicle_id | vehicle_no | vehicle_type | capacity | current_city | availability | condition_status | mileage_km | fuel_efficiency_kmpl | driver_name |
+------------+------------+--------------+----------+--------------+--------------+------------------+------------+----------------------+-------------+
|          1 | TN01AB1001 | Heavy Truck  |    10.00 | Chennai      | AVAILABLE    | GOOD             |      45000 |                 3.50 | Driver A    |
|          2 | TN01AB1002 | Medium Truck |     5.00 | Chennai      | AVAILABLE    | GOOD             |      28000 |                 7.00 | Driver B    |
|          3 | TN01AB1003 | Mini Truck   |     2.00 | Vellore      | AVAILABLE    | GOOD             |      18000 |                10.00 | Driver C    |
|          4 | TN01AB1004 | Heavy Truck  |    12.00 | Vellore      | UNAVAILABLE  | POOR             |      95000 |                 4.00 | Driver D    |
|          5 | TN01AB1005 | Medium Truck |     4.00 | Bengaluru    | AVAILABLE    | WARNING          |      70000 |                 6.00 | Driver E    |
+------------+------------+--------------+----------+--------------+--------------+------------------+------------+----------------------+-------------+
5 rows in set (0.00 sec)

mysql> SELECT*FROM maintenence;
ERROR 1146 (42S02): Table 'vtransai.maintenence' doesn't exist
mysql> SELECT*FROM trips;
Empty set (0.04 sec)

mysql> USE VTRANSAI
Database changed
mysql>  CREATE TABLE IF NOT EXISTS vehicles(
    ->     ->    vehicle_id INT PRIMARY KEY AUTO_INCREMENT,
    ->     ->    vehicle_no VARCHAR(20) UNIQUE,
    ->     ->    vehicle_type VARCHAR(50),
    ->     ->    capacity DECIMAL(6,2),
    ->     ->    current_city VARCHAR(100),
    ->     ->    availability VARCHAR(20),
    ->     ->    condition_status VARCHAR(30),
    ->     ->    mileage_km INT,
    ->     ->    fuel_efficiency_kmpl DECIMAL(5,2),
    ->     ->    driver_name VARCHAR(100)
    ->     -> \C
ERROR:
Usage: \C charset_name | charset charset_name
    -> \c
mysql> CREATE TABLE IF NOT EXISTS vehicles (
    ->     vehicle_id INT PRIMARY KEY AUTO_INCREMENT,
    ->     vehicle_number VARCHAR(20) UNIQUE,
    ->     vehicle_type VARCHAR(50),
    ->     capacity_tonnes DECIMAL(6,2),
    ->     current_city VARCHAR(100),
    ->     availability VARCHAR(20),
    ->     condition_status VARCHAR(30),
    ->     mileage_km INT,
    ->     fuel_efficiency_kmpl DECIMAL(5,2),
    ->     driver_name VARCHAR(100)
    -> );
Query OK, 0 rows affected, 1 warning (0.04 sec)

mysql>
mysql> CREATE TABLE IF NOT EXISTS maintenance (
    ->     maintenance_id INT PRIMARY KEY AUTO_INCREMENT,
    ->     vehicle_id INT NOT NULL,
    ->     last_service_date DATE,
    ->     next_service_date DATE,
    ->     maintenance_status VARCHAR(30),
    ->     notes VARCHAR(255),
    ->     odometer_km INT,
    ->     service_interval_km INT,
    ->     last_inspection_date DATE,
    ->     brake_status VARCHAR(20),
    ->     tyre_status VARCHAR(20),
    ->     engine_status VARCHAR(20),
    ->     breakdown_count INT DEFAULT 0,
    ->     repair_cost DECIMAL(10,2) DEFAULT 0.00,
    ->     FOREIGN KEY (vehicle_id)
    ->         REFERENCES vehicles(vehicle_id)
    -> );
Query OK, 0 rows affected, 1 warning (0.04 sec)

mysql>
mysql> CREATE TABLE IF NOT EXISTS drivers (
    ->     driver_id INT PRIMARY KEY AUTO_INCREMENT,
    ->     driver_name VARCHAR(100) NOT NULL,
    ->     phone_number VARCHAR(15),
    ->     license_number VARCHAR(30) UNIQUE,
    ->     license_expiry_date DATE,
    ->     experience_years INT,
    ->     driver_status VARCHAR(20),
    ->     current_city VARCHAR(100)
    -> );
Query OK, 0 rows affected, 1 warning (0.04 sec)

mysql>
mysql> CREATE TABLE IF NOT EXISTS trips (
    ->     trip_id INT PRIMARY KEY AUTO_INCREMENT,
    ->     source_city VARCHAR(100),
    ->     destination_city VARCHAR(100),
    ->     distance_km DECIMAL(8,2),
    ->     required_capacity_tonnes DECIMAL(6,2),
    ->     delivery_date DATE,
    ->     trip_status VARCHAR(30),
    ->     assigned_vehicle_id INT,
    ->     assigned_driver_id INT,
    ->     FOREIGN KEY (assigned_vehicle_id)
    ->         REFERENCES vehicles(vehicle_id),
    ->     FOREIGN KEY (assigned_driver_id)
    ->         REFERENCES drivers(driver_id)
    -> );
Query OK, 0 rows affected, 1 warning (0.04 sec)

mysql>
mysql> INSERT INTO vehicles
    -> (vehicle_number, vehicle_type, capacity_tonnes,
    ->  current_city, availability, condition_status,
    ->  mileage_km, fuel_efficiency_kmpl, driver_name)
    -> VALUES
    -> ('TN01AB1001', 'Heavy Truck', 10, 'Chennai', 'AVAILABLE', 'GOOD', 45000, 5.5, 'Driver A'),
    -> ('TN01AB1002', 'Medium Truck', 5, 'Chennai', 'AVAILABLE', 'GOOD', 28000, 7.0, 'Driver B'),
    -> ('TN01AB1003', 'Mini Truck', 2, 'Vellore', 'AVAILABLE', 'GOOD', 18000, 10.0, 'Driver C'),
    -> ('TN01AB1004', 'Heavy Truck', 12, 'Chennai', 'UNAVAILABLE', 'POOR', 95000, 4.0, 'Driver D'),
    -> ('TN01AB1005', 'Medium Truck', 4, 'Bengaluru', 'AVAILABLE', 'WARNING', 70000, 6.0, 'Driver E');
ERROR 1054 (42S22): Unknown column 'vehicle_number' in 'field list'
mysql> DESCRIBE vehicles;
+----------------------+--------------+------+-----+---------+----------------+
| Field                | Type         | Null | Key | Default | Extra          |
+----------------------+--------------+------+-----+---------+----------------+
| vehicle_id           | int          | NO   | PRI | NULL    | auto_increment |
| vehicle_no           | varchar(20)  | YES  | UNI | NULL    |                |
| vehicle_type         | varchar(50)  | YES  |     | NULL    |                |
| capacity             | decimal(6,2) | YES  |     | NULL    |                |
| current_city         | varchar(100) | YES  |     | NULL    |                |
| availability         | varchar(20)  | YES  |     | NULL    |                |
| condition_status     | varchar(30)  | YES  |     | NULL    |                |
| mileage_km           | int          | YES  |     | NULL    |                |
| fuel_efficiency_kmpl | decimal(5,2) | YES  |     | NULL    |                |
| driver_name          | varchar(100) | YES  |     | NULL    |                |
+----------------------+--------------+------+-----+---------+----------------+
10 rows in set (0.04 sec)