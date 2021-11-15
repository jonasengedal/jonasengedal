param($SinceDays=1)

function Git-Commit-Log{
  param (
      $GitRepositoryFolder,
      $CommitLog
  )

  $GitRepositoryPath = Join-Path -Path "c:\GitRepos" -ChildPath $GitRepositoryFolder
  $GitCommitLog = git -C $GitRepositoryPath log --no-merges --since=$SinceDays+" day ago" --until="now" --max-count=10 --format="%Cgreen%ci%Creset %Cblue<%an>%Creset %s%Creset"

  Write-Host "`n------------------------------------------"
  Write-Host -Foregroundcolor "Green" $GitRepositoryFolder
  $GitCommitLog

}

$CommitLog = ".\git-commit.log"

$GitRepositoriesContent =  Get-Content -Path ".\git-repositories.txt"
$GitRepositories = $GitRepositoriesContent -split ","
foreach ($GitRepository in $GitRepositories) {
  Git-Commit-Log -GitRepositoryFolder $GitRepository -CommitLog $CommitLog
}