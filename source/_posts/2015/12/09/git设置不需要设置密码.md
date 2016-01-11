title: git设置不需要设置密码
date: 2015-12-09 17:18:35
categories:
- Git
tags:
- Git
---

-	https方式每次都要输入密码，按照如下设置即可输入一次就不用再手输入密码的困扰而且又享受https带来的极速
	
	*	设置记住密码（默认15分钟）：
		```
		git config --global credential.helper cache
		```
	*	如果想自己设置时间，可以这样做：
		```
		git config credential.helper 'cache --timeout=3600'
		```
		这样就设置一个小时之后失效
	
	*	长期存储密码：
		```
		git config --global credential.helper store
		```
		增加远程地址的时候带上密码也是可以的。(推荐)

		```
			http://yourname:password@git.oschina.net/name/project.git 
		```

-	如果你正在使用ssh而且想体验https带来的高速，那么你可以这样做： 切换到项目目录下 ：
	```
	cd projectfile/
	```
	移除远程ssh方式的仓库地址
	```
	git remote rm origin
	```
	增加https远程仓库地址
	```
	git remote add origin http://yourname:password@git.oschina.net/name/project.git
	```

-	I had similar problem (hang after successful authentication) on HP-UX with git 1.8.5.3.
I debugged it with GIT_TRACE=1:
	```
	export GIT_CURL_VERBOSE=1
	export GIT_TRACE=1
	```
and the last line before hang was:
trace: run_command: 'git-credential-cache--daemon' '/home/user_name/.git-credential-cache/socket'
so I disabled password caching:
```
git config --global --unset credential.helper
```
and the problem went away.
But now I have to type password every time :(
'/home/user_name/.git-credential-cache/socket' exists on my Ubuntu and it is a socket, but it is missing on HP-UX.
At the same time I'm having another problem related to sockets on HP-UX: vim works fine but prints warning
connect /tmp/.X11-unix/X0: No such file or directory
every time I launch it. Again, on Ubuntu "/tmp/.X11-unix/X0" exists and it is a socket but on HP-UX it does not exist. I worked around this problem by unsetting DISPLAY:
unset DISPLAY
Someone told me that rebooting HP-UX box may solve socket problems but I can't try it since it's shared server.
You may try to investigate your problem with GIT_TRACE=1.