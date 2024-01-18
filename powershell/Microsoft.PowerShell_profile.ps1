# The variable $profile contain the location of this file on the computer
# You can use the script Microsoft.PowerShell_profile.ps1 to deploy it
Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt -Theme paradox

# Create aliases for common git commands
function gco { 
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

function gs {
    [CmdletBinding()]
    param (
        [Parameter(Position = 1, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$Message
    )
    PROCESS {
        git stash -u -m $Message
    }
}

function gsl {
    return git stash list
}

function gsp {
    [CmdletBinding()]
    param (
        [Parameter(Position = 1, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [Int32]$Index
    )
    PROCESS {
        git stash pop $Index
    }
}

function gsd {
    [CmdletBinding()]
    param (
        [Parameter(Position = 1, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [Int32]$Index
    )
    PROCESS {
        git stash drop $Index
    }
}

function grh {
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

function grs {
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

function gmain { git checkout main; git pull }
Set-Alias -Name gmain -Value gmain -Scope Global
function gpl { git pull }
function gph { git push }
function gpo { $b = git branch --show-current; git push origin -u $b }
function gmm { $b = git branch --show-current; git checkout main; git pull; git checkout $b; git merge main }
function grm { $b = git branch --show-current; git branch "$b-backup-$(Get-Date -f "HHmmss")"; $c = git stash create; git reset --hard; git checkout main; git pull; git checkout $b; git rebase main; if ($c) { git stash apply $c } }
function dpostgres { 
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
