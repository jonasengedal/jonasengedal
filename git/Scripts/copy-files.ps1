$GitReposFolder = "C:/GitRepos"
$GitToolsScriptsFolder = Join-Path -Path $GitReposFolder -ChildPath "GitTools/Scripts"
Join-Path -Path $GitToolsScriptsFolder -ChildPath "git-status.ps1" | Copy-Item -Destination $GitReposFolder -Force
Join-Path -Path $GitToolsScriptsFolder -ChildPath "git-commit-log.ps1" | Copy-Item -Destination $GitReposFolder -Force
Join-Path -Path $GitToolsScriptsFolder -ChildPath "git-pull.ps1" | Copy-Item -Destination $GitReposFolder -Force