title: 项目问题汇总
date: 2015-10-21 10:52:45
categories:
- Django
- Ubuntu
tags:
- Django
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
index-url = http://pypi.douban.com/simple/
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
sudo apt-get install python-dev
sudo apt-get install libxml2-dev libxslt1-dev
```

valueerror --enable-jpeg request but jpeg not found
--------------------
```
sudo apt-get install libjpeg-dev
```

django下运行报"SyntaxError: Non-ASCII character
--------------
[pep](http://python.org/dev/peps/pep-0263/)
找了半天原因在于，没有把声明coding 的代码放在第一位

* 尝试了第一种方法，没有成功 
If you're using virtualenv you can change (or create if doesn't exist) env/lib/python2.7/sitecustomize.py and add:
```
import sys
sys.setdefaultencoding('utf-8')
```
> or, if you are in a production system, you can do the same to /usr/lib/python2.7/sitecustomize.py


error: [Errno 104] Connection reset by peer
----------------------------
网络的问题，重新试一次就好了

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

* This solution is not general. It is specific to the sources.list file of the Original Poster.
* The second command which starts with wget downloads and replaces the sources.list file with a specific for Precise (Ubuntu 12.04,我的是ubuntu14.10) sources.list file. See the file in raw format by visiting this [page](http://pastebin.com/raw.php?i=uzhrtg5M).
* The fourth command removes the ubuntu-extras.list file which had an impact/conflict with another file of the same, so we removed it to avoid the error
```
W: Duplicate sources.list entry
```
3、无法安装软件
------------
<B>问题描述:</B>
列软件包有未满足的依赖关系：
 vim : 依赖: vim-common (= 2:7.4.052-1ubuntu3) 但是 2:7.4.273-2ubuntu4 正要被安装

<B>解决方法:</B>
```
sudo apt-get remove vim-common
sudo apt-get install vim
```
4、无法安装pip
------------
<B>问题描述:</B>

the following packages have unmet dependencies:
 python-pip : Depends: python-setuptools (>= 0.6c1) but it is not going to be installed
              Recommends: python-dev-all (>= 2.6) but it is not installable
<B>解决方法:</B>
```
First remove the python-pkg-resources completely using

 sudo apt-get purge python-pkg-resources
Once completed successfully, first run

  sudo apt-get -f install
then

   sudo apt-get install python-pip
```
