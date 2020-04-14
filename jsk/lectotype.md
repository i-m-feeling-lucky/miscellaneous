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





### 视频聊天





### 共享白板






## 其他任务

### 前端测试





### 前端 CI/CD






### 后端测试






### 后端 CI/CD






### 文档编写




