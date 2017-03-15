---
categories: ['MySQL']
date: 2017-03-13T18:09:55-07:00
description: wwcreator blog
menu:
- Blog
- Life
- About Me
tags: []
title: delete_duplicate_row
---

在很多时候，我们数据库里会出现重复的数据需要去重，而今天遇到很奇怪的问题？
```
delete from test
where name  in (select name from test group by name having count(*) > 1)
and test_id not in (select min(test_id) from test group by openid having count(*) > 1);

OR：

delete from test 
where test_id not in (select min(test_id) from test group by name);
```
但是，很不幸，我们得到了下面的错误。

```
ERROR 1093 (HY000): You can't specify target table 'test' for update in FROM clause
```

Why？

从错误信息来看，你不能在 FROM 定义更新的表test。那怎么办？

灵机一动，恩恩，那我加一层临时表会怎样？

```
delete from test 
where test_id not in (select id from 
			(select min(test_id) id from test group by name)
		     temp);
Query OK, 17 rows affected (0.02 sec)
```
oooh,Amazing, 但是还是不太清楚MySQL解析该SQL 的原理，后续再补充，此文作为操作记录。
