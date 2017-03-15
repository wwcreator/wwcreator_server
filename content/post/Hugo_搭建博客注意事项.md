+++
date = "2017-02-22T12:11:48-08:00"
title = "Hugo 搭建博客注意事项"
categories = ["Blog"]
tags = ["Hugo","Blog"]
+++

### 标题不能使用 + 号
在v0.18 mac 版本中，如果 `title` 包含 `+` ，虽然不报任何错误，但是不会生成具体的静态页面。

### 将 back to top 改成 「回到顶部」

vi `themes/hyde-y/data/Strings.yaml`
将 「back to top」改成 「回到顶部」。

### hugo 怎么插入本地 image
之前一直不知道怎么插入image，不知道 hugo 是怎么引用的，后续了解到，在site 的目录下的 static 下就是存储的静态文件，我们创建 media 目录存放图片等媒体文件，引用的话，直接「/media/xxx.png」 。

**_注意：_** 不要使用 xxx.PNG 这样的大写后缀，生成的静态页面为小写后缀，然后出现找不到该 Image。

### hugo content 顶部添加 preview、next
vi `themes/hyde-y/layouts/post/single.hat.html`

在`</header>`前添加：

```
<br/>
{{ partial "bloc/content/navigation" . }}
```

### google，baidu 完全搜索不到博文

因为google，baidu 还没有收录我们的URL，所以在google 里输入：site:网址URL 如果能搜索出来则说明，google 已经添加我们的网址。不能则需要提交网址到 google。百度同理。
https://www.google.com/webmasters/tools/home

### Hugo 不支持站内搜索


### Hugo 还不支持生成目录树
