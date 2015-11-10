title: mysql之修改字段默认值
date: 2015-11-10 17:00:18
categories:
- MySql
tags:
- MySql
---


MySQL修改字段默认值
==============
* 解决
	```
	alter table topic alter column cateId set default '2';
	```
* 语法总结
	```
	alter table表名alter column字段名drop default; (若本身存在默认值，则先删除)
	alter table表名 alter column 字段名 set default默认值;(若本身不存在则可以直接设定)
	```