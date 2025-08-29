# restodb

sample database

## Introduction 

### Execution environment

- Ubuntu 24.04.3 LTS
- mysql Ver 8.0.43

### Execution example

```
$ git clone https://github.com/archprac/restodb.git
$ cd restodb/
$
$ mysql -u ${USER} -p < ./restodb-create-mysql8.sql
$ mysql -u ${USER} -p < ./restodb-insert.sql
$
$ mysql -u ${USER} -p -e 'SELECT table_name, table_rows FROM information_schema.tables WHERE table_schema = database() ORDER BY table_name;' restodb
+-------------------------+------------+
| TABLE_NAME              | TABLE_ROWS |
+-------------------------+------------+
| calendar                |          0 |
| customers               |         71 |
| daily_menu_order_report |       NULL |
| gates                   |          8 |
| menu_products           |          0 |
| menus                   |         27 |
| order_deliveres         |          0 |
| order_menus             |          0 |
| orderer_customers       |          0 |
| orderer_reserves        |          0 |
| orderer_visits          |          0 |
| orderers                |          0 |
| orders                  |          0 |
| products                |         27 |
| rolls                   |          5 |
| seats                   |         10 |
| shifts                  |          0 |
| staff_accesses          |          0 |
| staff_rolls             |          0 |
| staffs                  |         13 |
+-------------------------+------------+
```
