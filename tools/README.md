# Tools Used

## Installed Tools

Tools and packages are managed mainly using [Winget](https://learn.microsoft.com/en-us/windows/package-manager/winget/). If a tool or package is not available in Winget then [Chocolatey](https://chocolatey.org/) is used.

### Winget

List packages managed by Winget.

```bash
winget list
```

### Chocolatey

List packages managed by Chocolatey.

```bash
choco list -lo
```

Packages currently managed by Chocolatey.

```bash
# Move packages to Winget
azure-functions-core-tools-2 3.0.3442
chocolatey 0.11.2
chocolatey-core.extension 1.3.5.1
chocolatey-dotnetfx.extension 1.0.1
chocolatey-visualstudio.extension 1.10.2
chocolatey-windowsupdate.extension 1.0.4
dbeaver 23.0.2
dotnetfx 4.8.0.20190930
git 2.33.0.2
git.install 2.33.0.2
jq 1.6
k9s 0.27.3
KB2919355 1.0.20160915
KB2919442 1.0.20160915
KB2999226 1.0.20181019
KB3033929 1.0.5
KB3035131 1.0.3
kubernetes-cli 1.26.1
NSwagStudio 13.19.0
nvm 1.1.5
nvm.portable 1.1.7
python 3.10.7
python3 3.10.7
vault 1.12.2
vcredist140 14.29.30133
vcredist2015 14.0.24215.20170201
visualstudio-installer 2.0.3
visualstudio2017-workload-vctools 1.3.3
visualstudio2017buildtools 15.9.39.0
visualstudio2019-workload-vctools 1.0.1
visualstudio2019buildtools 16.11.18.0
```

## Code Editor

* Microsoft Visual Studio Enterprise 2022 (64-bit)
* Microsoft Visual Studio Code

## Database Editor

[DBeaver](https://dbeaver.io/) is good cross database tool.

## Visual Studio Extensions

Currently no Visual Studio extensions are installed.

## Visual Studio Code Extensions

List all Visual Studio Code Extensions

```bash
code --list-extensions
```

```bash
Azurite.azurite
bierner.markdown-mermaid
bpruitt-goddard.mermaid-markdown-syntax-highlighting
DavidAnson.vscode-markdownlint
davidmarek.jsonpath-extract
dbaeumer.vscode-eslint
donjayamanne.githistory
DotJoshJohnson.xml
dsznajder.es7-react-js-snippets
ecmel.vscode-html-css
EditorConfig.EditorConfig
esbenp.prettier-vscode
formulahendry.dotnet-test-explorer
github.vscode-github-actions
Gruntfuggly.triggertaskonsave
hbenl.vscode-test-explorer
hediet.vscode-drawio
humao.rest-client
jebbs.plantuml
jflbr.jwt-decoder
makhan.epoch-converter
Mebrahtom.plantumlpreviewer
ms-azure-devops.azure-pipelines
ms-azuretools.vscode-azureappservice
ms-azuretools.vscode-azurefunctions
ms-azuretools.vscode-azurelogicapps
ms-azuretools.vscode-azureresourcegroups
ms-azuretools.vscode-azurestorage
ms-azuretools.vscode-bicep
ms-azuretools.vscode-docker
ms-azuretools.vscode-logicapps
ms-dotnettools.csdevkit
ms-dotnettools.csharp
ms-dotnettools.vscode-dotnet-runtime
ms-dotnettools.vscodeintellicode-csharp
ms-kubernetes-tools.vscode-kubernetes-tools
ms-python.python
ms-python.vscode-pylance
ms-vscode-remote.remote-containers
ms-vscode-remote.remote-wsl
ms-vscode.azure-account
ms-vscode.powershell
ms-vscode.test-adapter-converter
msazurermtools.azurerm-vscode-tools
pspester.pester-test
quicktype.quicktype
redhat.vscode-yaml
richie5um2.vscode-statusbar-json-path
SimonSiefke.svg-preview
tamasfe.even-better-toml
Vue.volar
```
