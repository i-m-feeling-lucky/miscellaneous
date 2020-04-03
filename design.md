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
        - [`Room`](#room)
    - [接口](#接口)
    - [测试](#测试)

<!-- /TOC -->

## 前端

| 页面     | 首页                   | 超管个人中心                                                 | HR 个人中心                    | 面试官个人中心                 | 面试房间                                                     |
| -------- | ---------------------- | ------------------------------------------------------------ | ------------------------------ | ------------------------------ | ------------------------------------------------------------ |
| 地址     | `/`                    | `/user/<id>`                                                 | `/user/<id>`                   | `/user/<id>`                   | `/room/<id>?token=XXXXX`                                     |
| 访问控制 | 无                     | 需超管账号密码登录                                           | 需 HR 账号密码登录             | 需面试官账号密码登录           | 无 token 或无效 token 禁止访问（共有三个 token）             |
| 内容一   | 登录（邮箱框、密码框） | 查看当前所有用户                                             | 个人密码修改（旧密码、新密码） | 个人密码修改（旧密码、新密码） | 面试前：该场面试的信息；<br />面试中：面试界面（根据三类 token 区别显示）；<br />面试后：回溯界面（注意此时只有 HR 的 token 有效） |
| 内容二   |                        | 添加用户（根据 role 不同而单个或批量，可放在左上角）         |                                |                                |                                                              |
| 内容三   |                        | 添加分配（HR - 候选人间、HR - 面试官间，可放在每个用户条目中） |                                |                                |                                                              |
| 内容四   |                        | 个人密码修改（旧密码、新密码）                               |                                |                                |                                                              |
| 内容五   |                        |                                                              |                                |                                |                                                              |
| 内容六   |                        |                                                              |                                |                                |                                                              |




## 数据库

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

| 列名                 | 类型      | 备注                 |
| -------------------- | --------- | -------------------- |
| id                   | integer   | 外码                 |
| assigned_interviewer | integer[] | 该 HR 被分配的面试官 |
| assigned_interviewee | integer[] | 该 HR 被分配的候选人 |


#### `Interviewer`

| 列名        | 类型      | 备注                                         |
| ----------- | --------- | -------------------------------------------- |
| id          | integer   | 外码                                         |
| assigned_HR | integer[] | 该面试官被分配的 HR（可同时被分配给多个 HR） |
|             |           |                                              |
|             |           |                                              |

#### `Interviewee`
| 列名        | 类型    | 备注                |
| ----------- | ------- | ------------------- |
| id          | integer | 外码                |
| assigned_HR | integer | 该候选人被分配的 HR |
|             |         |                     |
|             |         |                     |
### `Room`

| 列名               | 类型    | 备注                      |
| ------------------ | ------- | ------------------------- |
| id                 | integer | unique（自动生成即可）    |
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

> 参数中省略了权限控制等信息，只显示 data 域。

| 请求方式 | 请求地址           | 功能                                                         | 参数 data 域                                         | 返回 | 权限控制                  | 相关表 |
| -------- | ------------------ | ------------------------------------------------------------ | ---------------------------------------------------- | ---- | ------------------------- | ------ |
| POST     | `/api/user`        | 添加（一或多个）用户（HR、interviewer、interviewee）         | `[{"email": "", "password": "", "role": 1, 2 or 3}]` |      | current_user.role== admin | `User` |
| GET      | `/api/user/<id>`   | 获取用户信息                                                 |                                                      |      |                           | `User` |
| POST     | `/api/user/assign` | 添加分配：HR - 候选人间（类型 0）、HR - 面试官间（类型 1），`id1` 和 `id2` 不区分顺序（当然，也可以不要 `type`） | `{"type": 0 or 1, "users": [id1, id2]}`              |      | current_user.role== admin | `User` |
| PUT      | `/api/user/<id>`   | 修改密码                                                     | `{"data": {"old_password": "", "new_password": ""}}` |      | current_user.id == id     | `User` |
| GET      | `/api/room/<id>`   | 获取面试信息                                                 |                                                      |      |                           | `Room` |
|          |                    |                                                              |                                                      |      |                           |        |
|          |                    |                                                              |                                                      |      |                           |        |
|          |                    |                                                              |                                                      |      |                           |        |
|          |                    |                                                              |                                                      |      |                           |        |
|          |                    |                                                              |                                                      |      |                           |        |



## 测试

TBD