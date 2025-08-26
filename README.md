# restodb

sample database

## Introduction 

### MySQL

```
$ git clone https://github.com/archprac/restodb.git
$ cd restodb/
$
$ mysql -u ${USER} -p < ./mysql-restodb-create.sql
$ mysql -u ${USER} -p < ./mysql-restodb-insert.sql
$
$ mysql -u ${USER} -p -e 'SHOW TABLES' restodb
+-------------------------+
| Tables_in_restodb       |
+-------------------------+
| calendar                |
| customers               |
| daily_menu_order_report |
| gates                   |
| menu_products           |
| menus                   |
| order_deliveres         |
| order_menus             |
| orderer_customers       |
| orderer_reserves        |
| orderer_visits          |
| orderers                |
| orders                  |
| products                |
| rolls                   |
| seats                   |
| shifts                  |
| staff_accesses          |
| staff_rolls             |
| staffs                  |
+-------------------------+
```
