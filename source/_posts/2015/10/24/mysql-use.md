title: ubuntu 使用mysql的简单操作
date: 2015-10-24 14:21:03
categories:
- 数据库
tags:
- Mysql
---


ubuntu上安装mysql非常简单只需要几条命令就可以完成。

　　1. 'sudo apt-get install mysql-server'
 
　　2. apt-get install mysql-client
 
　　3.  sudo apt-get install libmysqlclient-dev
 
　　安装过程中会提示设置密码什么的，注意设置了不要忘了，安装完成之后可以使用如下命令来检查是否安装成功：
 
　　sudo netstat -tap | grep mysql
 
　　通过上述命令检查之后，如果看到有mysql 的socket处于 listen 状态则表示安装成功。
 
　　登陆mysql数据库可以通过如下命令：
 
　　mysql -u root -p 


create database dbname；



遇到的问题：

mysql-server : Depends: mysql-server-5.5 but it is not going to be installed
E: Unable to correct problems, you have held broken packages.

```
sudo apt-get purge mysql-client-core-5.6
sudo apt-get autoremove
sudo apt-get autoclean
sudo apt-get install mysql-client-core-5.5
sudo apt-get install mysql-server 
```
然并卵,
后面试了一下[aptitude](http://baike.baidu.com/link?url=tUAAth_0e71ZBGWOArrnufdAk3Hg3frsWXq6VsxOFIIdjP-0ngvFDV5MOdOxUf-5vZ-K-7dPMKqnQpqWeTVtLq)
后面觉得应该是源使用错误的问题，要对应相同版本的源，<code>lsb_release -a</code>查看