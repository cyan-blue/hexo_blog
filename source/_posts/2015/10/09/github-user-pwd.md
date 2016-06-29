title: github输入用户和密码
date: 2015-10-09 21:00:20
categories:
- Git
tags:
- Git
---

## 每次git push 的时候总是要输用户名和密码的解决方法

```
git remote -v
>origin	git@github.com:cyan-blue/cyan-blue.github.io.git (fetch)
>origin	git@github.com:cyan-blue/cyan-blue.github.io.git (push)
```
下面把它换成ssh方式的。
```
git remote rm origin
git remote add origin git@github.com:cyan-blue/cyan-blue.github.io.git
git push origin
```