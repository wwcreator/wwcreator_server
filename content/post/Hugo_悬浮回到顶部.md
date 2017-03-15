+++
date = "2017-02-24T10:31:48-08:00"
title = "Hugo_悬浮回到顶部"
categories = ["Blog"]
tags = ["Hugo","Blog","theme"]
+++

### Step 1. 下载喜欢的「回到顶部」素材
在网上搜索自己喜欢的素材图片，我的图片是[@well](https://tmhm.github.io) 制作的。![back_to_top](/media/top21.png)

### Step 2. 针对 hyde-y 主题更改「回到顶部」


#### 创建 jquery.min.js 文件
```
[下载](https://wwcreator.github.io/js/jquery.min.js)
将文件放置在 your_site_name/theme/hyde-y/static/js/ 目录。
```

#### 放置素材
将素材图片放置在 your_site_name/theme/hyde-y/static/ 目录。

#### 引入样式
`vi your_site_name/theme/hyde-y/layouts/partials/modules/site/link/top.html` 将下面的内容替换到该文件。
```
#引入jquery
<script src="/js/jquery.min.js" type="text/javascript"></script>
#控制
<script>
        $(window).on("scroll",function(e){
        if($('body').scrollTop() >= 400  ){
                $('#gotop').show();


        }else{
                $('#gotop').hide();
        }
});
</script>
<div class="ctrolPanel" id="gotop" style="display:none;width:50px;height:50px;position:fixed;right:25px;top:85%;overflow:hidden;z-index:10000;">
  <a href="#"><img title="返回顶部" src="/top21.png" /></a>
</div>

```

完成上述步骤后，就可以使用悬浮「回到顶部」。这个折腾了一阵子，一直没有悬浮的效果，是静止的在页面。后面发现少了 jQuery，引入 jQuery 文件后，就可以通过 jQuery 实现悬浮的效果。
