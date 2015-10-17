title: python 问题
date: 2015-10-13 14:19:59
categories:
- python
tags:
- python
---

IndentationError: unindent does not match any outer indentation level
=============
问题描述
-------------
一个python脚本，本来都运行好好的，然后写了几行代码，而且也都确保每行都对齐了，但是运行的时候，却出现语法错误
![Error pic](http://huangyan.qiniudn.com/tab_error.png)
解决方法
-------------
缩进问题，特别是把几个不同的源码拷到一块修改调式的时候容易遇到，因为两个人写的程序缩进可能不一样，有的是tab，有的是空格，这用肉眼很难察觉。把缩进都改为一种格式就可以了。


xxx  is not JSON serializable
=============
在使用json的时候经常会遇到xxx  is not JSON serializable，也就是无法序列化某些对象。经常使用django的同学知道django里面有个自带的Encoder(<code>from django.core.serializers.json import DjangoJSONEncoder</code>)来序列化时间等常用的对象。其实我们可以自己定定义对特定类型的对象的序列化，下面看下怎么定义和使用的。
```
#!/usr/bin/env python
# -*- coding: utf-8 -*-
#json_extention
#2014-03-16
#copyright: orangleliu
#license: BSD

'''
python中dumps方法很好用，可以直接把我们的dict直接序列化为json对象
但是有的时候我们加了一些自定义的类就没法序列化了，这个时候需要
自定义一些序列化方法

参考：
http://docs.python.org/2.7/library/json.html

例如:
In [3]: from datetime import  datetime

In [4]: json_1 = {'num':1112, 'date':datetime.now()}

In [5]: import json

In [6]: json.dumps(json_1)
---------------------------------------------------------------------------
TypeError								 Traceback (most recent call last)
D:\devsofts\python2.7\lib\site-packages\django\core\management\commands\shell.py
c in <module>()
----> 1 json.dumps(json_1)

TypeError: datetime.datetime(2014, 3, 16, 13, 47, 37, 353000) is not JSON serial
izable
'''
```
```
from datetime import datetime
import json

class DateEncoder(json.JSONEncoder ):
  def default(self, obj):
    if isinstance(obj, datetime):
      return obj.__str__()
    return json.JSONEncoder.default(self, obj)

json_1 = {'num':1112, 'date':datetime.now()}
print json.dumps(json_1, cls=DateEncoder)

'''
输出结果：

PS D:\code\python\python_abc> python .\json_extention.py
{"date": "2014-03-16 13:56:39.003000", "num": 1112}
'''
```
```
#我们自定义一个类试试

class User(object):
   def __init__(self, name):
    self.name = name

class UserEncoder(json.JSONEncoder):
  def default(self, obj):
    if isinstance(obj, User):
      return obj.name
    return json.JSONEncoder.default(self, obj)

json_2 = {'user':User('orangle')}
print json.dumps(json_2, cls=UserEncoder)

'''
PS D:\code\python\python_abc> python .\json_extention.py
{"date": "2014-03-16 14:01:46.738000", "num": 1112}
{"user": "orangle"}

'''
```