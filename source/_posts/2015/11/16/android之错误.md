title: android之androidStudio错误
date: 2015-11-16 10:52:57
tags:
- android
- 错误收集
---
android studio 报错 already disposed module:app
--------------
重启android studio

Android studio 中导入`import org.apache.http`
----------------
build.gradle中添加
```
android {
    useLibrary 'org.apache.http.legacy'
}
```