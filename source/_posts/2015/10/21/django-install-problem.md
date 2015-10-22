title: 项目问题汇总
date: 2015-10-21 10:52:45
categories:
- django
- ubuntu
tags:
- django
---

安装django项目问题汇总
============

environmenterror mysql_config not found
------------
```
sudo apt-get install libmysqlclient-dev

sudo apt-get install mysql-server

sudo apt-get install libmysqld-dev
```
pip 超时
------------
建个文件 ~/.pip/pip.conf, 内容如下
```
[global]
timeout = 6000
index-url = http://b.pypi.python.org/simple
[install]
use-mirrors = true
mirrors = http://b.pypi.python.org
trusted-host = pypi.douban.com
```

或者尝试下 v2ex 的源
```

[global]
index-url = http://pypi.v2ex.com/simple
```

Installing lxml in virtualenv via pip install error: command 'x86_64-linux-gnu-gcc' failed
--------------------
安装这些依赖，我在ubuntu 15.10上是有效的
```
sudo apt-get install libxml2-dev libxslt1-dev
```

valueerror --enable-jpeg request but jpeg not found
--------------------
```
sudo apt-get install libjpeg-dev
```

django下运行报"SyntaxError: Non-ASCII character
--------------
未找到解决方法，网上找的在头部加coding：utf-8的不属于我这个问题

ubuntu 源的问题
==============

1、安装软件时候，找不到软件包
-------------
<B>问题描述:</B>
E: 未发现软件包 ****

<B>解决方法:</B>
```
sudo apt-get update
```

2、无法更新系统软件
--------------
<B>问题描述:</B>Some index files failed to download. They have been ignored, or old ones used instead after apt-get update

这是参考链接 [askubuntu](http://askubuntu.com/questions/329450/e-some-index-files-failed-to-download-they-have-been-ignored-or-old-ones-used) .

<B>解决方法:</B>
```
sudo cp /etc/apt/sources.list ~/   #备份
sudo wget "http://pastebin.com/raw.php?i=uzhrtg5M" -O /etc/apt/sources.list #替换
sudo apt-get update #更新
sudo rm /etc/apt/sources.list.d/ubuntu-extras.list
sudo apt-get update
```
This solution is not general. It is specific to the sources.list file of the Original Poster.

The second command which starts with wget downloads and replaces the sources.list file with a specific for Precise (Ubuntu 12.04,我的是ubuntu14.10) sources.list file. See the file in raw format by visiting this [page](http://pastebin.com/raw.php?i=uzhrtg5M).

The fourth command removes the ubuntu-extras.list file which had an impact/conflict with another file of the same, so we removed it to avoid the error
```
W: Duplicate sources.list entry
```