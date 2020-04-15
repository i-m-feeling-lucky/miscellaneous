# Guide for Transference

This guide helps you to transfer to GitHub from GitLab. You have two options: 

- ***(Recommended)*** Discard the old remote on GitLab and transfer to the new on GitHub.
- Keep both remote but set the one on GitHub as `origin`.

Take `frontend` repository for example.

## Discard the old

Change URL of `origin` from `git@git.lug.ustc.edu.cn:i-m-feeling-lucky/*` to `git@github.com:i-m-feeling-lucky/`.

```bash
# View existing remotes
$ git remote -v
origin  git@git.lug.ustc.edu.cn:i-m-feeling-lucky/frontend.git (fetch)
origin  git@git.lug.ustc.edu.cn:i-m-feeling-lucky/frontend.git (push)

# Change remote URL for origin directly
git remote set-url origin git@github.com:i-m-feeling-lucky/frontend.git

$ git remote -v
origin  git@github.com:i-m-feeling-lucky/frontend.git (fetch)
origin  git@github.com:i-m-feeling-lucky/frontend.git (push)
```

## Keep both

Rename original name from `origin` to `gitlab`, and add new remote URL as `origin`.

```bash
# View existing remotes
$ git remote -v
origin  git@git.lug.ustc.edu.cn:i-m-feeling-lucky/frontend.git (fetch)
origin  git@git.lug.ustc.edu.cn:i-m-feeling-lucky/frontend.git (push)

# Rename origin to gitlab
$ git remote rename origin gitlab

# Add new remote URL
$ git remote add origin git@github.com:i-m-feeling-lucky/frontend.git

$ git remote -v
gitlab  git@git.lug.ustc.edu.cn:i-m-feeling-lucky/frontend.git (fetch)
gitlab  git@git.lug.ustc.edu.cn:i-m-feeling-lucky/frontend.git (push)
origin  git@github.com:i-m-feeling-lucky/frontend.git (fetch)
origin  git@github.com:i-m-feeling-lucky/frontend.git (push)
```



**Reference**

<https://help.github.com/en/github/using-git/renaming-a-remote>

<https://stackoverflow.com/questions/22265837/transfer-git-repositories-from-gitlab-to-github-can-we-how-to-and-pitfalls-i>