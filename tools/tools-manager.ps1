param(
    [Parameter(Position = 0, Mandatory = $false)]
    [bool]$Install = $false
)

$chocoApps = @(
    'k9s', 
    'kubernetes-cli',
    'openssl',
    'tenv')

$wingetApps = @(
    'Bruno.Bruno',
    'dbeaver.dbeaver',
    'Git.Git',
    'Google.Chrome',
    'Graphviz.Graphviz',
    'Hashicorp.Terraform',
    'Hashicorp.Vault',
    'Insomnia.Insomnia',
    'JanDeDobbeleer.OhMyPosh',
    'Microsoft.Azure.StorageExplorer',
    'Microsoft.DotNet.SDK.3_1',
    'Microsoft.DotNet.SDK.6',
    'Microsoft.DotNet.SDK.7',
    'Microsoft.DotNet.SDK.8',
    'Microsoft.DotNet.AspNetCore.6',
    'Microsoft.AzureCLI',
    'Microsoft.VisualStudio.2022.Enterprise',
    'Microsoft.VisualStudioCode',
    'Mozilla.Firefox',
    'Microsoft.PowerShell',
    'Microsoft.PowerToys',
    'Python.Python.3.10',
    'ShareX.ShareX')

if($Install){
    foreach ($app in $chocoApps) {
        Write-Host "Choco install $app"
        choco install $app
    }
    foreach ($app in $wingetApps) {
        Write-Host "Winget install $app"
        winget install --id=$app --exact
    }
}
else {
    foreach ($app in $chocoApps) {
        Write-Host "Choco upgrade $app"
        choco upgrade $app --confirm
    }
    foreach ($app in $wingetApps) {
        Write-Host "Winget upgrade $app"
        winget upgrade --id=$app --exact --silent
    }
}
