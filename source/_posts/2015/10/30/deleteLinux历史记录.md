title: deleteLinux历史记录
date: 2015-10-30 16:03:07
categories:
- Linux
tags:
- Linux
---

![GEEK](http://huangyan.qiniudn.com/geek.jpg?imageMogr2/thumbnail/300x200 "GEEK")

删除Linux系统下history记录的方法
=================

 
入侵时目标如果是linux服务器，看切忌清理痕迹的时候别忘记history命令的记录哦 
 
1. 修改/etc/profile将HISTSIZE=1000改成0或1 
 
清除用户home路径下。bash_history 
 
2. 立即清空里的history当前历史命令的记录 
```
history -c 
```
 
3. bash执行命令时不是马上把命令名称写入history文件的，而是存放在内部的buffer中，等bash退出时会一并写入。 
 
不过，可以调用'history -w'命令要求bash立即更新history文件。 
```
history -w
```