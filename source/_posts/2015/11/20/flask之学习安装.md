title: flask之学习安装学习1
date: 2015-11-20 16:11:19
tags:
---



1.	pip install virtualenv
2.	virtualenv ve
3.	source ve/bin/activate
4.	pip install Flask

*	第一个demo hello.py
	```
	from flask import Flask
	app = Flask(__name__)
	
	@app.route('/')
	def hello_world():
	    return 'Hello World!'
	
	if __name__ == '__main__':
	    app.run()
	```
	
	*不要使用flask.py,这会与 Flask 本身发生冲突,否则如下错误*
	```
	(ve)yann@yann-computer:~/workspace/flask_workplace/demo1$ python flask.py 
	Traceback (most recent call last):
	  File "flask.py", line 1, in <module>
	    from flask import Flask
	  File "/home/yann/workspace/flask_workplace/demo1/flask.py", line 1, in <module>
	    from flask import Flask
	ImportError: cannot import name Flask
	
	```

*	第二个demo 
	```
	from flask import Flask
	app = Flask(__name__)
	
	@app.route('/')
	def index():
	    return 'Index Page'
	
	@app.route('/hello')
	def hello():
	    return 'Hello World'
	
	@app.route('/user/<username>')
	def show_user_profile(username):
	    # show the user profile for that user
	    return 'User %s' % username
	
	@app.route('/post/<int:post_id>')
	def show_post(post_id):
	    # show the post with the given id, the id is an integer
	    return 'Post %d' % post_id
	
	if __name__ == '__main__':
	    app.run(host='127.0.0.1', port=8080,debug=True) #更改端口，debug模式
	    #app.run()
	```

现有的转换器有：
	<table>
	    <tr>
	        <td>int</td><td>接受整数</td>
		</tr>
		<tr>
			<td>float</td><td>接受浮点数</td>
		</tr>
	<tr>
			<td>path</td><td>和缺省情况相同，但也接受斜杠</td>
	    </tr>
	</table>


* 消息闪现

	[例子地址](http://dormousehole.readthedocs.org/en/latest/patterns/flashing.html#message-flashing-pattern)，消息闪现其实就是用户操作后，给用户的提示