title: django之外键的删除
date: 2015-11-10 12:04:24
categories:
- Django
- 转载
tags:
- Django
---

Django的外键使用
===============
* Django的models和底层的数据库联系很密切，models之间创建的关联，都直接映射到数据库，是真正的物理关联。

django删除外键
===============
* Django还是采用级联的删除方式，当你删除一个外键的时候，外键关联的实体也被删除，但在创建models的时候，外键增加了一个可选参数on_delete
	```
	class Blog（models.Model）:  
		user = models.ForeignKey(User, blank=True, null=True, on_delete=models.SET_NULL)
	```
	当blog对应的user被删除了，blog里的user字段会设置为空值，而不是连同blog也删除掉

* on_delete有多少个选项呢：
	-	CASCADE:这就是默认的选项，级联删除，你无需显性指定它。
	-	PROTECT: 保护模式，如果采用该选项，删除的时候，会抛出ProtectedError错误。
	-	SET_NULL: 置空模式，删除的时候，外键字段被设置为空，前提就是blank=True, null=True,定义该字段的时候，允许为空。
	-	SET_DEFAULT: 置默认值，删除的时候，外键字段设置为默认值，所以定义外键的时候注意加上一个默认值。
	-	SET(): 自定义一个值，该值当然只能是对应的实体了，看一下代码：	
		```
		def get_sentinel_user():  
		    return User.objects.get_or_create(username='deleted')[0]  
		  
		class MyModel(models.Model):  
		    user = models.ForeignKey(User, on_delete=models.SET(get_sentinel_user))
		```
		以上的代码，当删除mymodel对应的user的时候，mymodel不会删除掉，而是找到一个名叫 deleted的user，与之重建关联。

手动增加外键
===============

* 作为外键的model为（该model从数据库中自动产生）：
	
	```
	class People(models.Model):
	    name = models.TextField(primary_key=True, blank=True)  # This field type is a guess.
	    entrance_date = models.TextField(blank=True)  # This field type is a guess.
	    entrance_semester = models.TextField(blank=True)  # This field type is a guess.
	    degree = models.TextField(blank=True)  # This field type is a guess.
	    phone_number = models.TextField(blank=True)  # This field type is a guess.
	    email = models.TextField(blank=True)  # This field type is a guess.
	    qq = models.TextField(blank=True)  # This field type is a guess.
	    remarks = models.TextField(blank=True)  # This field type is a guess.
	    def __unicode__(self):
	        return self.name
	    class Meta:
	        db_table = u'people'
	```
* 另一Model(Equipment)追加一个字段：
	```
	lab_user = models.ForeignKey(People)
	```
* 数据库（sqlite3）中新加入一个字段：
	```
	alter table 'equipment' add 'lab_user_id';
	```
* 赋值：
	```
	update equipment set lab_user_id = '张山';
	```
在admin中添加外键search字段
==================
若要被search到，search_fields 中添加 lab_user__name 。