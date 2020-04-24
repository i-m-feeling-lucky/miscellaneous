# 技术选型报告

<!-- TOC -->

- [技术选型报告](#技术选型报告)
    - [基础性任务](#基础性任务)
        - [前端框架搭建](#前端框架搭建)
        - [后端框架搭建](#后端框架搭建)
    - [功能性任务](#功能性任务)
        - [代码编辑、运行和评测](#代码编辑运行和评测)
        - [文字聊天](#文字聊天)
        - [视频聊天](#视频聊天)
        - [共享白板](#共享白板)
    - [其他任务](#其他任务)
        - [前端测试](#前端测试)
        - [前端 CI/CD](#前端-cicd)
        - [后端测试](#后端测试)
        - [后端 CI/CD](#后端-cicd)
        - [文档编写](#文档编写)

<!-- /TOC -->

## 基础性任务
### 前端框架搭建

**Vue.js + Vuetify**

大家在前面的课程都学过了三大前端框架里面的 Vue.js，因此我们自然就是用它了。

剩下一个问题就是该选什么适用于 Vue.js 的 UI 库。在 GitHub 上，我们以“Vue UI library”、“Vue component library”等关键词搜索，最终确定了以下这些候选项：[Element](https://github.com/ElemeFE/element), [Vuetify](https://github.com/vuetifyjs/vuetify), [iView](https://github.com/iview/iview), [Mint UI](https://github.com/ElemeFE/mint-ui/), [Quasar](https://github.com/quasarframework/quasar), [BootstrapVue](https://github.com/bootstrap-vue/bootstrap-vue)（star 数量从高到低排列）。于是现在问题变成了在这几个里面选一个。

经过统计，我们了解到负责前端开发的同学里面只有两个人有 Bootstrap 的使用经验，其他几个框架都没有使用过，而 BootstrapVue 的流行度稍低，因此我们决定学新的 UI 库。

第一个选项，Element，虽然 star 数量最多，但是似乎不怎么维护了（[Is Element still maintained? · Issue #18822 · ElemeFE/element](https://github.com/ElemeFE/element/issues/18822)），截止我们做下不使用它的决定的时候，它的最新的 commit 还是在去年 11 月多。第二个选项，Vuetify，star 数量仅仅次于它，而且 Material 风格也挺好看，最终大家决定使用 Vuetify。

### 后端框架搭建





## 功能性任务

### 代码编辑、运行和评测





### 文字聊天

**RTCMultiConnection**

WebRTC（Web Real-Time Communication）是一个提供实时通信的框架，受到 Apple、Goolge、Microsoft 等“大厂”的支持，进入了 W3C 推荐标准。

网上有很多使用 WebRTC 的 JavaScript 库，经过一番搜索，我们竟然发现了一个几乎完全满足我们的需求（文字聊天、视频聊天、白板）的库 [RTCMultiConnection](https://github.com/muaz-khan/RTCMultiConnection)，基于它，我们搭建了一个 demo 网站：<https://rtc.yusanshi.com>，效果如下。

![](https://img.yusanshi.com/upload/20200423165012476405.png)

<img src="https://img.yusanshi.com/upload/20200423165020183173.png" width="400">

看起来，只需要把界面调整一下（调整不同窗口的比例、精简掉一些不需要的功能）我们就可以拿起来用了。于是秉承着“不造轮子”的原则，我们决定使用它。

至于在数据库中存储时间信息的要求，我们可以用一种比较 trivial 的解决办法：记录用户交互的时候同时加上时间戳信息。我们可以魔改 RTCMultiConnection 的代码，当用户有新的交互信息时（如发了一条新的文字聊天、白板上新加了一笔），直接向后台服务器相应的接口发送这个操作。至于视频的录制，可以利用 [MediaRecorder](https://developer.mozilla.org/en-US/docs/Web/API/MediaRecorder) API。所以基本上，交互信息的存储可以不再使用第三方库。

### 视频聊天

见“文字聊天”。

### 共享白板

见“文字聊天”。


## 其他任务

### 前端测试

经查阅资料后，综合使用的广泛性、便捷性，决定使用jest + vue-test-util进行前端测试。


### 后端测试






### CI/CD

使用 GitHub Actions，在 PR 开启后运行测试，在合并到 master 后先运行测试，若通过则利用 [ssh-deploy] 通知 VPS 进行部署。

[ssh-deploy]: https://github.com/easingthemes/ssh-deploy

### 文档编写

要求：
自动生成需求分析、软件设计、测试报告等数种不同类型的文档
文档内容丰富，在文字和图片之外还可以绘制图形、进行简单交互
适合阅读和理解，能够体现整个软件工程中的大部分信息

可见，文档撰写工作非常繁琐，需要有自动工具支撑以提高工作效率。考虑的方案有：

- [Hexo](https://hexo.io/): 使用人数非常多，简单、实用、方便，但是主题系统太过于静态，对Markdown渲染的配置不够灵活
- [VuePress](https://www.vuepress.cn/): Vue官方出品，专注于做以内容为中心的静态网站，能很方便得和我们的前端整合到一起，而且它本身就提供了一些为技术文档定制的开箱即用的主题和特性
- [WordPress](https://wordpress.com/): 是做网站很好的工具，但过于复杂，并不太适合生成文档
- [jekyll](http://jekyllcn.com/)：简单、方便，但是主题较少、灵活性低

综合考虑后选择VuePress进行文档生成。



