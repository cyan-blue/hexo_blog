title: celeryUser
date: 2016-01-15 15:20:45
tags:
---



sudo apt-get install rabbitmq-server

$ sudo rabbitmqctl add_user myuser mypassword
$ sudo rabbitmqctl add_vhost myvhost
$ sudo rabbitmqctl set_permissions -p myvhost myuser ".*" ".*" ".*"



celery -A app.celery worker --loglevel=info


启动服务器：

$ sudo rabbitmq-server
你也可以添加 -detached 属性来让它在后台运行（注意：只有一个破折号）：

$ sudo rabbitmq-server -detached
永远不要用 kill 停止 RabbitMQ 服务器，而是应该用 rabbitmqctl 命令：

$ sudo rabbitmqctl stop


sudo rabbitmqctl list_queues
sudo rabbitmqctl list_exchanges