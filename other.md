# 其他

## UI & UX

模仿 hackerrank.com

## 代码平台

首先是 Github organizations，我们建一个 organization，大家都作为 collaborator 加入它，最后我们的项目地址会在 github.com/organization-name/repository-name，但是免费版只能用于 public repository，我们肯定要 private（毕竟不同组之间做同一个项目）。

其次是，用某个人的 Github 账号开 private repository（free 用户只支持 3 collaborator，需要 pro 用户，而它可以从 student developer pack 获得）。

最后是 <https://git.lug.ustc.edu.cn/groups/new>，我个人觉得这个比较好，没什么限制，而且速度还快。

<del>https://se.jisuanke.com/</del>

## License

由课程群里的讨论结果确定。

<del>MIT, GNU GPLv3, Apache</del>

## JavaScript 代码风格

ESLint + which?

1. Airbnb

2. Standard

3. Google

## TypeScript

Use it?


## 评分机制

1. 不搞绝对平均；
2. 根据功能/模块实现量、难度和完成度、commit 代码量等来确定；
3. 大家每个人列出自己完成的功能/模块，之后每个人申报自己的期望得分，用某种机制使得可以匿名对某人申报的分数提出异议，如无异议，则这部分分数生效，占比 50%；另外 50%，对于组长，用某种机制让组员给组长匿名打分，取平均，对于其他组员，得分由组长确定（组长根据功能/模块难度、完成度、commit 代码量等来综合判断，若有异议，提出后共同商量；若组长不能清晰判断每个人的工作量、工作难度，则他应该采取尽量减少差距的保守策略。）；
4. 组长得分 <= max(其他组员得分)，max(所有人得分) <= 1.5 * min(所有人得分)。以上约束如果不成立，“调分”。