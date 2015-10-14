title: JavaScript 使用
date: 2015-10-12 09:20:41
categories:
- technology
tags:
- JS
---

简介
=============
JavaScript一种直译式脚本语言，是一种动态类型、弱类型、基于原型的语言，内置支持类型。它的解释器被称为JavaScript引擎，为浏览器的一部分，广泛用于客户端的脚本语言，最早是在HTML（标准通用标记语言下的一个应用）网页上使用，用来给HTML网页增加动态功能。

jQuery 事件 - bind() 方法
=============
```
$(".btn-save").bind("click", btn_save_func); //绑定btn_save_func
function btn_save_func () { console.log("func")}
$(".btn-save").unbind("click");//解绑btn_save_func
```