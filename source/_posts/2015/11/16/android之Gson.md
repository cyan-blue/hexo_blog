title: android之Gson
date: 2015-11-16 18:05:37
tags:
- android
---

Gson 嵌套使用

我们要解析一个下面这种的Json：
```
String json = {"a":"100","b":[{"b1":"b_value1","b2":"b_value2"},{"b1":"b_value1","b2":"b_value2"}]，"c":{"c1":"c_value1","c2":"c_value2"}}
```
1. 首先我们需要定义一个序列化的Bean，这里采用内部类的形式，看起来会比较清晰一些：
	```
	public class JsonBean {
	    public String a;
	    public List<B> b;
	    public C c;
	
	    public static class B {
	        public String b1;
	        public String b2;
	    }
	
	    public static class C {
	        public String c1;
	        public String c2;
	    }
	}
	```
2. 很多时候大家都是不知道这个Bean是该怎么定义，这里面需要注意几点：
	1. 内部嵌套的类必须是static的，要不然解析会出错；
	2. 类里面的属性名必须跟Json字段里面的Key是一模一样的；
	3. 内部嵌套的用[]括起来的部分是一个List，所以定义为<code>public List<B> b</code>，而只用{}嵌套的就定义为<code>public C c</code>

3. 调用的时候
	```
	Gson gson = new Gson();
	java.lang.reflect.Type type = new TypeToken<JsonBean>() {}.getType();
	JsonBean jsonBean = gson.fromJson(json, type);
	Log.v("tag",jsonBean.a.toString())
	```
	然后想拿数据就很简单啦，直接在jsonBean里面取就可以了！
	如果需要解析的Json嵌套了很多层，同样可以可以定义一个嵌套很多层内部类的Bean，需要细心的对照Json字段来定义哦。