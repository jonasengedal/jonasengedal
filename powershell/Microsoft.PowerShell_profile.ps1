# The variable $profile contain the location of this file on the computer
# You can use the script Microsoft.PowerShell_profile.ps1 to deploy it
Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt -Theme paradox

# Create aliases for common git commands
function gcheckout { 
    [CmdletBinding()]
    param (
        [Parameter(Position = 1, Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$Branch
    )
    PROCESS {
        git checkout main
        git pull
    }
}
function gco { 
    [CmdletBinding()]
    param (
        [Parameter(Position = 1, Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$Branch
    )
    PROCESS {
        gcheckout $Branch
    }
}

function gresethard {
    [CmdletBinding(SupportsShouldProcess,
        ConfirmImpact = 'High')]
    param (
        [Parameter(Position = 1, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$Commit = "HEAD^"
    )
    PROCESS {
        if ($PSCmdlet.ShouldProcess('RESET HARD')) {
            git reset --hard $Commit
        }    
    }
}
function grh {
    [CmdletBinding()]
    param (
        [Parameter(Position = 1, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$Commit
    )
    PROCESS {
        gresethard $Commit
    }
}

function gresetsoft {
    [CmdletBinding(SupportsShouldProcess,
        ConfirmImpact = 'High')]
    param (
        [Parameter(Position = 1, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$Commit = "HEAD^"
    )
    PROCESS {
        if ($PSCmdlet.ShouldProcess('RESET HARD')) {
            git reset --soft $Commit
        }    
    }
}
function grs {
    [CmdletBinding()]
    param (
        [Parameter(Position = 1, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$Commit
    )
    PROCESS {
        gresetsoft $Commit
    }
}

function gmain { git checkout main; git pull }
Set-Alias -Name gmain -Value gmain -Scope Global
function gpull { git pull }
Set-Alias -Name gpl -Value gpull -Scope Global
function gpush { git push }
Set-Alias -Name gph -Value gpush -Scope Global
function gpushorigin { $b = git branch --show-current; git push origin -u $b }
Set-Alias -Name gpo -Value gpushorigin -Scope Global
function gmergemain { $b = git branch --show-current; git checkout main; git pull; git checkout $b; git merge main }
Set-Alias -Name gmm -Value gmergemain -Scope Global
function grebasemain { $b = git branch --show-current; git branch "$b-backup-$(Get-Date -f "HHmmss")"; $c = git stash create; git reset --hard; git checkout main; git pull; git checkout $b; git rebase main; if ($c) { git stash apply $c } }
Set-Alias -Name grm -Value grebasemain -Scope Global
function dockerpostgres { 
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
Set-Alias -Name dpostgres -Value dockerpostgres -Scope Global
