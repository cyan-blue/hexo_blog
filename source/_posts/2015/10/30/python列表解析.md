title: python列表解析
date: 2015-10-30 17:51:36
categories:
- Python
tags:
- Python
---


列表解析
===================
简单介绍
--------------
在一个序列的值上应用一个任意表达式，将其结果收集到一个新的列表中并返回。它的基本形式是一个方括号里面包含一个for语句对一个iterable对象迭代
```
>>> res=[ord(x) for x in 'spam']
>>> res  
[115, 112, 97, 109]  
>>> [x**2 for x in range(10)]  
[0, 1, 4, 9, 16, 25, 36, 49, 64, 81]  
```
[--ord函数](http://cyan-blue.github.io/2015/10/30/python之ord/)

增加判断语句和嵌套循环
--------------
<code style="color:green">[expression for target1 in iterable1 [if condition1]...
                      for targetn in iterablen [if conditionn] ]</code>

上面是列表解析中，任意数量嵌套的for循环同时关联可选的if 测试，其中if 表示测试语句是可选的，如果没有的话，就是我们上面的例子，注意for上下之间表示的是一个嵌套关系。
第一个是表达式，比较形式[(x,y), [0,2,4],[1,3]]与下面形式的区别
```
In [1]: [(x,y) for x in range(5) if x % 2==0 for y in range(5) if y % 2 ==1] 
Out[1]: [(0, 1), (0, 3), (2, 1), (2, 3), (4, 1), (4, 3)] 
```
map、lambda、filter的组合同样会达到一个进行测试的效果，但是如何实现嵌套我现在不太清楚
```
In [4]: list(map((lambda x:x**2),filter((lambda x:x%2==0),range(10))))  
Out[4]: [0, 4, 16, 36, 64] 
```
因为map的逻辑是每次都从后面序列中取出一个，以最少的为标准。
```
In [12]: list(map((lambda x,y:(x,y)),filter((lambda x:x%2==0),range(5)),filter((lambda y:y%2==0),range(5))))
Out[12]: [(0, 0), (2, 2), (4, 4)]

In [13]: list(map((lambda x,y:(x,y)),filter((lambda x:x%2==1),range(5)),filter((lambda y:y%2==1),range(5))))
Out[13]: [(1, 1), (3, 3)] 
```


<span style="color:red">列表解析map和列表解析是在解释器中以c语言的速度来运行，比python的for循环代码在pvm中运行要快的多。</span>
```
In [25]: open("test.txt").readlines()
Out[25]: ['aaa\n', 'bbb\n', 'ccc\n']

In [27]: [line.rstrip() for line in open("test.txt").readlines()]  #消除文件中的换行  
Out[27]: ['aaa', 'bbb', 'ccc']

In [28]: [line.rstrip() for line in open("test.txt")]
Out[28]: ['aaa', 'bbb', 'ccc']

In [29]: list(map((lambda line: line.rstrip()), open("test.txt")))
Out[29]: ['aaa', 'bbb', 'ccc']
 
```

* 第一种方式：因为readlines()方法，把整个文件都放入到内存中。然后对string进行解析
* 第二种方式：使用了文件迭代器，进行列表解析。
* 第三种方式：Map同样使用了文件迭代器，但是它不是列表解析，因为它两边不是[]引起来的。
上面二，三方式使用了迭代器，都不会一次性构建列表，所以节省了内存空间。


![python](http://huangyan.qiniudn.com/xiigua.jpg?imageMogr2/thumbnail/400x200 "python")