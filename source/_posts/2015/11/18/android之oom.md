title: android之oom
date: 2015-11-18 19:43:42
tags:
---
oom

一种比较直接的方法，简单粗暴的解决是
在Manifest.xml文件里面的<application  里面添加android:largeHeap="true"
如：
```
<application
        android:name=".app.Application"
        android:allowBackup="true"
        android:icon="@drawable/icon"
        android:label="@string/app_name"
        android:theme="@android:style/Theme.Light.NoTitleBar"
        android:largeHeap="true"
         >
```
这种方法允许应用需要耗费手机很多的内存空间，但却是最快捷的解决办法

第二种是将bitmap.recycle()掉，需要了解加载viewpager的流程
/**
* 首先ViewPager默认加载两张图片，也就是说第一次初始化这个viewpager的时候会执行两次instantiateItem这个方法。预加载下一个viewpager的item
 */
然后方法destroyItem会将通过“算法”destroy掉，remove掉view视图
可以在里面bitmap.recycle()回收掉bitmap