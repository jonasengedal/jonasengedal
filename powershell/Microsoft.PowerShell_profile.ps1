# The variable $profile contain the location of this file on the computer
# You can use the script Microsoft.PowerShell_profile.ps1 to deploy it
Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt -Theme paradox

# Create aliases for common git commands
Function gitmainfunc { git checkout main; git pull }
Set-Alias -Name gitmain -Value gitmainfunc -Scope Global
Function gitpushoriginfunc { $b = git branch --show-current; git push origin -u $b }
Set-Alias -Name gitpushorigin -Value gitpushoriginfunc -Scope Global
Function gitmergemainfunc { $b = git branch --show-current; git checkout main; git pull; git checkout $b; git merge main }
Set-Alias -Name gitmergemain -Value gitmergemainfunc -Scope Global
Function gitrebasemainfunc { $b = git branch --show-current; git branch "$b-backup-$(Get-Date -f "HHmmss")"; $c = git stash create; git reset --hard; git checkout main; git pull; git checkout $b; git rebase main; if ($c) { git stash apply $c } }
Set-Alias -Name gitrebasemain -Value gitrebasemainfunc -Scope Global
Function dockerpostgresfunc { 
    $cN = "local-postgres"; 
    $c = docker ps -a | Select-String $cN; 
    if (-not $c) { 
        docker run --name $cN -e POSTGRES_PASSWORD=Local123 -p 5432:5432 -d postgres 
    }
    else { 
        docker start $cN
    }
    docker ps -a | Select-String $cN
}
Set-Alias -Name dockerpostgres -Value dockerpostgresfunc -Scope Global
