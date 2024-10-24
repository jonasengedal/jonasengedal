# The variable $profile contain the location of this file on the computer
# You can use the script Deploy.PowerShell_profile.ps1 to deploy it
Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt -Theme paradox

# Create shortkey functions for common git commands
function gco { 
    [CmdletBinding()]
    param (
        [Parameter(Position = 1, Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$Branch
    )
    PROCESS {
        git checkout $Branch
        git pull
    }
}

function gcn { 
    [CmdletBinding()]
    param (
        [Parameter(Position = 1, Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$Branch
    )
    PROCESS {
        git checkout -b $Branch
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

function Update-GitBranchRestHard {
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
    param (
        [Parameter(Position = 1, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$Commit = "HEAD^"
    )

    Update-GitBranchRestHard $Commit -Confirm
}

function Update-GitBranchRestSoft {
    [CmdletBinding(SupportsShouldProcess,
        ConfirmImpact = 'High')]
    param (
        [Parameter(Position = 1, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$Commit = "HEAD^"
    )
    PROCESS {
        if ($PSCmdlet.ShouldProcess('RESET SOFT')) {
            git reset --soft $Commit
        }    
    }
}

function grs {
    param (
        [Parameter(Position = 1, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$Commit = "HEAD^"
    )

    Update-GitBranchRestSoft $Commit -Confirm
}

function Remove-GitBranchesNotInRemote {
    [CmdletBinding(SupportsShouldProcess,
        ConfirmImpact = 'High')]
    param()
    PROCESS{
        git branch -v | findstr "\[gone\]"

        if ($PSCmdlet.ShouldProcess('Delete branches not in remote even when NOT fully merged')) {
            git branch -v | findstr "\[gone\]" | ForEach-Object { git branch -D $_.split(" ")[2] }
        }
        else{
            git branch -v | findstr "\[gone\]" | ForEach-Object { git branch -d $_.split(" ")[2] }
        }
    }
}

function gbd {
    Remove-GitBranchesNotInRemote -Confirm
}

function Remove-GitBranchesThatAreBackups {
    [CmdletBinding(SupportsShouldProcess,
        ConfirmImpact = 'High')]
    param()
    PROCESS {
        git branch -l *-backup-*

        if ($PSCmdlet.ShouldProcess('Delete branches that contain "-backup-" in the name')) {
            git branch -l *-backup-* | ForEach-Object { git branch -D $_.split(' ')[2] }
        }
    }
}

function gbdb {
    Remove-GitBranchesThatAreBackups -Confirm
}
function gmain { git checkout main; git pull }
function gdev { git checkout dev; git pull }
function gpl { git pull }
function gph { git push }
function gpo { $b = git branch --show-current; git push origin -u $b }
function gmd { $b = git branch --show-current; git checkout dev; git pull; git checkout $b; git merge dev }
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
