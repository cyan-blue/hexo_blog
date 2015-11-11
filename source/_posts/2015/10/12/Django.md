title: Django 问题收集
date: 2015-10-12 16:46:06
categories:
- Django
tags:
- Django
- Error
---

need string or buffer, long found
=============
今天给 Django 设计模型时, 把模型的 __unicode__() 函数设计成返回 id, 结果出现了
coercing to Unicode: need string or buffer, long found

感觉很奇怪. 总是提个醒吧, 不要妄图用 __unicode__() 得到 id.
不过 unicode(id) 应该是可以的吧.

Site matching query does not exist.
==============

If you don't have a site defined in your database and django wants to reference it, you will need to create one.
```
From a python manage.py shell :

from django.contrib.sites.models import Site
new_site = Site.objects.create(domain='foo.com', name='foo.com')
print new_site.id
```
Now set that site ID in your settings.py to SITE_ID