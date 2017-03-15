+++
date = "2017-02-21T10:14:48-08:00"
title = "Hugo 添加站点统计信息"
categories = ["Blog"]
tags = ["Hugo","Blog","theme"]
+++

作为一个 Blog 的维护者，当然希望了解站点的统计信息，PV,UV，每个页面的阅读量等，但是 Hugo 主题相对于 Jkyll 少很多，插件也不及等。怎么统计呢？

### busuanzi 页面计数器
在阅读一些 Blog 后，发现页面有展示统计信息的很少，Google 一番，发现一个非常简单方便的工具 [不蒜子](http://ibruce.info/2015/04/04/busuanzi/) .

### 针对 hyde-y 主题添加页面计数器

- 添加 header 信息

vi `hyde-y/layouts/partials/head.html` 在 head 中添加以下 script 代码。
```
<script async src="//dn-lbstatics.qbox.me/busuanzi/2.3/busuanzi.pure.mini.js">
</script>
```
- 添加站点PV,UV

vi `hyde-y/layouts/partials/bloc/content/lastupdate.html`
```
&nbsp;&nbsp;
<span id="busuanzi_container_site_pv">
    Pv:<span id="busuanzi_value_site_pv"></span>次
</span>
&nbsp;
<span id="busuanzi_container_site_uv">
  Uv:<span id="busuanzi_value_site_uv"></span>次
</span>
</div>

```

展示效果：

![site-pv](/media/site-pv.png)

- 添加页面PV

vi `hyde-y/layouts/partials/bloc/content/metas.html`
```
&nbsp;&nbsp;
<span id="busuanzi_container_page_pv">
  本文总阅读量<span id="busuanzi_value_page_pv"></span>次
</span>

```
展示效果：

![page-pv](/media/page-pv.png)

### 结束语
根据自己的审美，功能来定制主题，首先需要对主题的结构，调用等信息清楚，然后再添加自己的改动。对了，如果大家有 Hugo 的站内搜索功能实现的，务必留言哈。
