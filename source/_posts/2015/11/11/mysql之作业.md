title: mysql之作业
date: 2015-11-11 15:54:38
tags:
---
在网上找了一个比较全的入门教程
========================

1. 在mysql 中建立一个数据库 test1 

	```
	create database test1 
	```
2. 创建表examinfo 

	```
	use test1;
	create table examinfo( 
		id int auto_increment not null, 
		endtime datetime, 
		primary key(id) 
	); 
	```

3. 插入数据： 

	```
	insert into examinfo values('1','2011-4-23 23:26:50'); 
	```

	定界符
	```
	DELIMITER //
	```
4. 创建存储过程test 

	```
	mysql> select * from examinfo;
	+----+---------------------+
	| id | endtime             |
	+----+---------------------+
	|  1 | 2011-04-23 23:26:50 |
	+----+---------------------+
	1 row in set (0.00 sec)
	
	mysql> DELIMITER //
	mysql> CREATE PROCEDURE test () 
	    -> begin
	    -> update examinfo set endtime=now() where id=1;
	    -> end;
	    -> //
	Query OK, 0 rows affected (0.00 sec)
	```

5. 创建event e_test 
	```
	mysql> CREATE EVENT if not exists e_test 
	    -> on schedule every 30 second 
	    -> on completion preserve 
	    -> do call test(); 
	    -> //
	Query OK, 0 rows affected (0.00 sec)
	
	```


6.
	-	查看event是否开启: show variables like '%sche%'; 
	-	将事件计划开启: set global event_scheduler=1; 
	-	关闭事件任务: alter event e_test ON COMPLETION PRESERVE DISABLE; 
	-	开启事件任务: alter event e_test ON COMPLETION PRESERVE ENABLE; 

7. 查看结果

	```
	mysql> select * from examinfo//
	+----+---------------------+
	| id | endtime             |
	+----+---------------------+
	|  1 | 2015-11-11 12:02:09 |
	+----+---------------------+
	1 row in set (0.00 sec)
	
	mysql> select * from examinfo//
	+----+---------------------+
	| id | endtime             |
	+----+---------------------+
	|  1 | 2015-11-11 12:02:39 |
	+----+---------------------+
	1 row in set (0.00 sec)
	
	```

查看存储过程
-------------
*	方法一：
	```
	select `name` from mysql.proc where db = 'your_db_name' and `type` = 'PROCEDURE'
	```
*	方法二：
	```
	show procedure status;
	```

查看存储过程或函数的创建代码
-------------
```
show create procedure proc_name;
show create function func_name;
```