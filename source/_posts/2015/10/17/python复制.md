title: python复制（深浅）
date: 2015-10-17 20:15:35
categories:
- Python
tags:
- Python
---

关于python list对象的使用
=============
需求
-------------
如果这时候有需求是，复制一个list对象，然后_改变这个复制的对象内容_，_原来的内容不变_，该怎么做？

使用过程
-------------
在使用python时候，一个list对象赋值给另外一个，或者是list作为参数传递给函数进行操作，这个list对象的id始终没有变化,如下：
```
In [59]: list_a = [1,2,3]

In [60]: id(list_a)
Out[60]: 47743920

In [61]: list_b = list_a

In [62]: id(list_b)
Out[62]: 47743920

In [63]: def check_list(one_list):
   ....:     print id(one_list)
   ....:     

In [64]: check_list(list_b)
47743920


```
总结
-------------
在Python中,无论你把对象作为参数传递,还是作为函数返回值,都是引用传递的.


copy库
-------------
标准库中的copy模块提供了两个方法来实现拷贝.一个方法是copy,它返回和参数包含内容一样的对象.
```
In [65]: import copy

In [66]: existing_list = [1,2,3,4]

In [67]: new_list = copy.copy(existing_list)

In [68]: id(existing_list),id(new_list)
Out[68]: (48317144, 48317576)
```
有些时候,你希望对象中的属性也被复制,可以使用deepcopy方法:
```
In [69]: new_list_deep = copy.deepcopy(existing_list)
In [70]: id(existing_list),id(new_list_deep)
Out[70]: (48317144, 47701816)

```

这时候发现，复制的list对象的地址不一样了，那么改变复制后的list内容，会发生什么？
```
In [71]: new_list
Out[71]: [1, 2, 3, 4]

In [72]: new_list[0]=2

In [73]: new_list
Out[73]: [2, 2, 3, 4]

In [74]: existing_list
Out[74]: [1, 2, 3, 4]

In [75]: new_list_deep
Out[75]: [1, 2, 3, 4]

In [76]: new_list_deep[2] = 1

In [77]: new_list_deep
Out[77]: [1, 2, 1, 4]

In [78]: existing_list
Out[78]: [1, 2, 3, 4]
```
似乎已经满足我们最初的需求了，但是如果list对象是这样的，<code>list_of_lists = [ ['a'], [1, 2], ['z', 23] ]</code>,来实验一下
```
In [85]: list_of_lists = [ ['a'], [1, 2], ['z', 23] ]

In [86]: copy_qian = copy.copy(list_of_lists)

In [87]: copy_qian[1].append("zoo")

In [88]: print list_of_lists,copy_qian,id(list_of_lists),id(copy_qian)
[['a'], [1, 2, 'zoo'], ['z', 23]] [['a'], [1, 2, 'zoo'], ['z', 23]] 46542432 48334464

```
发现原来的list里面的内容也被改变了，_其实是因为list_of_lists中有引用了其他的list，copy.copy只是浅复制。因为它们中的元素还是共享引用.

如果你希望复制一个容器对象,以及它里面的所有元素(包含元素的子元素),使用copy.deepcopy,这个方法会消耗一些时间和空间,不过,如果你需要完全复制,这是唯一的方法.

```
In [90]: list_of_lists = [ ['a'], [1, 2], ['z', 23] ]

In [91]: copy_deep = copy.deepcopy(list_of_lists)

In [92]: copy_deep.append("zoo")

In [93]: print list_of_lists,";",copy_deep,";",id(list_of_lists),";",id(copy_deep)
[['a'], [1, 2], ['z', 23]] ; [['a'], [1, 2], ['z', 23], 'zoo']; 48319664; 48333096
```

