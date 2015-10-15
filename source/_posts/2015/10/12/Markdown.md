title: Markdown 使用
date: 2015-10-12 09:40:28
categories:
- technology
tags:
- Markdown
---
简介
=============
Markdown是一种可以使用普通文本编辑器编写的标记语言，通过简单的标记语法，它可以使普通文本内容具有一定的格式。

标题
=============
        This is an H1
        =============  第一阶标题

        This is an H2
        -------------  第二阶标题

链接
=============
Markdown 支持两种形式的链接语法： 行内式和参考式两种形式。
```
行内式:这是参考链接 [title](http://cyan-blue.github.io) .
```

强调
=============
Markdown 使用星号（*）和底线（_）作为标记强调字词的符号，被 * 或 _ 包围的字词会被转成用 <em> 标签包围，用两个 * 或 _ 包起来的话，则会被转成 <strong>，例如：
```
*single asterisks*

_single underscores_

**double asterisks**

__double underscores__
```
会转成：
```
<em>single asterisks</em>

<em>single underscores</em>

<strong>double asterisks</strong>

<strong>double underscores</strong>
```
你可以随便用你喜欢的样式，唯一的限制是，你用什么符号开启标签，就要用什么符号结束。

强调也可以直接插在文字中间：
```
un*frigging*believable
```
但是如果你的 * 和 _ 两边都有空白的话，它们就只会被当成普通的符号。

如果要在文字前后直接插入普通的星号或底线，你可以用反斜线：
```
\*this text is surrounded by literal asterisks\*
```