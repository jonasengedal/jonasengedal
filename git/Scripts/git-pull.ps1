function Git-Pull{
  param (
      $GitRepositoryFolder
  )

  $GitRepositoryPath = Join-Path -Path "c:\GitRepos" -ChildPath $GitRepositoryFolder
  $GitStatus = git -C $GitRepositoryPath status -s -b

  $GitIsModified = $GitStatus.Split(" ").Count -gt 4
  If($GitIsModified -eq 0 -and $GitStatus.Contains("[behind")) {
    Write-Host -ForegroundColor "Magenta" $GitRepositoryFolder
    git -C $GitRepositoryPath pull -q
    git -C $GitRepositoryPath status -s -b
  } Elseif($GitIsModified -eq 1) {
    Write-Host -ForegroundColor "Red" $GitRepositoryFolder
    Write-Host $GitStatus
  } Else {
    Write-Host -ForegroundColor "Green" $GitRepositoryFolder
    Write-Host $GitStatus
  }
}

$GitRepositoriesContent =  Get-Content -Path ".\git-repositories.txt"
$GitRepositories = $GitRepositoriesContent -split ","
foreach ($GitRepository in $GitRepositories) {
  Git-Pull -GitRepositoryFolder $GitRepository
}
