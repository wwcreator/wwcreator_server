+++
date = "2017-02-22T10:11:48-08:00"
title = "定制主题 & hyde-y"
categories = ["Blog"]
tags = ["Hugo","Blog","theme"]
+++

在前面的[「使用 Hugo + GitHub Page 搭建 Blog」](https://wwcreator.github.io/2017/02/14/%E4%BD%BF%E7%94%A8-hugo--github-page-%E6%90%AD%E5%BB%BA-blog/) 文章中详细的说明搭建blog 的组成元素，「hugo」,「GitHub Page」,[Theme]，这篇文章是前面文章的续写，聊聊更改主题样式这件事。

```
hyde-y/
├── archetypes
│   └── default.md
├── data
│   ├── Formats.yaml
│   ├── Modules.toml
│   └── Strings.yaml
├── Gruntfile.js
├── images
│   ├── screenshot.png
│   └── tn.png
├── layouts
│   ├── 404.html
│   ├── code
│   │   ├── section.li.html
│   │   ├── single.hat.html
│   │   └── summary.hat.html
│   ├── _default
│   │   ├── list.html
│   │   ├── list.li.html
│   │   ├── section.html
│   │   ├── section.li.html
│   │   ├── single.boot.html
│   │   ├── single.content.html
│   │   ├── single.hat.html
│   │   ├── single.html
│   │   ├── summary.boot.html
│   │   ├── summary.content.html
│   │   ├── summary.hat.html
│   │   ├── summary.html
│   │   └── terms.html
│   ├── index.html
│   ├── partials
│   │   ├── base
│   │   │   ├── footer.html
│   │   │   ├── header.html
│   │   │   ├── imports.html
│   │   │   ├── metas.html
│   │   │   └── scripts.html
│   │   ├── bloc
│   │   │   ├── content
│   │   │   │   ├── badges.html
│   │   │   │   ├── comments.html
│   │   │   │   ├── content.html
│   │   │   │   ├── h1-link-title.html
│   │   │   │   ├── h1-title.html
│   │   │   │   ├── h2-link-title.html
│   │   │   │   ├── h2-title.html
│   │   │   │   ├── lastupdate.html
│   │   │   │   ├── link-title.html
│   │   │   │   ├── metas.html
│   │   │   │   ├── navigation.html
│   │   │   │   ├── pagination.html
│   │   │   │   ├── readlink.html
│   │   │   │   └── summary.html
│   │   │   ├── footer
│   │   │   │   ├── credits_copyright.html
│   │   │   │   ├── credits_footline.html
│   │   │   │   ├── credits.html
│   │   │   │   └── nav.html
│   │   │   └── header
│   │   │       ├── brand.html
│   │   │       ├── brand_title.html
│   │   │       ├── brand_topline.html
│   │   │       ├── nav.html
│   │   │       ├── nav_primary.html
│   │   │       └── nav_secondary.html
│   │   ├── error-404.html
│   │   ├── footer-extra.html
│   │   ├── foot-extra.html
│   │   ├── foot.html
│   │   ├── header-extra.html
│   │   ├── head-extra.html
│   │   ├── head.html
│   │   ├── homepage.html
│   │   └── modules
│   │       ├── disqus.html
│   │       ├── flattr.html
│   │       ├── github-ribbon.html
│   │       ├── hugo-version.html
│   │       ├── page
│   │       │   ├── badges.html
│   │       │   ├── date.html
│   │       │   ├── labels.html
│   │       │   ├── link
│   │       │   │   ├── read.html
│   │       │   │   └── title.html
│   │       │   ├── navigation.html
│   │       │   ├── summary.html
│   │       │   ├── tags.html
│   │       │   └── title.html
│   │       └── site
│   │           ├── brand.html
│   │           ├── copyright.html
│   │           ├── footline.html
│   │           ├── lastupdate.html
│   │           ├── link
│   │           │   ├── base.html
│   │           │   ├── footmenu.html
│   │           │   ├── home.html
│   │           │   ├── menu.html
│   │           │   ├── social
│   │           │   │   ├── bitbucket.html
│   │           │   │   ├── email.html
│   │           │   │   ├── facebook.html
│   │           │   │   ├── flickr.html
│   │           │   │   ├── github.html
│   │           │   │   ├── googleplus.html
│   │           │   │   ├── linkedin.html
│   │           │   │   ├── rss.html
│   │           │   │   ├── twitch.html
│   │           │   │   ├── twitter.html
│   │           │   │   ├── vimeo.html
│   │           │   │   └── youtube.html
│   │           │   ├── social.html
│   │           │   └── top.html
│   │           ├── pagination.html
│   │           └── topline.html
│   ├── post
│   │   ├── single.boot.html
│   │   ├── single.hat.html
│   │   ├── summary.boot.html
│   │   └── summary.hat.html
│   ├── section
│   │   └── code.html
│   ├── shortcodes
│   │   ├── alert.html
│   │   └── labels.html
│   └── taxonomy
│       ├── topic.html
│       └── topic.terms.html
├── LICENSE
├── package.json
├── README.md
├── scss
│   ├── _00-config.less
│   ├── _01-base.less
│   ├── _02-layout.less
│   ├── _03-modules.less
│   ├── _04-themes.less
│   ├── _05-alerts.less
│   ├── knacss
│   │   ├── _00-config.less
│   │   ├── _01a-normalize.less
│   │   ├── _01b-base.less
│   │   ├── _02-layout.less
│   │   ├── _03-grids.less
│   │   ├── _04-tables.less
│   │   ├── _05-forms.less
│   │   ├── _06-helpers.less
│   │   ├── _07-responsive.less
│   │   ├── _08-print.less
│   │   ├── _09-misc.less
│   │   ├── _10-styling.less
│   │   ├── _11-wordpress.less
│   │   └── knacss.less
│   └── style.less
├── static
│   ├── css
│   │   ├── font-awesome.min.css
│   │   ├── highlight
│   │   │   ├── arta.css
│   │   │   ├── ascetic.css
│   │   │   ├── atelier-dune.dark.css
│   │   │   ├── atelier-dune.light.css
│   │   │   ├── atelier-forest.dark.css
│   │   │   ├── atelier-forest.light.css
│   │   │   ├── atelier-heath.dark.css
│   │   │   ├── atelier-heath.light.css
│   │   │   ├── atelier-lakeside.dark.css
│   │   │   ├── atelier-lakeside.light.css
│   │   │   ├── atelier-seaside.dark.css
│   │   │   ├── atelier-seaside.light.css
│   │   │   ├── codepen-embed.css
│   │   │   ├── color-brewer.css
│   │   │   ├── dark.css
│   │   │   ├── default.css
│   │   │   ├── docco.css
│   │   │   ├── far.css
│   │   │   ├── foundation.css
│   │   │   ├── github.css
│   │   │   ├── googlecode.css
│   │   │   ├── hybrid.css
│   │   │   ├── idea.css
│   │   │   ├── ir_black.css
│   │   │   ├── kimbie.dark.css
│   │   │   ├── kimbie.light.css
│   │   │   ├── magula.css
│   │   │   ├── mono-blue.css
│   │   │   ├── monokai.css
│   │   │   ├── monokai_sublime.css
│   │   │   ├── obsidian.css
│   │   │   ├── paraiso.dark.css
│   │   │   ├── paraiso.light.css
│   │   │   ├── railscasts.css
│   │   │   ├── rainbow.css
│   │   │   ├── solarized_dark.css
│   │   │   ├── solarized_light.css
│   │   │   ├── sunburst.css
│   │   │   ├── tomorrow.css
│   │   │   ├── tomorrow-night-blue.css
│   │   │   ├── tomorrow-night-bright.css
│   │   │   ├── tomorrow-night.css
│   │   │   ├── tomorrow-night-eighties.css
│   │   │   ├── vs.css
│   │   │   ├── xcode.css
│   │   │   └── zenburn.css
│   │   └── style.css
│   ├── favicon.png
│   ├── fonts
│   │   ├── FontAwesome.otf
│   │   ├── fontawesome-webfont.eot
│   │   ├── fontawesome-webfont.svg
│   │   ├── fontawesome-webfont.ttf
│   │   ├── fontawesome-webfont.woff
│   │   └── fontawesome-webfont.woff2
│   ├── github-icon.png
│   ├── icon_new.jpg
│   ├── icon.png
│   ├── js
│   │   └── highlight.pack.js
│   ├── touch-icon-144-precomposed.png
│   └── we3.png
└── theme.toml

```

而我们主题的样式修改主要更改的文件有：「style.css」、 「layouts」。
![hyde-y-before](/media/hyde-y-1.PNG)
**修改后:**
![hyde-y-after](/media/hyde-y-2.PNG)

### 更改背景色为黑色：
```
.main_wrapper>.main_header {
    background-color: #2053AB;
    font-family: Raleway,"Open Sans",Arial,sans-serif;
    color: #8CB4EC;
    text-align: center
}
```
变更为：
```
.main_wrapper>.main_header {
    background-color: #212121;
    font-family: Raleway,"Open Sans",Arial,sans-serif;
    color: #8CB4EC;
    text-align: center
}
```

### 更改字体为「御納户」色
[Nippon Color](http://nipponcolors.com/#onando)
```
a {
    background-color: transparent;
    color: #09c
}
```
变更为：
```
a {
    background-color: transparent;
    color: #0C4842
}
```
### 更改hover为黑色

```
.main_wrapper>.main_content .label:hover,.main_wrapper>.main_content .navigation a:hover,.main_wrapper>.main_content .pagination a:hover,.main_wrapper>.main_content .readlink a:hover,.main_wrapper>.main_content h2 a:hover,.main_wrapper>.main_header a:hover {
    background-color: #2053AB;
    color: #fff;
    text-decoration: none
}
```
```
.main_wrapper>.main_content .label:hover,.main_wrapper>.main_content .navigation a:hover,.main_wrapper>.main_content .pagination a:hover,.main_wrapper>.main_content .readlink a:hover,.main_wrapper>.main_content h2 a:hover,.main_wrapper>.main_header a:hover {
    background-color: #212121;
    color: #fff;
    text-decoration: none
}
```

以上是对主题的一些样式变更的例子，起到抛砖引玉的作用，希望你自己能根据要求调出想要的效果。
