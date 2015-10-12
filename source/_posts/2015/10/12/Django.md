title: Django 问题收集
date: 2015-10-12 16:46:06
tags:
- Django
---

need string or buffer, long found
=============
今天给 Django 设计模型时, 把模型的 __unicode__() 函数设计成返回 id, 结果出现了
coercing to Unicode: need string or buffer, long found

感觉很奇怪. 总是提个醒吧, 不要妄图用 __unicode__() 得到 id.
不过 unicode(id) 应该是可以的吧.