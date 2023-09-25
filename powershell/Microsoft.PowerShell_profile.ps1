# Place this file in ~/Powershell
# The variable $profile contain the location of this file
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
