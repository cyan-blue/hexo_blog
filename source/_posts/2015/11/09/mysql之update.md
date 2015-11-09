title: mysql之update
date: 2015-11-09 10:37:12
categories:
- MySql
tags:
- MySql
---

Single-table语法：
```
UPDATE [LOW_PRIORITY] [IGNORE] tbl_name
    SET col_name1=expr1 [, col_name2=expr2 ...]
    [WHERE where_definition]
    [ORDER BY ...]
    [LIMIT row_count]
```
Multiple-table语法：
```
UPDATE [LOW_PRIORITY] [IGNORE] table_references
    SET col_name1=expr1 [, col_name2=expr2 ...]
    [WHERE where_definition]
```
UPDATE语法可以用新值更新原有表行中的各列。SET子句指示要修改哪些列和要给予哪些值。WHERE子句指定应更新哪些行。如果没有WHERE子句，则更新所有的行。如果指定了ORDER BY子句，则按照被指定的顺序对行进行更新。LIMIT子句用于给定一个限值，限制可以被更新的行的数目。

 

如果您在一个表达式中通过tbl_name访问一列，则UPDATE使用列中的当前值。例如，以下语句把年龄列设置为比当前值多一：
```
UPDATE persondata SET age=age+1;
```
UPDATE赋值被从左到右评估。例如，以下语句对年龄列加倍，然后再进行增加：
```
UPDATE persondata SET age=age*2, age=age+1;
```
如果您把一列设置为其当前含有的值，则MySQL会注意到这一点，但不会更新。

update表的某些字段为null
```
update person set number=null,name=null;
```
如果您把被已定义为NOT NULL的列更新为NULL，则该列被设置到与列类型对应的默认值，并且累加警告数。对于数字类型，默认值为0；对于字符串类型，默认值为空字符串('')；对于日期和时间类型，默认值为“zero”值。

 

多个表的UPDATE操作

UPDATE items,month SET items.price=month.price WHERE items.id=month.id;
以上的例子显示出了使用逗号操作符的内部联合，但是multiple-table UPDATE语句可以使用在SELECT语句中允许的任何类型的联合，比如LEFT JOIN，但是您不能把ORDER BY或LIMIT与multiple-table UPDATE同时使用。



例子：
```
update product set contactor_id=57 where id = 491294 ;
```