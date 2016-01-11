title: mysql_command
date: 2016-01-08 10:10:19
tags:
---


```
SET character_set_client = utf8;
SET character_set_connection = utf8;
SET character_set_database = utf8;
SET character_set_results = utf8;
SET character_set_server = utf8;
SET default_storage_engine=INNODB;
show engines;
show variables like "have_%"; 

show databases;
use AAA;
drop database AAA;
create database AAA  DEFAULT CHARACTER SET gbk COLLATE gbk_chinese_ci;
create database AAA DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
show variables like 'collation_%';
show global variables like 'character_set_server'; 
show tables;
show create  table order_history;
alter database AAA character set gbk;
DROP TABLE IF EXISTS `role`;
```