+++
date = "2017-02-22T13:16:48-08:00"
title = "博客园迁移到Hugo"
categories = ["Blog"]
tags = ["Hugo","Blog","迁移"]
+++

对于早期的很多用户来说，一直在博客园上写自己的博文，但是慢慢的，大家开始都有自己的专属 Blog 了，那之前的 Post 肿么办呢？

来，我教你。

## 备份博客园数据

备份这件小事，应该难不倒你，但是博客园有限制，工作日在「08:00-18:00」,不能备份，所以备份需要挑时间的喔。备份生成的是一份 XML 格式的文件，下一步，continue 。

### 解析 XML 文件的内容

#### 注意：
- 备份的 XML 没有美化成标准的 XML 格式，所以需要去网站上搜索进行 XML 格式美化再保存替换。
- 博文的内容被 `<![CDATA[` `]]` 包含，如果不指定获取所有内容参数，则会被解析忽略。
- 生成 MD 文档 front matter 为 TOML 格式。

下面看姐的代码：
```
# -*- coding: utf-8 -*-

import os
from xml.dom.minidom import parse
import sys
reload(sys)
sys.setdefaultencoding('utf-8')

BACKUP_FILE = 'CNBlogs_BlogBackup_131_201602_201702_2.xml'
DOMTree = parse(BACKUP_FILE)
root = DOMTree.documentElement
blog_title = root.getElementsByTagName('title')[0].childNodes[0].data
if not os.path.isdir(blog_title):
    os.mkdir(blog_title)

blogs = root.getElementsByTagName('item')

tag = ['算法','C++', 'git', 'GPU', '驾驶', 'DL', 'TORCS', '服务器' ,'codility' ,'编译器' ,'python' ,'机器','强化','配置','ubuntu']


for blog in blogs:
    try:
        title = blog.getElementsByTagName('title')[0].childNodes[0].data
        origin_link = blog.getElementsByTagName('link')[0].childNodes[0].data
        date = blog.getElementsByTagName('pubDate')[0].childNodes[0].data
        # content = blog.getElementsByTagName('description')[0].childNodes[0].data
        content = blog.getElementsByTagName('description')[0].firstChild.wholeText
        #categories
        for test in tag:
            if title.find(test) != -1:
                categories = test
                break
            else:
                categories = 'Life'
        with open(blog_title + os.sep + title + '.md', 'w') as f:
            f.write('+++ \n')
            f.write('title = "%s" \n' % title)
            f.write('date = "%s" \n' % date)
            f.write('categories = ["%s"] \n' % categories)
            f.write('+++ \n')
            f.write(content)
            f.write('\n\n')
            f.close()
    except Exception, e:
        print e
```

执行该脚本，会生成所有的博文。拷贝到 Hugo 的content/post/ 目录，在本地预览效果吧，如果没有问题就 `Push` 到 `Github`。

### 结束语
- 使用这样是获取不到数据：`content = blog.getElementsByTagName('description')[0].childNodes[0].data`
- 需要使用 wholeText 来读取`<![CDATA[` `]]`里的内容。
`content = blog.getElementsByTagName('description')[0].firstChild.wholeText`
