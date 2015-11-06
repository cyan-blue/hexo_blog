title: Linux下释放内存的方法(转载)
date: 2015-11-06 13:41:15
categories:
- Linux
- Ubuntu
tags:
- Linux
---

释放缓存原因
================
- 有些单位自动检测内存，当内存使用率在90%以上时，会报警；
- 当内存被缓存占满时，当处理一些新信息时就会使用Swap，影响性能。
 
Linux的缓存机制：Linux会针对dentry（用于VFS，加速文件路径名到inode的转换）、Buffer Cache（针对磁盘块的读写）和Page Cache（针对文件inode的读写）进行缓存操作。
 
操作步骤
=================
1. 查询当前内存使用情况和释放缓存的参数
	```
	#free -m
	#cat /proc/sys/vm/drop_caches
	```
2. 使用sync命令，将系统缓存区中的脏数据写入磁盘中，包括已修改的i-node、已延迟的块I/O和读写映射文件。
	```
	#sync
	```
3. 配置文件/proc/sys/vm/drop_caches中记录了缓存释放的参数，
	
	含义：默认0—不释放，1—释放pagecache，2—释放dentries和inodes，3—释放所有缓存
	```
	#sudo su
	#echo 3 > /proc/sys/vm/drop_caches //需要管理员权限
	```