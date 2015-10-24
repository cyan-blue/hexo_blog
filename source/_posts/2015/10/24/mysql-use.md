title: ubuntu 使用mysql的简单操作
date: 2015-10-24 14:21:03
tags:
- mysql
---


ubuntu上安装mysql非常简单只需要几条命令就可以完成。

　　1. sudo apt-get install mysql-server
 
　　2. apt-get isntall mysql-client
 
　　3.  sudo apt-get install libmysqlclient-dev
 
　　安装过程中会提示设置密码什么的，注意设置了不要忘了，安装完成之后可以使用如下命令来检查是否安装成功：
 
　　sudo netstat -tap | grep mysql
 
　　通过上述命令检查之后，如果看到有mysql 的socket处于 listen 状态则表示安装成功。
 
　　登陆mysql数据库可以通过如下命令：
 
　　mysql -u root -p 


create database dbname；