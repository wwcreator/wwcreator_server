+++
date = "2017-02-14T21:11:48-08:00"
title = "使用 Hugo + GitHub Page 搭建 Blog"
categories = ["Deploying"]
tags = ["Hugo","Blog"]
+++

## 我想搭建一个自己的Blog
许久以前，一直想搭一个自己的博客，很不想用第三方的平台，诸多的限制，样式不美观等等，无奈自己没有好好研究怎么使用工具来快速生成，听的最多的是 Jkyll ，Haxo，一看Install Document，望而却步，直到看到 Hugo 工具，简单灵活，我用了两天的时间来研究并部署成功了，分享给有需要的人。

## Step 1. Install Hugo on Ubuntu-16.0.4
软件的安装，最方便的非 apt-get 莫属。
```
  apt-get install Hugo
  其余的安装方式可参考官方文档:
  https://gohugo.io/overview/installing/
```
## Step 2. Hugo 创建 Site
安装完成后，开始创建自己的 Site。
```
mkdir -p /data/www/
cd /data/www
# create new site
hugo new site wwcreator
cd /data/www/wwcreator
tree -a
.
|-- archetypes
|-- config.toml
|-- content
|-- data
|-- layouts
`-- static

5 directories, 1 file
```
可以看到创建的新的 site 的目录结构.

>- archetypes: You can create new content files in Hugo using the hugo new command. When you run that command, it adds few configuration properties to the post like date and title. Archetype allows you to define your own configuration properties that will be added to the post front matter whenever hugo new command is used.
- config.toml: Every website should have a configuration file at the root. By default, the configuration file uses TOML format but you can also use YAML or JSON formats as well. TOML is minimal configuration file format that’s easy to read due to obvious semantics. The configuration settings mentioned in the config.toml are applied to the full site. These configuration settings include baseURL and title of the website.
- content: This is where you will store content of the website. Inside content, you will create sub-directories for different sections. Let’s suppose your website has three actions – blog, article, and tutorial then you will have three different directories for each of them inside the content directory. The name of the section i.e. blog, article, or tutorial will be used by Hugo to apply a specific layout applicable to that section.
- data: This directory is used to store configuration files that can be used by Hugo when generating your website. You can write these files in YAML, JSON, or TOML format.
- layouts: The content inside this directory is used to specify how your content will be converted into the static website.
- static: This directory is used to store all the static content that your website will need like images, CSS, JavaScript or other static content.

## Step 3. Add content
```
hugo new post/first.md
tree -a content
vim content/first.md
```

```
+++
date = "2017-02-14T11:11:48-08:00"
draft = true
title = "first"
+++
```
`+++` 里的内容是该文章的`TOML`配置信息， 也叫做 `front matter`。
在文档里添加内容（格式为markdown 格式哦）：
```
+++
date = "2017-02-14T11:11:48-08:00"
draft = true
title = "first"
+++
`hello world`
```
保存退出，第一个文档完成。

## Step 4. 启动 hugo 瞧瞧
```
hugo server --baseURL=http://192.168.x.xx:80 \
              --port=80 \
              --buildDrafts \
              --appendPort=false \
              --bind=192.168.x.xxx
```
```
1 of 1 draft rendered
0 future content
1 pages created
0 paginator pages created
0 tags created
0 categories created
in 6 ms
Watching for changes in /data/www/wwcreator/{data,content,layouts,static}
Serving pages from memory
Web Server is available at http://192.168.x.xx:80 (bind address 192.168.x.xxx)
Press Ctrl+C to stop
```
访问 http://192.168.x.xx:80 然而什么都没有显示，没有我想看到的`Hello world`，因为我们还需要安装 `theme`。

## Step 5. Install theme
```
cd themes
git clone https://GitHub.com/enten/hyde-y
更加详细的配置，可以参考：
  http://www.gohugo.org/theme/hyde-y/
  最初按照这个主题的 ReadMe.md 步骤来配置，后续熟练后，可以自己慢调
```
```
hugo server --baseURL=http://192.168.x.xx:80 \
              --port=80 \
              --buildDrafts \
              --appendPort=false \
              --bind=192.168.x.xxx \
              --theme=hyde-y
# 再次刷新页面，发现主题已经生效，内容也正常显示了。
```
hugo blog 我们已经准备完成，开始创建 GitHub Page。

## Step 6. 使用 GitHub Page

>GitHub Pages is a static site hosting service.

在 GitHub 上新建一个 username.github.io的project ，它默认会生成: http://username.github.io/ 的域名。

但是现在repository没有任何code，所以接下来通过 hugo 生成静态页面并上传到 GitHub 上。

## Step 7. 本地生成静态页面
```
# 注意与本地的区别
hugo  --baseURL=http://username.github.io \
              --buildDrafts \
              --theme=hyde-y
tree -a
.
|-- archetypes
|-- config.toml
|-- content
|-- data
|-- public
|-- layouts
`-- static

6 directories, 1 file
```
生成的静态页面存储在 public 目录，马上要接近成功了。
## Step 8. 本地服务配置 GitHub 信息
```
ssh-keygen
cat .ssh/id_rsa.pub
将秘钥的值复制，使用浏览器登陆到 GitHub ，
在 [Settings] -> [SSH and GPG keys] -> [New SSH Key] 粘贴保存。则本地可以跟 GitHub 服务器通信。
git config --global user.name "你的名字"
git config --global user.email "your_email@youremail.com"
```

## Step 9. 上传到 GitHub
```
cd public
git init   # init
# clone with ssh not https
git add remote origin git@GitHub.com:wwcreator/wwcreator.github.io.git
git status  # show the changes
git add -A  
git commit -m "first commit"  # commit
git push origin master  # push
```
```
# git push origin master
Counting objects: 19, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (16/16), done.
Writing objects: 100% (19/19), 5.84 KiB | 0 bytes/s, done.
Total 19 (delta 1), reused 0 (delta 0)
remote: Resolving deltas: 100% (1/1), done.
To git@GitHub.com:wwcreator/wwcreator.github.io.git
 * [new branch]      master -> master
```

访问 http://wwcreator.github.io ，大功告成。有很多好看的主题可以选择，但是我还是选择了 hyde-y ，是我尝试了 N 多主题后的结论，简单美观，如果需要修改样式，可以参考下一篇文章。
