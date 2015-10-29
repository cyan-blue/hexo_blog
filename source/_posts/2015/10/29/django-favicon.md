title: Django中favicon.ico文件的配置
date: 2015-10-29 20:39:58
categories:
- Django
tags:
- Django
---

Django中favicon.ico文件的配置
=============

默认情况下，浏览器访问一个网站的时候，同时还会向服务器请求“/favicon.ico”这个URL，目的是获取网站的图标。默认情况下，Django会返回404错误的，只是这个错误不会打印出来，并且浏览器接收到这个404错误后，也无伤大雅，因为没有图标就用默认的图标，所以这个错误也没有跟通常的404错误一样在网页上显示出来。
不过我们还是应该给网站配置一个图标，这样用户体验会更好一些。
配置favicon.ico文件，可以在url.py文件中这样配置：
```
# favicon.cio
url(r'^favicon\.ico$', 'django.views.generic.simple.redirect_to', {'url':'/static/images/favicon.ico'}),
```
不过这个有个前提是在Django中，配置静态文件的支持。
 
然后在static/images目录下放一个名为favicon.ico的图片就大功告成了。


![一起使用django](http://huangyan.qiniudn.com/django-learn.png?imageMogr2/thumbnail/600x400 "一起使用django")