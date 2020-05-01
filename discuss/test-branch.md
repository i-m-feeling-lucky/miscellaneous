# 测试分支

目前前端的 CI/CD 使用的是 GitHub Actions，push 到 master 分支后触发构建、测试和部署（到 <https://interview.yusanshi.com/>）。

但是有的时候由于本地的某些局限性，你想把“半成品”跑在云上测试效果，又不想“损害”正式的上线版本 <https://interview.yusanshi.com/>，怎么办？

为了解决这个问题，我开了 test 分支，和 master 不能 `git push --force` 不同，test 分支可以随便折腾。push 到 test 分支后会触发同样的构建、测试和部署过程，只不过是部署到了 <https://interview-test.yusanshi.com/>。



**操作指引**

把当前的本地的某个分支 push 到 remote 的 test 分支（本地不需要有 test 分支）。

比如把本地 feature-xxx 的内容 push 到 remote 的 test 分支：

```bash
git push --force origin feature-xxx:test
```

