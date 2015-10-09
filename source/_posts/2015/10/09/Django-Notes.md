title: Django Notes
date: 2015-10-09 13:39:28
categories:
- technology
tags:
- DJANGO
---

## Django Basics
### django多线程开发服务器django-devserver
  * devserver:http://pypi.python.org/pypi/django-devserver
  * django-scale-sample:http://www.slideshare.net/zeeg/djangocon-2010-scaling-disqus
  * django-tornado:http://jxq.me/2013/05/03/djangotornado/
  * django-tornado-meet:http://ultimatenerdiness.com/2012/10/14/django-and-tornado/
==== 在Django中MySQL的Composite Primary Key的实现====
  * Django不直接支持Composite Primary Key，但是可以如下实现。
    - 定义model，选择composite key中的一个作为主键。
    - 在model内部的Meta内，使用**unique_together**把composite key组织在一起。例如：<code python>
      class Test(models.Model):
          user_id = models.CharField(max_length=16, primary_key=True) # 选取user_id作为django层面的primary key
          item_id = models.CharField(max_length=16)

          class Meta:
              unique_together = ("user_id", "item_id") # (user_id, item_id)就是我们需要的composite primary key
      </code>
    - 在MySQL层面（只针对MySQL数据库），对Test这个model所对应的表重新创建： <code>
      mysql> DROP TABLE service_test; #丢弃Django syncdb创建的表
      mysql> CREATE TABLE service_test (
               user_id VARCHAR(16) NOT NULL,
               item_id VARCHAR(16) NOT NULL,
               primary key (user_id, item_id)
             ) ENGINE=InnoDB; </code>

==== 得到Current User ====
  * https://code.djangoproject.com/wiki/CookBookNewformsAdminAndUser

==== Model字段缺省值(default=) ====
  - 用例: \\ <code python>
    created_at = models.DatetimeField(default=datetime.datetime.now)
    dummy_int  = models.IntegerField(default=0) </code>
  - 原理:
    * default值并没有写入数据库的表中：如果写入数据库表中，字段//dummy_int//的定义应包含“DEFAULT 0”；但数据库表中未有体现。
    * django model在构造函数//%%__init__%%()//中设置各字段的default值:根据default=0,构造函数内就把dummy_int的值设为0.
    * 代码体现在///django/db/models/base.py//, 308-354行。
  - 如果要让default值的设置体现在数据库表上，则要做以下改动：
    * 改动文件//django/db/backends/creation.py//: <code python>
      def sql_create_model(self, model, style, known_models=set()):
          ...
          ## add the following code：
          if(f.default != models.fields.NOT_PROVIDED):
              if hasattr(f.default, '__call__'):
                  pass ## we have a little bit trouble here -- default is a python method!!!
              else:
                  field_output.append(style.SQL_KEYWORD('DEFAULT ' + f.default.__str__())) </code>
    * 什么时候需要把default值体现在数据库表中？
      - 一个简单的用列：更新数据库中记录，如果记录被修改，时间戳也会自动更新为修改记录的新时间；如果记录其他字段未被修改，时间戳不会变化。
        * 在django层面，无法达到该效果。因为每次update操作，django必须设置时间戳字段的值，这样即使数据库表中其他字段没有修改，该时间戳字段也被修改了。
        * 而在数据库表里面，只要把timestamp字段设为//default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP//则可以达到理想效果：如果其他字段没有修改，时间戳也不会变化。
    * 问题（注意！！）
      - 正如上面代码中注释那样，如果在model中定义的字段的default值为python函数，比如//datetime.datetime.now//，就难以通过代码解析来设置数据库表中的default定义。
      - 如果数据库表中对相应字段已有default配置，那么model的构造函数内就不必对该字段进行default值的设置。**所以这不是一项简单的工作，请不要轻易去尝试改动**。
    * Reference: http://www.supermind.org/blog/671/django-not-setting-default-column-value-in-mysql

==== Model主键自增 ====
  * 用例: \\ <code>
    d = models.AutoField(primary_key=True)
    这是一个自增主键(auto-incrementing primary key)如果你要指定一个自定义主键，将该字段设置为primary_key=True。如果
    Django看到你显式的设置了Field primary key，
    它将不会增加自增id字段。每个model必须有exactly one字段设置为primary_key=True.
    如显示添加自己的主键：uid = models.BigIntegerField(primary_key=True)
    则uid需要自己在程序里去赋值或去数据库将主键更改为自增，并保证满足主键要求 </code>

==== update() 方法 ====
  - 用例: <code python>
    # change User record: set status=1 for all records that have id=1;
    # return value x is the number of records that have id=1.
    x = User.objects.filter(id=1).update(status=1) </code>
  - 如果希望update()返回被更新的记录数(而不是满足filter条件的记录数),需要改变文件///django/db/backends/mysql/base.py//:
    * 源代码如下: \\ <code python>
      # We need the number of potentially affected rows after an
      # "UPDATE", not the number of changed rows.
      kwargs['client_flag'] = CLIENT.FOUND_ROWS </code>
    * 改为: \\ <code python>
      kwargs['client_flag'] = CLIENT.MULTI_RESULTS </code>

==== save() 方法 ====
  - 内部处理流程:<code>
    1) 发出一个预存信号。 它发出一个将要存储一个对象的通知。你可以注册一个监听程序，
    在信号发出的时候就会被调用。

    2) 预处理数据. 对于对象的每个字段，将根据需要进行自动的数据修改。大部分字段并不预处理
    ，它们会保持它们原来的样子。预处理仅仅用在那些有特殊性质的字段，比如文件字段。

    3) 为数据库准备数据。 每一个字段先要把当前值转化成数据库中可以保存的数据的类型。
    大多数字段的数据不需要预先准备。简单的数据类型，比如整型和字符串等python对象可以直接写进数据库。
    然而，更复杂的数据类型需要做一些修改。比如， DateFields 使用python的 datetime 对象来存储数据。
    数据库并不能存储 datetime 对象，所以该字段要存入数据库先要把值转化为符合ISO标准的日期字符串。

    4) 向数据库中插入数据。 经过预处理准备好的数据然后会组合成一条SQL语句来插入数据库。

    5) 发出存毕信号。 与预存信号类似，存毕信号在对象成功保存之后发出。同样，这些信号也还没有文档化。</code>
  - 处理原则：<code>
    1) 如果对象的主键属性被设置成相当于 True 的值（比如 None 或者空字符串之外的值），Django会执行一个 SELECT 查询来检测是否已存在一个相同主键的记录。

    2) 如果已经存在一个主键相同的记录，Django就执行 UPDATE 查询。

    3) 如果对象的主键属性 没有 被设置，或者被设置但数据库中没有与之同主键的记录，那么Django就会执行 INSERT 插入。</code>

==== 类实例序列化与反序列化 ====
  - 对于django中Model对象:<code python>
    from django.core import serializers
    serializers.serialize('json', queryset, indent=2,
    use_natural_keys=True)//序列化
    serializers.deserialize("json", sstring)//反序列化
    这种方式的反序列化后是一个DeserializeObject包装类</code>
  - 使用对于一般的复杂对象：<code python>
    import jsonpickle
    pickled = jsonpickle.encode(obj)//序列化
    unpickled = jsonpickle.decode(pickled)//反序列化
    反序列化后是一个新的类对象</code>
  - jsonpickle的安装：<code>
    先要安装pip工具:sudo apt-get install python-pip。
    然后执行命令：pip install -U jsonpickle。</code>
  - 参考：[[http://zhdoc.bitsrv.net/django/html/topics/serialization.html]]and[[http://jsonpickle.github.com/]]

==== django中静态文件路径配置 ====
  - 首先，在settings.py中加入一条静态路径的常量：<code python>
    STATIC_FILE_ROOT='/home/meixqhi/workspace/django/src/fbproject'
    </code>
  - 其次，在urls.py文件中加入以下内容:<code python>
    from settings import STATIC_FILE_ROOT
    (r'^static/(?P<path>.*)','django.views.static.serve',{'document_root': '%s/static/' % STATIC_FILE_ROOT}),
    </code>
  - 然后就可以通过以下路径来访问STATIC_FILE_ROOT路径下static目录中的静态文件了:<code>
    http://domain/apppath/static/home.html
    </code>

==== paginator ====
  *分页 <code>
   from django.core.paginator import Paginator
   from models import Weibo

   queryset = Weibo.objects.all()
   paginator = Paginator(queryset, 5)
   page = paginator.page(1)
   page.object_list</code>

==== Import module,model ====
  * 动态加载module,model：<code>
    from django.utils.importlib import import_module
    import_module(module)

    from django.db import model
    model = models.get_model('weibo', 'weibo') #(app_label,model_name)</code>

==== Signal ====
  * Signal机制 <code>
        function:
	connect(self, receiver, sender=None, weak=True, dispatch_uid=None)
	send(self, sender, **named):
	decoretor:
	receiver(signal, **kwargs):</code>
  * 使用方法：
    - 声明：<code>
	from django.dispatch import Signal
	user_logged_in = Signal(providing_args=['request', 'user'])</code>
    - 注册你要触发的方法：<code>
    def logged_status(user,access_token):
	user.is_active = True
    user_logged_in.connect(logged_status,sender=user.__class__) #sender不传参,则sender默认为None,表示响应所有的send信号 </code>
    - 在某个你要触发某个方法的地方发送消息，让这些注册的方法执行：<code>
	user_logged_in.send(sender=user.__class__, user=user, access_token=request.session.get('access_token', None))</code>
    - 如果要防止某个方法在module重复加载时也被重复监听，可以在connect方法中添加唯一的标识：dispatch_uid='my_update_blogs'
    - 由于监听方法默认状态weak=True是不保证一定会执行的，由于方法的弱引用会在资源不够的时候被垃圾回收器回收，如果一定要执行，则需显示在connect中设置weak=False。

==== 其他 ====
  * Django templates \\ <code>
    /usr/local/lib/python2.7/dist-packages/Django-1.3-py2.7.egg/django/contrib/admin/templates/admin/base_site.html </code>

===== Django Tools =====
  * python-django-lint (Static analysis tool for Django projects and applications)
    - installation \\ <code bash>
      sudo apt-get install python-django-lint </code>
    - run \\ <code bash>
      django-lint example.py </code>
    - Reference: http://chris-lamb.co.uk/projects/django-lint/
  * Debug django memory leak
    - http://blog.mfabrik.com/2008/03/07/debugging-django-memory-leak-with-trackrefs-and-guppy/

===== Django Deployment =====
  - Install //libapache2-mod-wsgi//: \\ <code>
    sudo apt-get install libapache2-mod-wsgi </code>
  - Suppose you have django project //system// under directory ///srv/internals//: <code>
    cd /srv/internals/system
    mkdir apache </code>
  - Create file //django.wsgi// under directory //apache//, the file contains: <code python>
    import os
    import sys

    path = '/srv/internals'
    if path not in sys.path:
        sys.path.append(path)
        sys.path.append(path+"/system")

    os.environ['DJANGO_SETTINGS_MODULE'] = 'system.settings'

    import django.core.handlers.wsgi
    application = django.core.handlers.wsgi.WSGIHandler() </code>
  - Edit // /etc/apache2/httpd.conf//, adding the following: \\ <code bash>
    Alias /system/media /srv/internals/system/media/   # make sure directory 'media' exists
    Alias /system/static /srv/internals/system/static/ # make sure directory 'static' exists

    <Directory /srv/internals/system/media>
        AllowOverride All
        Order deny,allow
        Allow from all
    </Directory>

    <Directory /srv/internals/system/static>
        Order deny,allow
        Allow from all
    </Directory>

    WSGIScriptAlias /internal /srv/internals/system/apache/django.wsgi

    <Directory /srv/internals/system/apache>
        Order deny,allow
        Allow from all
    </Directory> </code>
  - Edit ///srv/internals/system/settings.py//: <code bash>
    MEDIA_ROOT = '/srv/internals/system/media/'
    MEDIA_URL = '/system/media/' # http://<your_domain>/system/media points to /srv/internals/system/media
    STATIC_ROOT = '/srv/internals/system/static/'
    STATIC_URL = '/system/static/'
    ADMIN_MEDIA_PREFIX = '/system/static/admin/'
    ROOT_URLCONF = 'system.urls' </code>
  - Visit the django project via http: <code>
    http://<your_domain>/internal/admin/
    http://<your_domain>/internal/<app_name> # visit application with name "app_name"</code>
  - **Keep Admin Style**: \\ <code>
    cd /srv/internals/system/static/admin/
    cp -rf /usr/local/lib/python2.7/dist-packages/Django-1.3-py2.7.egg/django/contrib/admin/media/* .
    or
    cp -rf /usr/local/lib/python2.7/dist-packages/django/contrib/admin/media/* . </code>
  - **Unicode Decoding Error**: (uploading file and filename has //non-ascii// characters) add the following to ///etc/apache2/envvars//: <code bash>
    export LANG='en_US.UTF-8'
    export LC_ALL='en_US.UTF-8' </code>
  - Debug with apache: <code>
    apache2ctl -k restart # with root
    tail -f /var/log/apache/error.log </code>

===== Django DB Schema Migration with South =====
====  For Django < 1.7   ====
  * 往Django App //tagtex.qpoints// 的表内增加一个字段：
    - 初始化: <code>
      python manage.py schemamigration tagtex.qpoints --initial
      (如果APP执行过syncdb操作，需要执行以下操作： python manage.py migrate tagtex.qpoints --fake )</code>
    - 修改表，增加字段
    - 进行migration: <code>
      python manage.py schemamigration tagtex.qpoints --auto
      python manage.py migrate tagtex.qpoints </code>

====  For Django > 1.7   ====
  * south 操作命令:<code>
  $ python manage.py makemigrations [appname]
  $ python manage.py migrate [appname]
  </code>
===== Django Developement Tips =====
    http://ericholscher.com/blog/2008/oct/5/django-tips/

===== django-middleware =====
  * django 中间件
  * 编写自己的中间件需要实现下面一个或几个方法：
    - process_request(self, request)：返回None或HttpResponse。
    - process_view(self, request, view_func, view_args, view_kwargs)：djangoview处理中间件返回None或HttpResponse。
    - process_exception(request, e):该中间件对业务处理方法执行未捕获的异常进行处理。
    - process_template_response(request, response):如果返回的TemplateResponse含有可执行的render方法，则该中间件生效。
    - process_response(self, request, response):返回HttpResponse。
  * 参考：https://docs.djangoproject.com/en/1.3/topics/http/middleware/
  * code参考django源代码：django/core/handlers/base.py中get_response

===== django-profile-middleware =====
  * profile是一款能够记录程序方法或请求在运行过程调用了多少其他方法，以及每个方法消耗了多少时间及系统资源的python工具
  * 使用步骤：
    - 先安装 python-profiler <code>
      sudo apt-get install python-profiler</code>
    - 创建ProfileMiddleware类,参考：http://djangosnippets.org/snippets/605/
    - 将类路径名加入settings.py里的MIDDLEWARE_CLASSES中 <code>
      MIDDLEWARE_CLASSES = (
        'tagtex.base.middleware.ProfileMiddleware',
        )</code>
    - 运行server，发送请求 <code>
       如http://<yourserver>/yoururl/?prof&params </code>

===== mockserver =====
  * mockserver的主要功能是通过代理记录上次请求的状态并保存，并为下次请求返回相同的结果。
  * 使用步骤：
    - 先安装mock_server <code>
      git+ssh://git@s2/django-mock-server.git#egg=django-mock-server (也可以直接下载)</code>
    - 然后将recorder app添加到settings.py的INSTALLED_APPS中 <code>
      INSTALLED_APPS = (
          'mock_server.recorder'
        )</code>
    - 设置代理url <code>
         from django.conf.urls.defaults import patterns, include, url
         from mock_server.recorder.views import RecordView,PlaybackView
         from mock_server.recorder.recorder import Recorder
         SITE_API_ENDPOINT = '你要访问的站点域名或http://ip:port'

         recorder = Recorder(format='http://localhost:8000%s')

         urlpatterns = patterns('',

             url(r'^(?P<url>.*)$', RecordView.as_view(recorder=recorder,proxy_format='%s/%%s'%SITE_API_ENDPOINT),name='site_api'),
             #url(r'^(?P<url>.*)$', PlaybackView.as_view(recorder=recorder,proxy_format='%s/%%s'%SITE_API_ENDPOINT),name='site_api'),
         )</code>
    - 使用前先使用第一条url，RecordView，注释掉第二条，启动服务器，将你要mock的所有请求都先都由mockserver来代理，mockserver会将所有请求都记录保存到数据库。
    - 然后再打开第二条url，Playback回放，注释掉第一条，所有请求都会返回之前一样的结果。

===== User Profile =====
  * If you'd like to store additional information related to your users, Django provides a method to specify a site-specific related model -- termed a "user profile" -- for this purpose
    * Reference: https://docs.djangoproject.com/en/dev/topics/auth/#auth-profiles

===== Override Runserver Command ====
  * To override **runserver** Command, add the following to into //management/commands/runnserver.py//: <code python>
class Command(BaseRunserverCommand):
    option_list = BaseRunserverCommand.option_list + (
        make_option('--adminmedia', dest='admin_media_path', default='',
            help='Specifies the directory from which to serve admin media.'),
    )

    """
    Change the runserver default port to 9000. The method can be generically applied if
    the default port needs to be changed.
    """
    def handle(self, addrport="9000", *args, **options):
        super(Command, self).handle(addrport, *args, **options)

    def get_handler(self, *args, **options):
        """
        Serves admin media like old-school (deprecation pending).
        """

        handler = super(Command, self).get_handler(*args, **options)
        return AdminMediaHandler(handler, options.get('admin_media_path', ''))
    </code>
  * Writing custom django-admin commands: https://docs.djangoproject.com/en/dev/howto/custom-management-commands/
  * Problem: after override runserver command, static files wont be automatically handled with "STATICFILES_DIR" setting variable. To handle static files, add the following code into the top level //urls.py//: <code python>
    (r'^site_media/(?P<path>.*)$', 'django.views.static.serve',
        {'document_root': settings.STATIC_DOC_ROOT}) </code>
  * How to server static files: https://docs.djangoproject.com/en/1.2/howto/static-files/
==== django replication master/slave ====
  * django_replicated toollib:
    - Install django_replicated distribution using "python setup.py install".
    - In settings.py configure your master and slave databases in a standard way:<code>

    DATABASES {
        'default': {
    	# ENGINE, HOST, etc.
        },
        'slave1': {
    	# ENGINE, HOST, etc.
        },
        'slave2': {
    	# ENGINE, HOST, etc.
        },
    }</code>
    - Teach django_replicated which databases are slaves:<code>

    DATABASE_SLAVES = ['slave1', 'slave2']
    The 'default' database is always treated as master.</code>
    - Configure a replication router:<code>

    DATABASE_ROUTERS = ['django_replicated.ReplicationRouter']</code>
    - Configure timeout to exclude a database from the available list after an unsuccessful ping:<code>

    DATABASE_DOWNTIME = 20
    The default downtime value is 60 seconds.</code>
  * 参考：https://github.com/isagalaev/django_replicated

==== 数据导入导出 ====
  * 数据导出:<code>
    python manage.py dumpdata logistics.LogisticsCompany --indent=2 --format=json --natural >fixtures/initial_logistics_company.json
    </code>
  * 数据导入:<code>
    python manage.py loaddata fixtures/initial_logistics_company.json
    </code>
==== 多个queryset 合并成一个 ====
  * <code python>
from itertools import islice, chain

class QuerySetChain(object):
    """
    Chains multiple subquerysets (possibly of different models) and behaves as
    one queryset.  Supports minimal methods needed for use with
    django.core.paginator.
    """

    def __init__(self, *subquerysets):
        self.querysets = subquerysets

    def count(self):
        """
        Performs a .count() for all subquerysets and returns the number of
        records as an integer.
        """
        return sum(qs.count() for qs in self.querysets)

    def _clone(self):
        "Returns a clone of this queryset chain"
        return self.__class__(*self.querysets)

    def _all(self):
        "Iterates records in all subquerysets"
        return chain(*self.querysets)

    def __getitem__(self, ndx):
        """
        Retrieves an item or slice from the chained set of results from all
        subquerysets.
        """
        if type(ndx) is slice:
            return list(islice(self._all(), ndx.start, ndx.stop, ndx.step or 1))
        else:
            return islice(self._all(), ndx, ndx+1).next()
  </code>
==== django批量添加和更新 ====
  * django insert&update:<code python>
def insert_many(objects, using="default"):
    """Insert list of Django objects in one SQL query. Objects must be
    of the same Django model. Note that save is not called and signals
    on the model are not raised."""
    if not objects:
        return

    import django.db.models
    from django.db import connections
    con = connections[using]

    model = objects[0].__class__
    fields = [f for f in model._meta.fields if not isinstance(f, django.db.models.AutoField)]
    parameters = []
    for o in objects:
        parameters.append(tuple(f.get_db_prep_save(f.pre_save(o, True), connection=con) for f in fields))

    table = model._meta.db_table
    column_names = ",".join(con.ops.quote_name(f.column) for f in fields)
    placeholders = ",".join(("%s",) * len(fields))
    con.cursor().executemany(
        "insert into %s (%s) values (%s)" % (table, column_names, placeholders),
        parameters)

def update_many(objects, fields=[], using="default"):
    """Update list of Django objects in one SQL query, optionally only
    overwrite the given fields (as names, e.g. fields=["foo"]).
    Objects must be of the same Django model. Note that save is not
    called and signals on the model are not raised."""
    if not objects:
        return

    import django.db.models
    from django.db import connections
    con = connections[using]

    names = fields
    meta = objects[0]._meta
    fields = [f for f in meta.fields if not isinstance(f, django.db.models.AutoField) and (not names or f.name in names)]

    if not fields:
        raise ValueError("No fields to update, field names are %s." % names)

    fields_with_pk = fields + [meta.pk]
    parameters = []
    for o in objects:
        parameters.append(tuple(f.get_db_prep_save(f.pre_save(o, True), connection=con) for f in fields_with_pk))

    table = meta.db_table
    assignments = ",".join(("%s=%%s"% con.ops.quote_name(f.column)) for f in fields)
    con.cursor().executemany(
        "update %s set %s where %s=%%s" % (table, assignments, con.ops.quote_name(meta.pk.column)),
        parameters)
    </code>

===== Troubles =====
  * mysql_config not found: <code>
    sudo apt-get install libmysqlclient-dev python-dev </code>
  * 安装 lxml时候提示：bin/sh: 1: xslt-config: not found<code>
    ** make sure the development packages of libxml2 and libxslt are installed **
    apt source.list使用官方源：sudo apt-get install libxslt-dev
    </code>
  * 使用django.db.connection.cursor时注意事项:<code>
    如果有多个操作，比如update，delete，insert，则操作后需要提交,代码如下:
    from django.db import connection,transaction
    cursor = connection.cursor()
    cursor.execute(delete_sql or update_sql or insert_sql)
    transaction.commit_unless_managed()
    </code>
