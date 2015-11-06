title: mysql之1292
date: 2015-11-03 09:15:41
categories:
- Mysql
tags: 
- Mysql
---

mysql 1292错误：Warning 1292 Truncated incorrect DOUBLE value:
===================

Look at this line "where PremiseID = " + str(premiseID) + " ; "])". The comparison is happening on different types and when MySQL compares different datatypes they are cast to DOUBLE internally before comparison. So you can try putting single quote around or cast around to solve the issue. So it's not try catch but the quotes which resolve the issue.