title: pre 使用
date: 2015-10-15 11:55:40
categories:
- 前端
tags:
- html
---

问题描述
===========
今天遇到一个问题，在table td中使用pre标签后，整个td被撑宽了，设置了td 和pre 的宽度也不起作用，代码如下：
```
<td>
    <pre>1234567890123456789012345678901234567890</pre>
</td>
```
于是乎，上网找解决方法

这是参考链接 [segmentfault](http://segmentfault.com/q/1010000000271095) [stackoverflow](http://stackoverflow.com/questions/17408815/fieldset-resizes-wrong-appears-to-have-unremovable-min-width-min-content/17863685#17863685).

1、fieldset或者td的设置宽度以后，为何会被撑宽？
-----------

fieldset在没有内部元素时，是以block方式解析的，即外部100%宽度自适应；但设置width以后，本应当维持这个宽度了，为何会被撑宽呢？

因为它的min-width属性，在CSS的属性的权重中，min-width > width，在chrome里面：
```
fieldset { min-width: -webkit-min-content; }
```
改变它的min-width就可以，复写它的值，或者改为inherit（考虑到是手机端开发，inherit是全支持的）都可以。
```
fieldset { min-width: inherit; }
/*or*/
fieldset { min-width: 100px; }
```



2、pre元素为何会自动撑宽?
-----------

因为其white-space属性：
```
pre { white-space: pre; }
```
pre的语义既是预保留格式，这意味着（外部标签无法决定pre标签的宽度，pre标签自动包裹内部的文本节点，不忽略空白//有误，见下）。

pre标签的宽度是由如下机制进行的：

在内部内容不宽过父容器时，其宽度自适应于父容器；
在内部内容比父容器宽的时候，其宽度包裹内部内容。
这个机制类似于min-width，但比min-width还多了对于换行/空白符的处理，下面是w3school对于white-space属性值的解释：
```
normal  默认。空白会被浏览器忽略。
pre 空白会被浏览器保留。其行为方式类似 HTML 中的 <pre> 标签。
nowrap  文本不会换行，文本会在在同一行上继续，直到遇到 <br> 标签为止。
pre-wrap    保留空白符序列，但是正常地进行换行。
pre-line    合并空白符序列，但是保留换行符。
inherit 规定应该从父元素继承 white-space 属性的值。
```
把white-space改为除了nowrap和pre以外的值即可符合你的要求。不过我想问，__你真的需要修改pre标签的默认行为吗？__改变pre标签的默认行为，即意味着你放弃了pre标签的原本语义。

所以我们看看撑宽的路线：

pre内部文本节点宽度—(<icode>white-space:pre</icode>撑宽机制)—>pre宽度—(<icode style="color: #c7254e;">min-width</icode>自动包裹内部内容撑宽机制)—>fieldset宽度。

而我们想要的自适应宽度的路线：

fieldset宽度—(定宽机制)—>pre宽度—(<icode>white-space:非pre/非nowrap排版</icode>)—>pre内部文本节点宽度。

所以，有两种解决方案：

* 破坏fieldset的min-width包裹机制，破坏pre的white-space撑宽机制，放弃pre标签的语义。
* 破坏fieldset的min-width包裹机制，保留pre的white-space撑宽机制，给外层加上overflow，如下：
```
    fieldset {
      overflow:scroll;
      -webkit-overflow-scrolling:touch;
      -moz-overflow-scrolling:touch;
      -o-overflow-scrolling:touch ;
    }
```

