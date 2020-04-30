# 前端任务分工

## 基本说明

前端框架（主要指控制台部分）已经搭建完成，大家可以在里面自由选择自己的任务了。

任务分为高优先级和低优先级。

高优先级的任务包括需求本身的东西（如成员管理、面试管理）和一些在需求里没有写明、但是很普遍、而且实现也不难的东西（比如个人信息查看、密码修改）。目前共有以下这些高优先级的任务。

```
13 results - 13 files

src\components\console\ChangePassword.vue:
  5:         更改密码（高优先级）

src\components\console\Profile.vue:
  5:         用户资料（高优先级）

src\components\console\admin\UserManagementHR.vue:
  5:         管理员管理 HR（高优先级）

src\components\console\admin\UserManagementInterviewee.vue:
  5:         管理员管理候选人（高优先级）

src\components\console\admin\UserManagementInterviewer.vue:
  5:         管理员管理面试官（高优先级）

src\components\console\HR\InterviewManagementActive.vue:
  5:         HR 的正在进行的面试（高优先级）

src\components\console\HR\InterviewManagementEnded.vue:
  5:         HR 的已结束的面试（高优先级）

src\components\console\HR\InterviewManagementUpcoming.vue:
  5:         HR 的未开始的面试（高优先级）

src\components\console\HR\UserManagementInterviewee.vue:
  5:         HR 分配到的候选人（高优先级）

src\components\console\HR\UserManagementInterviewer.vue:
  5:         HR 分配到的面试官（高优先级）

src\components\console\interviewer\ChangeFreeTime.vue:
  5:         面试官显示和更改个人空闲时间（高优先级）

src\components\console\interviewer\InterviewManagementActive.vue:
  5:         面试官的正在进行的面试（高优先级）

src\components\console\interviewer\InterviewManagementUpcoming.vue:
  5:         面试官的未开始的面试（高优先级）

```

低优先级的任务，主要是一些，“好但是费时间”的东西。

```
5 results - 5 files

src\components\console\Notification.vue:
  5:         通知消息（低优先级）

src\components\console\admin\Dashboard.vue:
  5:         管理员的 Dashboard（低优先级）

src\components\console\admin\ProblemManagement.vue:
  5:         管理员管理 OJ 题目（低优先级）

src\components\console\HR\Dashboard.vue:
  5:         HR 的 Dashboard（低优先级）

src\components\console\interviewer\Dashboard.vue:
  5:         面试官的 Dashboard（低优先级）

```

这里特别说一下 Dashboard 这个任务，它是打开一个管理面板后第一个显示的页面，上面一般有各种很好看的图表、统计数字。这个要比较费时间和精力，但是应该能算是一个管理面板的核心了，这个等我们基本任务结束之后再来弄。

这 13 + 5 个任务，有很多有高度的相似性，你可以选中几个相似的任务，这样一来减少大家的工作量，二来能尽可能确保风格的一致性。优先选择高优先级的任务。上面的搜索结果对应的文件位置就是你要写代码的地方（当然，你应该按照自己的理解添加任意必要的 component、utils 等）。

## 问题

**在哪里“添加”（比如 HR 添加一场新的面试，管理员添加一个新的用户...）？**

目前的框架里面并没有用于“添加”的东西，你可以自由发挥。

比如，如果你负责实现管理员的用户管理，点开用户管理里面的 HR，里面应该是当前系统中的所有 HR 的表格，你可以在表格的上方添加一个按钮“添加 HR”，或者在页面的右下角放一个圆圆的加号图标（参考 [Material Design](https://material.io/) 的常见风格）。

**后端的接口没弄好的时候怎么办？**

你可以在网上找些 dummy API 服务，或者自己实现一个，比如 `src/utils/dummyLogin.ts` 这个。

**我可能会用到哪些东西？**

Vuetify，Promise，axios，vuex...

**图标哪里找？**

<https://materialdesignicons.com/>。

**鸭子图标怎么回事？**

`mdi-duck` 目前的作用类似于 TODO，比如，某个东西还没找好合适的图标，某个东西是上线前的提示（如 login 页的测试用户说明）。

等到上线前再搜索 `duck` 解决这些问题。

**工作流？**

之前讨论过这个问题，除了数行以内的小修小补，其他的功能添加、bug 修复都应该 branch & merge（详见 guidelines.md）。



最后，我其实之前没有这个经验... 所以如果发现框架哪里有问题就尽快提出来😁