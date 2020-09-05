# 设计方案（草稿）

<!-- TOC -->

- [设计方案（草稿）](#设计方案草稿)
    - [前端](#前端)
    - [数据库](#数据库)
        - [`User`](#user)
            - [`Interviewer`](#interviewer)
        - [`UserLogin`](#userlogin)
        - [`Interviewee`](#interviewee)
        - [`HRAssignInterviewer`](#hrassigninterviewer)
        - [`HRAssignInterviewee`](#hrassigninterviewee)
        - [`Interview`](#interview)
        - [`InterviewComment`](#interviewcomment)
        - [`History`](#history)
        - [`Problem`](#problem)
    - [接口](#接口)
    - [测试/运维](#测试运维)

<!-- /TOC -->

## 前端

| 页面     | 首页                                                    | 超管控制台                                                   | HR 控制台                                                    | 面试官控制台                                     | 面试房间                                                     |
| -------- | ------------------------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------ | ------------------------------------------------------------ |
| 地址     | `/`                                                     | `/console`                                                   | `/console`                                                   | `/console`                                       | `/interview/<id>?token=XXXXX`                                |
| 访问控制 | 无                                                      | 需已用超管账号密码登录                                       | 需已用 HR 账号密码登录                                       | 需已用面试官账号密码登录                         | 无 token 或无效 token 禁止访问（共有三个 token）             |
| 内容一   | 登录（邮箱框、密码框）                                  | 个人密码修改（旧密码、新密码）                               | 个人密码修改（旧密码、新密码）                               | 个人密码修改（旧密码、新密码）                   | 面试前：该场面试的信息（根据三类 token 区别显示，如 HR 的 token 要比候选人的 token 显示更多信息）；面试中：面试界面（根据三类 token 区别显示）；面试后：回溯界面（注意此时只有 HR 的 token 可用） |
| 内容二   | 其他不重要但是能充实首页的信息（如一些好看的 Banner  ） | 查看所有用户信息（HR：邮箱、姓名、被分配的面试官、被分配的候选人；面试官：邮箱、姓名、空闲时间、被分配的 HR、被安排的面试；候选人：邮箱、姓名、被分配的 HR、被安排的面试、HR 给的申请结果） | 查看被分配的面试官和候选人（显示候选人的邮箱、被安排的面试及评分、评语） | 个人空闲时间查看和修改                           |                                                              |
| 内容三   |                                                         | 添加用户（根据 role 不同而单个或批量，可放在表格左上角；name 项只对候选人是必须的） | 设置候选人的申请结果（待定、通过、拒绝）。候选人的申请结果由HR根据候选人接受的面试的情况来做修改。默认是待定。即使申请结果被 HR 修改为通过或拒绝后，也还可以随时再改。 | 被安排的面试（这里的面试条目的超链接带有 token） |                                                              |
| 内容四   |                                                         | 添加分配（HR - 候选人间、HR - 面试官间，可放在每个用户条目中） | 添加面试（面试双方的 id、面试开始时间和时长）                |                                                  |                                                              |
| 内容五   |                                                         |                                                              | 自己安排的面试信息（<del>还未开始的面试显示重发通知邮件按钮</del>，正在进行的面试显示旁观按钮，已结束的面试显示回溯按钮；这里的面试条目的超链接带有 token） |                                                  |                                                              |



## 数据库

### `User`

| 列名     | 类型    | 备注                   |
| -------- | ------- | ---------------------- |
| id       | integer | unique（自动生成即可） |
| email    | string  | unique                 |
| pass_sha256 | string  | 暂时用 SHA256 哈希后的密码 `hashlib.sha256(b'foo').hexdigest()` |
| role  | integer | [0, 1, 2] => [admin, HR, interviewer] |

#### `Interviewer`

| 列名                | 类型      | 备注                                                     |
| ------------------- | --------- | -------------------------------------------------------- |
| id                  | integer   | [OneToOneField] → User                                   |
| free_time           | string    | 该面试官自己在系统中填写的空闲时间，是一个格式类似于 "[["2020-09-05T07:00:00","2020-09-05T08:00:00"],["2020-09-06T07:00:00","2020-09-06T08:00:00"]]" 的字符串，也就是 let arr = [["2020-09-05T07:00:00","2020-09-05T08:00:00"],["2020-09-06T07:00:00","2020-09-06T08:00:00"]]; JSON.stringify(arr) 的结果。此 Array 中每个元素都代表一个空闲时间段，前一个时间是开始时间，后一个时间是结束时间，例如 ["2020-09-05T07:00:00","2020-09-05T08:00:00"] 代表一个早上7点开始，8点结束的时间段|

### `UserLogin`

| 列名  | 类型          | 备注                                         |
|-------|---------------|----------------------------------------------|
| user  |               | 外码 → User                                  |
| token | UUID          | 登录时给一个 token，用于验证身份，登出时删去 |

### `Interviewee`
| 列名                | 类型      | 备注                                                         |
| ------------------- | --------- | ------------------------------------------------------------ |
| email    | string  | 主键                 |
| name | string |  |
| application_result  | integer   | map: ['Pending', 'Approved', 'Rejected']，是 HR 给的面试结果，初始值应是 'Pending'。注意这里的结果和单场面试结果的区别：这里的结果是申请的最终结果，HR 自行安排面试的次数，TA 根据所有的单场面试的结果来决定这里的最终结果 |

### `HRAssignInterviewer`

| 列名        | 类型    | 备注        |
|-------------|---------|-------------|
| hr          | integer | 外码 → User |
| interviewer | integer | 外码 → Interviewer |

### `HRAssignInterviewee`

| 列名        | 类型    | 备注               |
|-------------|---------|--------------------|
| hr          | integer | 外码 → User        |
| interviewee | string  | 外码 → Interviewee |

### `Interview`

| 列名               | 类型    | 备注                           |
| ------------------ | ------- | ------------------------------ |
| id                 | integer | unique（自动生成即可）         |
| hr                 | integer | 外码 → User                    |
| interviewer        | integer | 外码 → Interviewer             |
| interviewee        | string  | 外码 → Interviewee             |
| interviewer_token  | UUID    | `default=uuid.uuid4`           |
| interviewee_token  | UUID    | `default=uuid.uuid4`           |
| password           | string  | 连接密码，插入新记录时随机生成 |
| start_time         | time    |                                |
| length             | integer | 单位分钟，> 0，建表时默认 30   |
| actual_length      | integer | 单位秒，是面试的实际时长，用于回放 |
| status             | string  | ['upcoming', 'active', 'ended'] |

### `InterviewComment`

一个 interview 有 comment 说明已经结束。

| 列名               | 类型    | 备注                           |
| ------------------ | ------- | ------------------------------ |
| interview          |         | [OneToOneField] → Interview    |
| rate               | integer | 0--4 ⇒ ['S', 'A', 'B', 'C', 'D'] |
| comment            | string  | 面试官评价                     |

### `History`

| 列名      | 类型     | 备注                                     |
|-----------|----------|------------------------------------------|
| interview | integer  | 外码 → Interview                         |
| type      | string   | ["chat", "whiteboard", "code"]           |
| time      | datetime | `default=datetime.datetime.utcnow`       |
| data      | string   | JSON 字符串，格式根据 history 的类型决定 |

## 接口

[api.yaml](./api.yaml)（可在 <https://editor.swagger.io/> 查看）

## 测试/运维

前后端都需要有各自的测试、CI/CD。
