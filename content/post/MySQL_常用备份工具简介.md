+++
date = "2017-02-14T21:11:31-08:00"
title = "MySQL 常用备份工具简介"
categories = ['MySQL',]
tags = ["MySQL","BackUp"]
+++

# MySQL 常用的备份方式有哪些 ?
不管是MySQL, Oracle，MariaDB 等关系型数据库，还是 MongoDB，Redis 等 NoSQL 数据库，都有众所周知的`Logical Backup` &  `Physical Backup` 。

## MySQL Logical Backups
逻辑备份是按照数据库的逻辑结构（CREATE DATABASE, CREATE TABLE 语句）和内容（INSERT,分隔文本）的方式来存储。非常常用的是当属 MySQL 自带的 `mysqldump`和 `mydumper` 工具。
### mysqldump
mysqldump 支持导出部分DB，部分Table， 而且还支持 --where 行条件过滤（不支持列过滤），InnoDB引擎不锁表导出等。还支持获取导出的 Binlog position，很方便的进行PIT（point in time）recover。
```
for example:
  mysqldump -u test -p -P 3307 -h 127.0.0.1 --single-transaction --master-data=2 --database test_dump --tables test1 > /test/test_dump_test1.sql

recover：
  mysql -u test -p -P 3307 -h 127.0.0.1 -D test_dump -e "source /test/test_dump_test1.sql" >import.log 2>&1
```
PS: MySQL 5.7.11 版本引入 mysqlpump 工具，支持多线程（粒度到表级别），压缩导入导出。
mysqlpump的并行导出功能的架构为：队列+线程，允许有多个队列，每个队列下有多个线程，而一个队列可以绑定1个或者多个数据库。但是，对于每张表的导出只能是单个线程的。
### mydumper
mydumper（&myloader）是用于对MySQL数据库进行多线程备份和恢复的开源 (GNU GPLv3)工具。开发人员主要来自MySQL、Facebook和SkySQL公司，目前由Percona公司开发和维护。
mydumper 支持多线程备份恢复，粒度到记录级别，对于导出大容量的数据，效率非常高。
```
for example:
  mydumper -u test -p -P 3307 -h 127.0.0.1 -B test_dump -T test1 -b -t 16 -c -o /test/test_dump_test1
recover:
  myloader -u test -p -P 3307 -h 127.0.0.1 --directory=/test/test_dump_test1 --overwrite-tables -B test_dump
```
备份原理：
  - 主线程将各个库表，分成若干个任务，放入任务队列
  - 执行线程从任务队列读取任务，并执行。


## MySQL Physical Backups
物理备份由一系列的存储数据库内容的 raw 格式的文件组成，为了保证一致性，必须关机来拷贝物理文件，但是 Percona 公司的 Xtrabackup 工具完美的解决了关机备份的不可行方案，从而实现热备。
### Xtrabackup
Xtrabackup 有两个主要的工具，xtrabackup，innobackup：
- xtrabackup 只能备份 InnoDB 和 XtraDB 两种数据表
- innobackupex 封装了 xtrabackup，同时可以备份 MyISAM 数据表

```
for example:
  第一步：
  innobackupex --user=bkpuser  --password=bkppassword /data/backups
  第二步：
  cd /data/backups
  innobackupex --apply-log ./
recover:
  将备份拷贝到需要的目录即可使用。
```

备份的原理：
1. Xtrabackup ：
   - REDO 拷贝线程， 拷贝 REDO Log
   - ibd 拷贝线程 拷贝 InnoDB 物理文件
2. 完成后，执行 FTWRL 添加全局锁
3. 拷贝 frm，MYD,MYI etc.
4. 停止拷贝 REDO ,UNLOCK tables
5. 等待 xtrabackup 结束，备份结束

## mysqldump PK mydumper
  - mysqldump 为 MySQL 原生工具，不需要额外安装，对于导出不是特别大的DB，仍然是非常棒的工具，但对于容量大，但又必须逻辑导出的场景就不是特别合适，需要的时间特别长，不支持多线程导入导出。
  - mydumper 需要额外安装才能使用，支持多线程备份导入，速度快，支持后台模式导出

## Logical PK Physical Backup
  - 逻辑备份可以灵活的导出数据（表结构，数据，过滤等）
  - 逻辑备份与物理备份导出所有数据来看，要慢很多，因为需要读取数据并转换
  - 逻辑备份的恢复时间长
  - 物理备份的文件与线上 MySQL 完全一致，包含所有的日志等信息
