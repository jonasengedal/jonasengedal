<#
.DESCRIPTION
Will recursively write out all project references in .csproj files under the provided -RootPath
#>
Param(
    [Parameter(Mandatory, HelpMessage = "Root path of search for .csproj files")]
    [string] $RootPath
)

$projectFiles = get-childitem $RootPath *.csproj -Recurse 

foreach( $projectFile in $projectFiles )
{
    $projectXml = [xml] (get-content $projectFile.FullName)
    $projectDir = $projectFile.DirectoryName
    Set-Location $projectDir

    Write-Host "# $($projectFile.FullName) #"


    foreach( $itemGroup in $projectXml.Project.ItemGroup )
    {
        if( $itemGroup.ProjectReference.Count -eq 0 )
        {
            continue
        }

        foreach( $reference in $itemGroup.ProjectReference )
        {
            if( $reference.Include -eq $null )
            {
                continue
            }

            if( $reference.HintPath -eq $null )
            {
                $projectReference = "{0}" -f $reference.Include
                Write-Host ($projectReference)

                $split = ($projectReference | Split-Path | Split-Path | Resolve-Path)
                Write-Host "Ref Folder: $split"
            }
            else
            {
                # $fullpath = $reference.HintPath
                if(-not [System.IO.Path]::IsPathRooted( $fullpath ) )
                {
                    # $fullPath = (join-path $projectDir $fullpath)
                    # $fullPath = [System.IO.Path]::GetFullPath("$fullPath")
                }
                # Write-Host 'Path: $fullpath'
            }
        }
    }

    Write-Host ''
}

Set-Location $PSScriptRoot