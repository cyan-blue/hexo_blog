title: ubuntu之装机必备
date: 2015-11-05 10:19:22
categories:
- Linux
- Ubuntu
tags:
- Linux
---
我的装机必备软件（持续更新～）
=============
* 系统
	- 更换源
	- synergy 多电脑共享
	- Lantern 
	- sudo apt-get install mysql-server
	- sudo apt-get install git
	- sudo apt-get install vim
	- sudo apt-get install curl  
	
* Node
	- 安装 Node.js
		安装 Node.js 的最佳方式是使用 nvm。
		
	- cURL:
		
		$ curl https://raw.github.com/creationix/nvm/master/install.sh | sh
	- Wget:
		
		$ wget -qO- https://raw.github.com/creationix/nvm/master/install.sh | sh
		安装完成后，重启终端并执行下列命令即可安装 Node.js。
		
	- $ nvm install 0.12.0
* virtualenv
	- sudo apt-get install python-pip # 包管理
	- pip install virtualenv

* hexo
	- npm install --unsafe-perm -g hexo-cli  
	- npm install hexo-server --save
	- npm config set user 0
	- npm config set unsafe-perm true


* sudo apt-get install ipython  #高级的交互解释器