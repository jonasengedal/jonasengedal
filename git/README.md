# Commonly used commands

Add all files to stage

```bash
#!/bin/bash
git add .
```

Remove all files from stage

```bash
#!/bin/bash
git reset
```

## Working with branches

Create a local branch based on local master and set the local branch to track a new remote branch.

```bash
#!/bin/bash
git checkout master
git pull
git checkout -b feature/feature-branch
git push -u origin feature/feature-branch
```

Rebase changes of ancestor branch into current branch. Commonly used for rebasing a feature branch with master. Do this as first thing in the morning.

```bash
#!/bin/bash
git stash -u -m 'local-changes'
git checkout master
git pull
git checkout feature/feature-branch
git rebase master
git push
# Only pop the stash if you added a stash above
# git stash pop}
```

Prune tracking branches no longer present at remote.

```bash
#!/bin/bash
git remote prune origin
```

Set remote url

```bash
#!/bin/bash
#git remote set-url <remote-name> <remote-url>
git remote set-url origin https://[jonasengedal@]github.com/jonasengedal/jonasengedal.git
```

## Working with stash

```bash
#!/bin/bash
git stash list
git stash drop 0
git stash pop 0
git stash apply 0
```

## Working with local commits

### Delete local commits

Delete local commits that have not already been pushed to master.

```bash
#!/bin/bash
git reset --hard HEAD^
```

Delete local commits that have not already been pushed to master and keep the changes locally.

```bash
#!/bin/bash
git reset --soft HEAD^

### Reset last commit

Reset last commit while keeping the changes made in the commit.

```bash
#!/bin/bash
git reset --soft HEAD~1
```

Reset/undo last commit while deleting the changes made in the commit.

```bash
#!/bin/bash
git reset --reset HEAD~1

```

### Move local commits to other local branch

When the local commits on master have not been pushed to remote master. In this example to latest 2 commits will be moved to newbranch. A sha1-of-commit can also be used instead of the commit index.

NOTE: This approach required that the HEAD~3 commit have been pushed to remote master and that HEAD~1-2 has not been pushed to remote master. See [this](https://stackoverflow.com/questions/1628563/move-the-most-recent-commits-to-a-new-branch-with-git) for details on why.

```bash
#!/bin/bash
git checkout master
git log
# note down how many commits should be moved. 
git checkout -b newbranch HEAD~2
git merge master
git checkout master
git reset --hard HEAD~2
```

### Rebase

If you are merging Github PRs using Squash and Merge, and you have created branches based of another local branch that was merged to main, then merging main to a feature branch will lead to many merge issues as the feature branch is having commits that are not present in main. In this case you need to use the rebase command to replay your local commits on top of the main commit history.

```bash
#!/bin/bash
git branch feature-branch-backup
git checkout main
git pull
git checkout feature-branch
git rebase main
# if merge conflicts occur then fix them manually and run
# git add path/to/conflicted/file.txt
# git rebase --continue
# or to abort rebase run
# git rebase --abort

# if you have already pushed the feature branch to origin then you need to force push to change the origin commit history
# CAUTION: Only do this if no other has pulled the feature branch
git push origin --force feature-branch
```

### Interactive rebase

Use interactive rebase to rewrite your LOCAL commit history. Remember to NEVER rewrite your local commit history if the commits have already been pushed to a remote/shared repository.
See [Interactive Rebase: Clean up yout Commit History](https://css-tricks.com/interactive-rebase-clean-up-your-commit-history/) for examples.
