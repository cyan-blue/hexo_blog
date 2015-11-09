title: vim之使用
date: 2015-11-06 10:36:00
categories:
- Linux
tags:
- Linux
- Vim
---
Vim安装
=============
```
wget -qO- https://raw.github.com/ma6174/vim/master/setup.sh | sh
```
```
#!/bin/bash
echo "安装将花费一定时间，请耐心等待直到安装完成^_^"
if which apt-get >/dev/null; then
	sudo apt-get install -y vim vim-gnome ctags xclip astyle python-setuptools python-dev git
elif which yum >/dev/null; then
	sudo yum install -y gcc vim git ctags xclip astyle python-setuptools python-devel	
fi

##Add HomeBrew support on  Mac OS
if which brew >/dev/null;then
    echo "You are using HomeBrew tool"
    brew install vim ctags git astyle
fi

sudo easy_install -ZU autopep8 
sudo ln -s /usr/bin/ctags /usr/local/bin/ctags
mv -f ~/vim ~/vim_old
cd ~/ && git clone https://github.com/ma6174/vim.git
mv -f ~/.vim ~/.vim_old
mv -f ~/vim ~/.vim
mv -f ~/.vimrc ~/.vimrc_old
mv -f ~/.vim/.vimrc ~/
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
echo "ma6174正在努力为您安装bundle程序" > ma6174
echo "安装完毕将自动退出" >> ma6174
echo "请耐心等待" >> ma6174
vim ma6174 -c "BundleInstall" -c "q" -c "q"
rm ma6174
echo "安装完成"
```

Vim 使用
===============
* :Tlist  #概略图  
	- 快捷开关键 <code style="color:green">tl</code>
* :%d     #清空缓存区

* 格式化全文： gg=G

* 自动缩进当前行： ==

* 关键字搜索
	- 用/和？的区别

		/后跟查找的字符串。vim会显示文本中第一个出现的字符串。

		?后跟查找的字符串。vim会显示文本中最后一个出现的字符串。
	- 注意事项：

		不管用/还是？查找到第一个字符串后，按回车，vim会高亮所有的匹配文
		系统新氧ubuntu下默认的是incsearch模式，就是输完命令后，会自动显示第一个（或最后一个）匹配。
		如果输入：set noincsearch 会转到普通模式，不会自动显示第一个匹配，回车后显示所有匹配。
		高亮所有的匹配后，按<span style="color:red">n键</span>转到下一个匹配，按N键转到上一个匹配。

[vim 使用](https://github.com/qiwsir/vim/blob/master/tips.md)





vim 使用tip
--------------
编写python程序

自动插入头信息：
```
#!/usr/bin/env python
# coding=utf-8
```
输入.或按TAB键会触发代码补全功能

:w保存代码之后会自动检查代码错误与规范

按F6可以按pep8格式对代码格式优化
按F5可以一键执行代码
F3: documents tree
多窗口操作

* 使用:sp + 文件名可以水平分割窗口
* 使用:vs + 文件名可以垂直分割窗口
* 使用Ctrl + w可以快速在窗口间切换

编写markdown文件

编写markdown文件(*.md)的时候，在normal模式下按 md 即可在当前目录下生成相应的html文件
生成之后还是在normal模式按fi可以使用firefox打开相应的html文件预览
当然也可以使用万能的F5键来一键转换并打开预览
如果打开过程中屏幕出现一些混乱信息，可以按Ctrl + l来恢复
快速注释

按\ 可以根据文件类型自动注释