---
categories: ['MySQL']
date: 2017-03-14T18:22:41-07:00
description: wwcreator blog
menu:
- Blog
- Life
- About Me
tags: []

title: "MySQL Group Replication – Transaction life cycle explained"
---
MySQL Group Replication – Transaction life cycle explained


MySQL Group Replication - 事务生命周期分析



MySQL multi master 插件来了，MGR 可以实现在任何 MySQL 成员进行同步更新，冲突处理，成员自动管理和成员故障检测。

为了更好的理解 MGR 的工作原理，我们将在这篇文章里分析事务的生命周期和组件之间的相互作用，但是在开始之前，我们需要先理解什么是 Group .

组通讯工具包
多主插件由组通讯工具包支撑，它决定了哪些 MySQL 属于组成员，执行故障检测和提供服务消息。有序消息队列不可思议的是，允许数据在所有成员之间是一致的。你可以在[Group communication](http://mysqlhighavailability.com/group-communication-behind-the-scenes/) 这篇文章中详细了解。

这些强大的属性，加上每个服务器的初始化状态相同，我们就能实现数据库状态机复制。

除了组通讯系统的内容，剩下的基本概念是视图。当一个MySQL服务器加入到组，就会创建一个新的视图，这是一个逻辑标识，决定了哪些服务属于组成员。当服务器离开组成员（资源或非自愿），也会创建视图。这由一个内置的动态组成员资格服务提供。

在开始应用事务之前，加入者将请求组当前状态，为了获取未同步的事务，因此会与最新的副本同步。这称为分布式恢复。你可以在[ Distributed Recovery behind the scenes ](http://mysqlhighavailability.com/distributed-recovery-behind-the-scenes/) 了解详情。

事务生命周期

假设现在组成员都已经建立相同的初始状态，现在我们需要在所有组成员就交易事务达成一致，那就是，如果任何事务在任何成员之间提交，必须保证在其他非故障组成员也提交该事务。
对于写操作是一个非常高的要求，只读事务在本地执行查询。

组通讯工具包给我们提供了一个顺序广播原语，也就是说，在顺序单相同的情况下所有的消息发送到所有成员，即便是故障的成员。也就意味着我们需要一个全局的消息序号在组内通讯，再结合事务交易的最终结果（提交或回滚）来决定保证所有成员最终达到一致状态。

所以不管客户端什么时候执行写事务，它只是先在本地执行，直到真正提交才在其他成员间执行。


现在我们需要决定本地指定的事务是应该提交还是回滚呢。每个成员都持有每行更新的相关联版本。这样我们就可以知道该行的版本信息在其他成员服务上是老的版本，因此并行在其他成员执行该操作。版本信息包含在执行的写事务里面。


认证

该决定由认证模块来执行，让我们看一个例子。

在上图中，我们有一个3成员的组，一个客户端在S1上执行写事务，事务执行，直到提交阶段前，然后广播写操作和数据到组。

事务写操作集由每个更新表的主键和事务执行时数据库版本组成。数据库版本由GTID_EXECUTED 提供，更准确的说，是没有间隙的连续的最后一个数。比如：GTID_EXECUTED: UUID:1-10, UUID:12, db版本是 10. 当事务提交，db version 会隐含增加。

事务认证完成，也就是，每个成员都比较自身的版本信息，如果写事务的 db version 小于任意一个认证的数据库上的版本，则回滚。在 特定行的认证模块上没有版本信息，意味着还没有更新，不会引起任何事务回滚。

db version 在执行时是 1（dbv:1），当前的认证模块版本也是 1 （cv:1），意味着该事务不会与任何其他进行着的事务冲突。所以事务允许被提交，认证模块行版本信息被更新为 2（cv:2）.这意味着本地的 s1 可以继续提交并返回成功给客户端。其他 s2,s3 的事务将放在队列由应用模块去应用。

应用模块主要负责响应积极认证后到达的组事务，像s2,s3 。


GTID 由认证模块管控，目的是为了给组所有成员相同的identifier。组成员共享相同的UUID，使得组跟single master （所有事务具有相同的UUID）一样，这里是组名称。更多的细节可以看 [Getting started with MySQL Group Replication post](http://mysqlhighavailability.com/getting-started-with-mysql-group-replication/).

为了达到这样的效果，在分布式恢复时（一个新成员加入）认证模块状态也会被传输到新节点，再次满足DBSM要求，组的所有成员服务器必须具有相同的初始状态。

让我们看一个例子，我们在事务间有冲突的事务。

上图中我们依然是包含3个成员的组，s1 和 s2 分别执行事务 T1，T2（并发更新同一行），两个事务先本地执行在提交阶段之前，db version 1（dbv:1）,然后写事务和数据广播到组。

组通讯工具，在这里例子里，将T1 排在 T2 前面，所以当认证模块更新行的版本 version 1（cv:1），事务将被积极认证通过，认证模块行版本 version 2（cv:2）然后所有成员的认证模块版本是 2 ，从而继续进入提交阶段。

然后认证转向 T2，db version 还是 1（dbv:1）,但是认证模块的行版本信息是 2. 这也就说明该事务修改的行已经被前面通过认证的事务执行过了，所以 T2 必须消极认证，S2 将回滚事务，然后返回错误给客户端，其他成员将会忽略该事务。

你可能会考虑一件事，认证模块数据会永无止境的增长，没有更多的细节？ 是的，但是我们有覆盖到，所有组成员定期交换他们的 GTID_EXECUTED 来计算他们已经提交的事务的交集 —— 稳定集合。任何组成员不能更新行版本小于已经执行的操作集合，然后执行垃圾回收器来移除所有已经属于稳定集合的行版本信息。

认证模块状态可以在 performance_schema/replication_group_member_stats 表查询。

server> select * from performance_schema.replication_group_member_stats\G
*************************** 1. row *****************************
CHANNEL_NAME: group_replication_applier
VIEW_ID: 1428497631:1
MEMBER_ID: 855060ee-3fe5-11e4-a8d9-6067203feba0
COUNT_TRANSACTIONS_IN_QUEUE: 0
COUNT_TRANSACTIONS_CHECKED: 6
COUNT_CONFLICTS_DETECTED: 1
COUNT_TRANSACTIONS_VALIDATING: 3
TRANSACTIONS_COMMITTED_ALL_MEMBERS: 8a94f357-aab4-11df-86ab-c80aa9429562:1-5
LAST_CONFLICT_FREE_TRANSACTION: 8a94f357-aab4-11df-86ab-c80aa9429562:5


结论：
这只是第一步，MGR 仍然还在继续完善当中，在这片博文中我们阐述这项新复制技术的事务的生命周期，赶紧免费体验吧，然后回到社区，让我们使它变得更好。

