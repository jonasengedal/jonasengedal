
function Append-Git-Status{
  param (
      $GitRepositoryFolder,
      $StatusLog
  )

  $GitRepositoryPath = Join-Path -Path "c:\GitRepos" -ChildPath $GitRepositoryFolder
  $GitStatus = git -C $GitRepositoryPath status -s -b

  "---------------------------------------------------" | Add-Content -Path $StatusLog
  $GitRepositoryFolder | Add-Content -Path $StatusLog
  #git -C $GitRepositoryPath config --get remote.origin.url | Add-Content -Path $StatusLog
  $GitStatus | Add-Content -Path $StatusLog

  $GitStatusColor = "Green"
  If($GitStatus.Split(" ").Count -gt 4) {
    $GitStatusColor = "Red"
  } Elseif ($GitStatus.Contains("[behind")){
    $GitStatusColor = "Magenta"
  }

  Write-Host -ForegroundColor $GitStatusColor $GitRepositoryFolder
  $GitStatus
}

$StatusLog = ".\git-status.log"

If( Test-Path -Path $StatusLog ) {
  Remove-Item $StatusLog
}

$GitRepositoriesContent =  Get-Content -Path ".\git-repositories.txt"
$GitRepositories = $GitRepositoriesContent -split ","
foreach ($GitRepository in $GitRepositories) {
  Append-Git-Status -GitRepositoryFolder $GitRepository -StatusLog $StatusLog 
}

#Get-Content -Path $StatusLog

