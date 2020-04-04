# 设计方案（草稿）

<!-- TOC -->

- [设计方案（草稿）](#设计方案草稿)
    - [前端](#前端)
    - [数据库](#数据库)
        - [`User`](#user)
            - [`Admin`](#admin)
            - [`HR`](#hr)
            - [`Interviewer`](#interviewer)
            - [`Interviewee`](#interviewee)
        - [`Interview`](#interview)
    - [接口](#接口)
    - [测试/运维](#测试运维)

<!-- /TOC -->

## 前端

| 页面     | 首页                                                    | 超管个人中心                                                 | HR 个人中心                                                  | 面试官个人中心                                   | 面试房间                                                     |
| -------- | ------------------------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------ | ------------------------------------------------------------ |
| 地址     | `/`                                                     | `/user/<id>`                                                 | `/user/<id>`                                                 | `/user/<id>`                                     | `/interview/<id>?token=XXXXX`                                |
| 访问控制 | 无                                                      | 需超管账号密码登录                                           | 需 HR 账号密码登录                                           | 需面试官账号密码登录                             | 无 token 或无效 token 禁止访问（共有三个 token）             |
| 内容一   | 登录（邮箱框、密码框）                                  | 个人密码修改（旧密码、新密码）                               | 个人密码修改（旧密码、新密码）                               | 个人密码修改（旧密码、新密码）                   | 面试前：该场面试的信息（根据三类 token 区别显示，如 HR 的 token 要比候选人的 token 显示更多信息）；面试中：面试界面（根据三类 token 区别显示）；面试后：回溯界面（注意此时只有 HR 的 token 可用） |
| 内容二   | 其他不重要但是能充实首页的信息（如一些好看的 Banner  ） | 查看所有用户信息（HR：邮箱、被分配的面试官、被分配的候选人；面试官：邮箱、空闲时间、被分配的 HR、被安排的面试；候选人：邮箱、被分配的 HR、被安排的面试、HR 给的申请结果） | 查看被分配的面试官、分配的候选人（显示候选人的邮箱、被安排的面试及评分、评语） | 个人空闲时间查看和修改                           |                                                              |
| 内容三   |                                                         | 添加用户（根据 role 不同而单个或批量，可放在表格左上角）     | 修改候选人的申请结果（待定、通过、拒绝），HR 要根据候选人接受的面试的结果来做决定，TA 若觉得当前面试场次不够，可继续对该候选人添加面试，直到做出通过或拒绝的决定 | 被安排的面试（这里的面试条目的超链接带有 token） |                                                              |
| 内容四   |                                                         | 添加分配（HR - 候选人间、HR - 面试官间，可放在每个用户条目中） | 添加面试（面试双方的 id、面试开始时间和时长）                |                                                  |                                                              |
| 内容五   |                                                         |                                                              | 自己安排的面试信息（还未开始的面试显示重发通知邮件按钮，正在进行的面试显示旁观按钮，已结束的面试显示回溯按钮；这里的面试条目的超链接带有 token） |                                                  |                                                              |



## 数据库

> 1. 面试评价（`['Pending', 'Approved', 'Rejected']` 和 `['S', 'A', 'B', 'C', 'D']`）亦可使用 integer 类型；
>
> 2. `integer[]` 类型的可能用外码会比较麻烦（需要单独对关系建一个表），或许可以用 string 类型、使用 JSON 字符串？（`stringify([1, 5, 6, 12]`），我没有研究过这个地方，了解也不多，请负责这里的同学自行决定。

### `User`

| 列名     | 类型    | 备注                   |
| -------- | ------- | ---------------------- |
| id       | integer | unique（自动生成即可） |
| email    | string  | unique                 |
| password | string  | 对于 interviewee 该项为空 |
| role  | integer | [0, 1, 2, 3] => [admin, HR, interviewer, interviewee] |


#### `Admin`

| 列名     | 类型   | 备注 |
| -------- | ------ | ---- |
| id | integer | 外码 |
|      |         |      |

#### `HR`

| 列名                 | 类型      | 备注                             |
| -------------------- | --------- | -------------------------------- |
| id                   | integer   | 外码                             |
| assigned_interviewer | integer[] | 外码（？），该 HR 被分配的面试官 |
| assigned_interviewee | integer[] | 外码（？），该 HR 被分配的候选人 |
| scheduled_interview  | integer[] | 外码（？），该 HR 安排的面试     |


#### `Interviewer`

| 列名                | 类型      | 备注                                                     |
| ------------------- | --------- | -------------------------------------------------------- |
| id                  | integer   | 外码                                                     |
| assigned_HR         | integer[] | 外码（？），该面试官被分配的 HR（可同时被分配给多个 HR） |
| free_time           | ?         | 该面试官自己在系统中填写的空闲时间                       |
| scheduled_interview | integer[] | 外码（？），该面试官被安排的面试                         |

#### `Interviewee`
| 列名                | 类型              | 备注                                                         |
| ------------------- | ----------------- | ------------------------------------------------------------ |
| id                  | integer           | 外码                                                         |
| assigned_HR         | integer           | 外码，该候选人被分配的 HR                                    |
| scheduled_interview | integer[]         | 外码（？），该候选人被安排的面试（为什么是数组？因为需求里面 HR 可以给同一个候选人安排多场面试） |
| application_result  | string or integer | ['Pending', 'Approved', 'Rejected']，是 HR 给的面试结果，初始值应是 'Pending'。注意这里的结果和单场面试结果的区别：这里的结果是申请的最终结果，HR 自行安排面试的次数，TA 根据所有的单场面试的结果来决定这里的最终结果 |
### `Interview`

| 列名               | 类型    | 备注                      |
| ------------------ | ------- | ------------------------- |
| id                 | integer | unique（自动生成即可）    |
| HR_id              | integer | 外码                      |
| interviewer_id     | integer | 外码                      |
| interviewee_id     | integer | 外码                      |
| HR_token           | string  | 随机生成，可使用 UUID     |
| interviewer_token  | string  | 随机生成，可使用 UUID     |
| interviewee_token  | string  | 随机生成，可使用 UUID     |
| start_time         | time    |                           |
| length             | integer | 单位：分钟                |
| rate               | string  | ['S', 'A', 'B', 'C', 'D'] |
| comment            | string  |                           |
| char_history       | ?       | 需要记录变化信息          |
| whiteboard_history | ?       | 需要记录变化信息          |
| code_history       | ?       | 需要记录变化信息          |
| video_history      | ?       | 需要记录变化信息          |
|                    |         |                           |
|                    |         |                           |

## 接口

> 参数中省略了权限控制等信息，只显示 data 域。权限控制方式（即如何判断下面的 current_user）由负责后端的几位同学自行决定。

| 请求方式 | 请求地址               | 功能                                                         | 参数 data 域                                                 | 返回 | 权限控制                                                     |
| -------- | ---------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ---- | ------------------------------------------------------------ |
| GET      | `/api/user`            | 批量获取用户信息                                             | some filters                                                 |      |                                                              |
| POST     | `/api/user`            | 添加（一或多个）用户（HR、interviewer、interviewee）         | `[{"email": "", "password": "", "role": 1, 2 or 3}]`         |      | current_user.role== admin                                    |
| GET      | `/api/user/<id>`       | 获取指定用户信息                                             |                                                              |      |                                                              |
| PUT      | `/api/user/<id>`       | 修改密码                                                     | `{"passowrd":{"old: "", "new": ""}}`                         |      | current_user.id == id && current_user.role != interviewee    |
|          |                        | 修改个人空闲时间                                             | `{"free_time":?}`                                            |      | current_user.id == id && current_user.role == interviewer    |
|          |                        | 修改申请结果                                                 | `{"application_result":?}`                                   |      | User(id).role == interviewee && current_user.id == User(id).assigned_HR（或者：current_user.role == HR && id in current_user.assigned_interviewee） |
| POST     | `/api/user/assignment` | 添加分配：HR - 候选人间（类型 0）、HR - 面试官间（类型 1），`id1` 和 `id2` 不区分顺序（当然，也可以不要 `type`） | `{"type": 0 or 1, "users": [id1, id2]}`                      |      | current_user.role == admin                                   |
| GET      | `/api/interview`       | 批量获取面试信息                                             | some filters                                                 |      |                                                              |
| POST     | `/api/interview`       | 添加面试（同时也要给候选人发通知面试的邮件，邮件里的面试链接有 TA 的 token） | `{"HR_id":?, "interviewer_id":?, "interviewee_id":?, "start_time":?, "length":?}` |      | current_user.role== admin                                    |
| GET      | `/api/interview/<id>`  | 获取指定面试信息                                             |                                                              |      |                                                              |
| PUT      | `/api/interview/<id>`  | 添加面试评价                                                 | `{"rate":?,comment:""}`                                      |      | Interview(id).interviewer_id = current_user.id               |
|          |                        | 更新面试记录                                                 | `{"char_history":?, "whiteboard_history":?, "code_history":?, "video_history":?}` |      | ?                                                            |
|          |                        |                                                              |                                                              |      |                                                              |
|          |                        |                                                              |                                                              |      |                                                              |



## 测试/运维

TBD