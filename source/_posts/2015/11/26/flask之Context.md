title: flask之Context
date: 2015-11-26 11:57:19
tags:
---
```
In [1]: import threa
thread     threading  

In [1]: import threading

In [2]: storage = threading.local()

In [3]: stor
%store   storage  

In [3]: storage.foo = 1

In [4]: print sto
%store   storage  

In [4]: print stor
%store   storage  

In [4]: print storage.foo
1

In [5]: class AnotherThread(threading.T
threading.Thread       threading.ThreadError  threading.Timer

In [5]: class AnotherThread(threading.Th
threading.Thread       threading.ThreadError  

In [5]: class AnotherThread(threading.Thread):
   ...:     def run(self):
   ...:         storage.foo = 2
   ...:         print storage.foo
   ...:         

In [6]: another = AnotherThread()

In [7]: another.start()
2


In [8]: print storage.foo
1
```