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
