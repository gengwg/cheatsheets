## MySQL basics

### Connect as root

```
shell> mysql --user=root mysql
$ mysql -u root -p
```

### Create a database and grant privileges

```
$ mysql -u root -p
mysql> CREATE DATABASE InterviewDB;
mysql> grant usage on *.* to user@localhost;
mysql> grant all privileges on InterviewDB.* to user@localhost;
```

### Inspect databases / tables

```
show databases;
use testDB;
show tables;
describe orders;
SELECT * FROM table_name;
```

### Add primary key

```
mysql> ALTER TABLE ITEM ADD PRIMARY KEY (Item_Id);
```

### Drop a table

```
drop table item_details;
```

### Comments

```
#                single-line
-- (note space)  single-line
/* ... */        block
```

## Subquery alias

```
MariaDB [test]> SELECT Salary FROM (SELECT DISTINCT Salary FROM Employee) LIMIT 0,1 ;
ERROR 1248 (42000): Every derived table must have its own alias
MariaDB [test]> SELECT Salary FROM (SELECT DISTINCT Salary FROM Employee) e LIMIT 0,1 ;
+--------+
| Salary |
+--------+
|    100 |
+--------+
```

### group by
```
mysql> select * from Employee;
+------+-------+--------+--------------+
| Id   | Name  | Salary | DepartmentId |
+------+-------+--------+--------------+
|    1 | Joe   |  70000 |            1 |
|    2 | Henry |  80000 |            2 |
|    3 | Sam   |  60000 |            2 |
|    4 | Max   |  90000 |            1 |
+------+-------+--------+--------------+

mysql> select Name, sum(Salary) from Employee group by DepartmentId;
+-------+-------------+
| Name  | sum(Salary) |
+-------+-------------+
| Joe   |      160000 |
| Henry |      140000 |
+-------+-------------+
```
