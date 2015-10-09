title: Git Use
date: 2015-10-09 11:30:39
categories:
- technology
tags:
- GIT
---


<h4><a href="http://blog.csdn.net/dale_dede/article/details/45643045/"  style="color: #408140;">Git：</a> </h4>

## Git Start
Git是目前世界上最先进的分布式版本控制系统（没有之一）。
### 查看本地分支:
```
git branch
```
### 查看远程分支:
```
git branch -r
```
### 新建branch：
```
git checkout -b abc_branch
```

### 删除分支
```
git branch -d abc_branch
```
<span style="color:#408140;">强制删除使用 -D</span>
### 切换branch
```
git checkout abc_branch
```
### 合并分支
```
git merge abc_branch
```
### 查看记录
```
git blame filename 查看该文件目前的每一行最后改动的是什么时候提交的
git log -p filename 查看这个文件所有的详细提交
```
### 查看某一个文件的所有提交记录：
```
git log --pretty=oneline 文件路径`
git log --pretty=oneline views.py
>>f850a9ef393584e49d46391897db614ed56a2903 third commit
>>0d08b578371afb8f45748a0491faa2a7820d7928 second commit
>>3fcc3973deee5c33695c0b40b18a11f83c986b2d first commit
```
### 查看某一个记录的修改内容：
```
git show 3fcc3973deee5c33695c0b40b18a11f83c986b2d
```
>例子里面打印出来的就是针对文件views.py的所有的改动历史，每一行最前面的那一长串数字就是每次提交形成的哈希值，接下来使用git show即可显示具体的某次的改动的修改

### 存储
-   ```
    git stash
    ```
    > 用来暂存当前正在进行的工作， 比如突然你想pull 最新代码， 又不想加新commit， 或者为了fix 一个紧急的bug, 先stash, 使返回到自己上一个commit, 改完bug之后再stash pop, 继续原来的工作。
-   ```
    git stash 做一些操作后
    git stash list 查看stash 列表
    git pop 将最近的一个取出，并且删除
    ```
-   > if你的stash里面有好多个，这个时候可以使用git stash list 将Git栈信息打印出来，然后git stash apply stash@{0},取出对应的，注意这个时候并没有清除，如果需要清除，git stash clear，清空

    >stash 多了，会发现list中你不知道哪一个对应的修改是什么？解决方法

    ```
    git stash save "I DO SOMETHING"
    git stash list
    >>stash@{0}: On develop: I DO SOMETHING
    git stash pop stash@{0} or git stash apply stash@{0}
     两者区别在于pop会删除stash，apply不会删除最后apply结束后，git stash clear
    ```
    **详细可以使用 git stash -help**

----------
### git pull --rebase
>当本地commit一个提交和远端服务器中的代码有冲突(别人也改了相同的文件)时可以在pull 中加 –rebase。

>加上rebase的意思是：
把本地 repo. 从上次 pull 之后的变更暂存起來
恢复到上次 pull 时的状态
合并远端的变更到本地
最后再合并刚刚暂存下來的本地变更


### 修改commit 内容
```
git commit --amend 可以修改最后一次 commit
```

1. // 查看修改
```
git rebase -i master~1 //最后一次
git rebase -i master~5 //最后五次
```
2. // 显示结果如下，修改 pick 为 edit ，并 :wq 保存退出
```
pick 92b495b 2009-08-08: ×××××××
Rebase 9ef2b1f..92b495b onto 9ef2b1f
Commands:
pick = use commit
edit = use commit, but stop for amending //改上面的 pick 为 edit
squash = use commit, but meld into previous commit
If you remove a line here THAT COMMIT WILL BE LOST.
 However, if you remove everything, the rebase will be aborted.
```
3. 命令行显示：
```
Rebasing (1/1)
You can amend the commit now, with
git commit --amend
```
4. 使用 `git commit --amend` 进行修改，完成后 :wq 退出
5. 使用 `git rebase --continue` 完成操作


----------
### 恢复文件
```
git checkout
```
git 返回到某个节点的文件

```
git checkout 1bbbb91aaf96f1274750c6fd21d77c5e7142d424 文件路径
```

### git 有用的小贴士
```
> 内建的git输出 gitk
> 彩色的git输出 git config color.ui true
> git config format.pretty oneline
```

## <span style="color:#408140;">Git 使用时候遇到的错误</span>

1. GIT CLONE ERROR
错误fatal: The remote end hung up unexpectedly
解决方案：
```
git config --global http.postBuffer 24288000
git config --list
```