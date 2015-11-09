title: vim之格式化代码
date: 2015-11-07 10:37:21
categories:
- Vim
tags:
- Vim
---
格式化全文： gg=G

自动缩进当前行： ==

这个是原文节选：

14.6. How do I format/indent an entire file?

You can format/indent an entire file using the gg=G command, where

     gg - Goto the beginning of the file
     =   - apply indentation
     G   - till end of file

For more information, read

     :help gg
     :help =
     :help G
     :help 'formatprg'
     :help C-indenting

 原文地址 http://hi.baidu.com/seesea8/blog/item/b96c8e51eb8f352743a75b41.html
另转：

最近在逛CSDN论坛时经常会苦恼一个问题——有些网友贴上去的代码没有用规范的格式贴上去，我贴到VIM里常常会需要手动调整格式，非常麻烦。每当这个时候就异常怀念以前用VC6.0时的ALT+F8……想下VIM作为一个程序员们最贴心的编辑器，显然不会对此坐视不理。经过一番的Search，果然就找到了一些最常用的简单技巧，笔记一下以备后来不时之需。 
VIM格式化代码： 
格式化全文指令 gg=G 
自动缩进当前行指令 == 
      格式化当前光标接下来的8行 8= 
      格式化选定的行 v 选中需要格式化的代码段 = 
      备注： 
gg —— 到达文件最开始 
= —— 要求缩进 
G     —— 直到文件尾 
注释代码：(这个原理上就是使用VIM的正则替换) 
以C++和Python为例。 
注释连续行： 
指令格式 :起始行,终止行s/要替换的字符/替换为字符/g 
如， 
      C++源文件中注释掉10~20行，指令为： 
:10,20s/^/////g 
Python源文件中注释掉10~20行，指令为： 
:10,20s/^/#/g 
取消连续行注释： 
指令格式同上。只是要替换字符与替换为字符要互换： 
如， 
      取消C++源文件中的10~20行的注释，指令为： 
:10,20s/^//////g 
取消Python源文件中的10~20行的注释，指令为： 
:10,20s/^#//g
