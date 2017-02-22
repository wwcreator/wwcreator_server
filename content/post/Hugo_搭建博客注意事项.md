+++
date = "2017-02-22T12:11:48-08:00"
title = "Hugo 搭建博客注意事项"
categories = ["Blog"]
tags = ["Hugo","Blog"]
+++

## 标题不能使用 + 号
在v0.18 mac 版本中，如果 `title` 包含 `+` ，虽然不报任何错误，但是不会生成具体的静态页面。

## google，baidu 完全搜索不到博文

因为google，baidu 还没有收录我们的URL，所以在google 里输入：site:网址URL 如果能搜索出来则说明，google 已经添加我们的网址。不能则需要提交网址到 google。百度同理。
https://www.google.com/webmasters/tools/home

## Hugo 不支持站内搜索


## Hugo 还不支持生成目录树
