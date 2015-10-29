title: linux 使用集锦
date: 2015-10-14 10:54:54
categories:
- Linux
tags:
- Linux
---
![一起使用linux](http://huangyan.qiniudn.com/linux.jpg?imageMogr2/thumbnail/600x400 "一起使用linux")



GREP
=============
问题
-------------
grep 搜索时忽略 目录
在整个项目搜索某个关键字的时候，有些目录或者文件需要排除掉，我们可以采用以下方法：
讲解
-------------
首先可以grep --help，来查看使用说明
``` bash
grep --help
用法: grep [选项]... PATTERN [FILE]...
在每个 FILE 或是标准输入中查找 PATTERN。
默认的 PATTERN 是一个基本正则表达式(缩写为 BRE)。
例如: grep -i 'hello world' menu.h main.c

正则表达式选择与解释:
  -E, --extended-regexp     PATTERN 是一个可扩展的正则表达式(缩写为 ERE)
  -F, --fixed-strings       PATTERN 是一组由断行符分隔的定长字符串。
  -G, --basic-regexp        PATTERN 是一个基本正则表达式(缩写为 BRE)
  -P, --perl-regexp         PATTERN 是一个 Perl 正则表达式
  -e, --regexp=PATTERN      用 PATTERN 来进行匹配操作
  -f, --file=FILE           从 FILE 中取得 PATTERN
  -i, --ignore-case         忽略大小写
  -w, --word-regexp         强制 PATTERN 仅完全匹配字词
  -x, --line-regexp         强制 PATTERN 仅完全匹配一行
  -z, --null-data           一个 0 字节的数据行，但不是空行

杂项:
  -s, --no-messages         不显示错误信息
  -v, --invert-match        选中不匹配的行
  -V, --version             显示版本信息并退出
      --help                显示此帮助并退出
      --mmap                忽略向后兼容性

输出控制:
  -m, --max-count=NUM       NUM 次匹配后停止
  -b, --byte-offset         输出的同时打印字节偏移
  -n, --line-number         输出的同时打印行号
      --line-buffered       每行输出清空
  -H, --with-filename       为每一匹配项打印文件名
  -h, --no-filename         输出时不显示文件名前缀
      --label=LABEL         将LABEL 作为标准输入文件名前缀
  -o, --only-matching       只显示一行中匹配PATTERN 的部分
  -q, --quiet, --silent     不显示所有输出
      --binary-files=TYPE   假定二进制文件的TYPE 类型；
                            TYPE 可以是`binary', `text', 或`without-match'
  -a, --text                等同于 --binary-files=text
  -I                        等同于 --binary-files=without-match
  -d, --directories=ACTION  操作目录的方式；
                            ACTION 可以是`read', `recurse',或`skip'
  -D, --devices=ACTION      操作设备、先入先出队列、套接字的方式；
                            ACTION 可以是`read'或`skip'
  -R, -r, --recursive       等同于 --directories=recurse
      --include=FILE_PATTERN  只查找匹配FILE_PATTERN 的文件
      --exclude=FILE_PATTERN  跳过匹配FILE_PATTERN 的文件和目录
      --exclude-from=FILE   跳过所有除FILE 以外的文件
      --exclude-dir=PATTERN  跳过所有匹配PATTERN 的目录。
  -L, --files-without-match  只打印不匹配FILEs 的文件名
  -l, --files-with-matches  只打印匹配FILES 的文件名
  -c, --count               只打印每个FILE 中的匹配行数目
  -T, --initial-tab         行首tabs 分隔（如有必要）
  -Z, --null                在FILE 文件最后打印空字符

文件控制:
  -B, --before-context=NUM  打印以文本起始的NUM 行
  -A, --after-context=NUM   打印以文本结尾的NUM 行
  -C, --context=NUM         打印输出文本NUM 行
  -NUM                      等同于 --context=NUM
      --color[=WHEN],
      --colour[=WHEN]       使用标志高亮匹配字串；
                            WHEN 可以是`always', `never'或`auto'
  -U, --binary              不要清除行尾的CR 字符(MSDOS 模式)
  -u, --unix-byte-offsets   当CR 字符不存在，报告字节偏移(MSDOS 模式)

‘egrep’即‘grep -E’。‘fgrep’即‘grep -F’。
直接使用‘egrep’或是‘fgrep’均已不可行了。
不带 FILE 参数，或是 FILE 为 -，将读取标准输入。如果少于两个 FILE 参数
就要默认使用 -h 参数。如果选中任意一行，那退出状态为 0，否则为 1；
如果有错误产生，且未指定 -q 参数，那退出状态为 2。

请将错误报告给: bug-grep@gnu.org
GNU Grep 主页: <http://www.gnu.org/software/grep/>
GNU 软件的通用帮助: <http://www.gnu.org/gethelp/>

```

例子
-----------
```
grep wait_post_num -rn ./ --exclude-dir="fixtures"
```
配置
-----------
如果每次都输入--exclude-dir=参数，是不是很慢还容易出错，降低效率呢?
不过不用担心，我们可以把--exclude-dir=参数通过加入配置文件 ~/.bashrc (这是bash的当前用户配置文件) 的方法来简化操作，提高效率。

在~/.bashrc文件的末尾添加以下命令：
```
export GREP_OPTIONS="--exclude-dir=**"
```
然后保存，执行source ~/.bashrc或者. ~/.bashrc，使修改起作用。


find
============
```
find ./ -name "*file_name*" 从当前目录查找文件中包含这个字段的文件
```

查看文件大小和文件夹大小
===============
df 说明
------------------
df命令可以显示目前所有文件系统的可用空间及使用情形
	
	```
	yann@Computer:~$ df --help
	用法：df [选项]... [文件]...
	显示每个文件所在的文件系统的信息，默认是显示所有文件系统。
	
	长选项必须使用的参数对于短选项时也是必需使用的。
	  -a, --all		包含虚拟文件系统
	  -B, --block-size=大小	使用指定字节数的块。例如-BM 以 1,248,576
				字节为单位显示大小。参看SIZE 格式。      --total		显示总计信息
	  -h, --human-readable	以可读性较好的格式显示尺寸(例如：1K 234M 2G)
	  -H, --si		计算时使用1000 为基底而非1024
	  -i, --inodes		显示inode 信息而非块使用量
	  -k			即--block-size=1K
	  -l, --local		只显示本机的文件系统
	      --no-sync		取得使用量数据前不进行同步动作(默认)
	  -P, --portability	使用POSIX 兼容的输出格式
	      --sync		取得使用量数据前先进行同步动作
	  -t, --type=类型	只显示指定文件系统为指定类型的信息
	  -T, --print-type	显示文件系统类型
	  -x, --exclude-type=类型	只显示文件系统不是指定类型信息
	  -v			(忽略)
	      --help		显示此帮助信息并退出
	      --version		显示版本信息并退出
	
	所显示的数值是来自 --block-size、DF_BLOCK_SIZE、BLOCK_SIZE 
	及 BLOCKSIZE 环境变量中第一个可用的 SIZE 单位。
	否则，默认单位是 1024 字节(或是 512，若设定 POSIXLY_CORRECT 的话)。
	
	SIZE 可以是一个可选的整数，后面跟着以下单位中的一个：
	KB 1000，K 1024，MB 1000*1000，M 1024*1024，还有 G、T、P、E、Z、Y。
	
	请向bug-coreutils@gnu.org 报告df 的错误
	GNU coreutils 的主页：<http://www.gnu.org/software/coreutils/>
	GNU 软件一般性帮助：<http://www.gnu.org/gethelp/>
	请向<http://translationproject.org/team/zh_CN.html> 报告df 的翻译错误
	要获取完整文档，请运行：info coreutils 'df invocation'
	```
例子
-----------

1. df
	```
	yann@Computer:~$ df
	文件系统           1K-块     已用     可用 已用% 挂载点
	/dev/sda3      117985604 41013568 70972012   37% /
	udev             4022384        4  4022380    1% /dev
	tmpfs             806388     1144   805244    1% /run
	none                5120        0     5120    0% /run/lock
	none             4031940   169732  3862208    5% /run/shm
	```
2. df -h 以可读性较好的格式显示尺寸
	```
	yann@Computer:~$ df -h
	文件系统        容量  已用  可用 已用% 挂载点
	/dev/sda3       113G   40G   68G   37% /
	udev            3.9G  4.0K  3.9G    1% /dev
	tmpfs           788M  1.2M  787M    1% /run
	none            5.0M     0  5.0M    0% /run/lock
	none            3.9G  168M  3.7G    5% /run/shm
	
	```
du 说明
---------------
du：查询文件或文件夹的磁盘使用空间

```
yann@Computer:~$ du --help
用法：du [选项]... [文件]...
　或：du [选项]... --files0-from=F
计算每个文件的磁盘用量，目录则取总用量。

长选项必须使用的参数对于短选项时也是必需使用的。
  -a, --all		输出所有文件的磁盘用量，不仅仅是目录
      --apparent-size	显示表面用量，而并非是磁盘用量；虽然表面用量通常会
			小一些，但有时它会因为稀疏文件间的"洞"、内部碎
			片、非直接引用的块等原因而变大。
  -B, --block-size=大小	使用指定字节数的块。例如-BM 以 1,048,576
			字节为单位显示大小。参看SIZE 格式。  -b, --bytes		等于--apparent-size --block-size=1
  -c, --total		显示总计信息
  -D, --dereference-args	解除命令行中列出的符号连接
      --files0-from=F	计算文件F 中以NUL 结尾的文件名对应占用的磁盘空间
			如果F 的值是"-"，则从标准输入读入文件名
  -H			等于--dereference-args (-D)
  -h, --human-readable	以可读性较好的方式显示尺寸(例如：1K 234M 2G)
      --si		类似-h，但在计算时使用1000 为基底而非1024
  -k			等于--block-size=1K
  -l, --count-links	如果是硬连接，就多次计算其尺寸
  -m			等于--block-size=1M
  -L, --dereference	找出任何符号链接指示的真正目的地
  -P, --no-dereference	不跟随任何符号链接(默认)
  -0, --null		将每个空行视作0 字节而非换行符
  -S, --separate-dirs	不包括子目录的占用量
  -s, --summarize	只分别计算命令列中每个参数所占的总用量
  -x, --one-file-system		跳过处于不同文件系统之上的目录
  -X, --exclude-from=文件	排除与指定文件中描述的模式相符的文件
      --exclude=PATTERN		排除与PATTERN 中描述的模式相符的文件
      --max-depth=N	显示目录总计(与--all 一起使用计算文件)
			当N 为指定数值时计算深度为N；
			--max-depth=0 等于--summarize
      --time		显示目录或该目录子目录下所有文件的最后修改时间
      --time=WORD	显示WORD 时间，而非修改时间：
			atime，access，use，ctime 或status
      --time-style=样式	按照指定样式显示时间(样式解释规则同"date"命令)：
			full-iso，long-iso，iso，+FORMAT
      --help		显示此帮助信息并退出
      --version		显示版本信息并退出

所显示的数值是来自 --block-size、DU_BLOCK_SIZE、BLOCK_SIZE 
及 BLOCKSIZE 环境变量中第一个可用的 SIZE 单位。
否则，默认单位是 1024 字节(或是 512，若设定 POSIXLY_CORRECT 的话)。

SIZE 可以是一个可选的整数，后面跟着以下单位中的一个：
KB 1000，K 1024，MB 1000*1000，M 1024*1024，还有 G、T、P、E、Z、Y。

```
例子
--------------
1. <code>du -h --max-depth=1 文件路径</code>
	```
	(ve)yann@Computer:~/djandgo/$ du -h --max-depth=1 ../.git
	4.0K	../.git/branches
	12K	../.git/info
	28K	../.git/refs
	35M	../.git/objects
	380K	../.git/logs
	40K	../.git/hooks
	37M	../.git
	
```