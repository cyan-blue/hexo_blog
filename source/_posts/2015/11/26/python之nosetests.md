title: python之nosetests
date: 2015-11-26 11:17:31
tags:
- test
- python
---
setup和teardown
setup:在测试用例开始时被执行
teardown:在测试用例结束后被执行
    nose在文件中如果找到函数setup, setup_module, setUp 或者setUpModule等，那么会在该模块的所有测试执行之前执行该函数。如果找到函数 teardown,tearDown, teardown_module或者 tearDownModule 等，那么会在该模块所有的测试执行完之后执行该函数。　
    对于上面的代码，nose实际的执行过程是这样的：　　
setUp()->Testfunc1()->Testfunc2()->tearDown()
    

    nose常用参数
nosetests  –v :debug模式，看到具体执行情况，推荐大家执行时用这个选项
nose会捕获标准输出，调试的print代码默认不会打印。nosetest  –s 可打开output输出，否则全部通过时不打印stdout。
默认nosetests会执行所有的case，若想单独只执行一个case，执行nosetest --tests 后跟要测试的文件(nosetests后面直接跟文件名，其实也可以直接运行该case)。
nosetests --collect-only -v :不运行程序，只是搜集并输出各个case的名称
nosetests -x  :一旦case失败立即停止，不执行后续case
-w ，指定一个目录运行测试。目录可以是相对路径或绝对路径