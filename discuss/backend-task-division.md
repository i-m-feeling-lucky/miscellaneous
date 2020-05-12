# 后端任务分工

目前的任务主要有

- user 相关的接口 `interview/app/views/user.py`
- interview 相关的接口 `interview/app/views/interview.py`
- user 测试
- interview 测试

接口方面基本上都是先根据 token 校验一下身份，然后对数据库进行操作。可以试试我写
的 [`need_token`] 装饰器，不确定有没有 bug。发邮件的部分可以先放一放。接口的定义
见 [api.yaml]，可以使用 <https://editor.swagger.io/> 查看，数据库的定义见
[design.md][db]。

然后最好把代码风格统一为 [PEP8]（除了每行最多可以有 100 个字符），可以用
[autopep8] 之类的工具进行自动格式化。

[`need_token`]: https://github.com/i-m-feeling-lucky/backend/blob/683204b1414f0f45d22fc2bd5c2a98a1b57c59e1/interview/app/utils.py#L5-L21
[api.yaml]: https://github.com/i-m-feeling-lucky/miscellaneous/blob/master/api.yaml
[db]: https://github.com/i-m-feeling-lucky/miscellaneous/blob/master/design.md#%E6%95%B0%E6%8D%AE%E5%BA%93
[PEP8]: https://www.python.org/dev/peps/pep-0008/
[autopep8]: https://github.com/hhatto/autopep8

## 工作流

先新开一个分支，在该分支上开发，写完后发 pull request，由 wrc review 一下再合并
到 master 中。

```sh
git checkout -b xxx
# 进行开发
git add xx

git commit

git push -u origin xxx

# 然后前往 GitHub 发起 pull request
```

## 可用的工具

[HTTPie][httpie]：用于向服务器发送请求。示例：

Login，发送 JSON `{"email": "foo@bar.com", "password": "pass"}`

```console
$ http :8000/api/login email=foo@bar.com password=pass
HTTP/1.1 200 OK
Date: Sun, 10 May 2020 02:41:12 GMT
Server: WSGIServer/0.2 CPython/3.8.2
Content-Type: application/json
Vary: Origin
Content-Length: 60

{
    "role": 0,
    "token": "81783889-397b-46db-a687-b76a880b394b"
}
```

Logout，指定头部的 X-Token

```console
$ http POST :8000/api/logout x-token:81783889-397b-46db-a687-b76a880b394b
HTTP/1.1 200 OK
Date: Sun, 10 May 2020 02:41:30 GMT
Server: WSGIServer/0.2 CPython/3.8.2
Content-Type: text/html; charset=utf-8
Vary: Origin
Content-Length: 0
```

[httpie]: https://httpie.org/
