# Guidelines

## Git

1. No binary files.

2. Commit message: English, first letter capitalized, short (50 chars or less), no period.

3. No `git push --force`.

4. Always use LF instead of CRLF. (Tips for Windows users: `git config --global core.autocrlf false`, `git config --global core.eol lf`, see [Stack Overflow](https://stackoverflow.com/a/13154031/8418049)).

5. Workflow: 

   ```bash
   git checkout -b xxx-feature
   
   ...
   git commit -m "Finish first part"
   
   ...
   git commit -m "Finish second part"
   
   git checkout master
   git pull
   
   # Disable fast-forward, always create a new commit object
   git merge --no-ff xxx-feature
   
   # If conflicts occur, resolve them, then run `git {add|rm}` on conflicts file(s)
   git {add|rm} <file>
   # With all conflicts resovled, run
   git commit [-m "Resolved merge conflict by ..."]
   # For more details, see https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/resolving-a-merge-conflict-using-the-command-line
   
   git branch -d xxx-feature
   git push
   ```


## ESLint

1. Style guide: Airbnb.
2. Use `...eslint-disable...` as little as possible.