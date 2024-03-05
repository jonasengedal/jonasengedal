# NuGet

## Azure Artifact Credential Provider

The [Azure Artifact Credential Provider](https://github.com/microsoft/artifacts-credprovider?tab=readme-ov-file#azure-artifacts-credential-provider) automates the acquisition of credentials needed to restore NuGet packages as part of your .NET development workflow.

### Manual installation on Windows

1. Download the latest release of [Microsoft.NuGet.CredentialProvider.zip](https://github.com/Microsoft/artifacts-credprovider/releases)
2. Unzip the file
3. Copy the netcore (and netfx for nuget.exe) directory from the extracted archive to $env:UserProfile\.nuget\plugins (%UserProfile%/.nuget/plugins/)

### Errors

error NU1301: Unable to load the service index for source https://pkgs.dev.azure.com/ can be solved by using the right credentials for the NuGet feed, e.g through the Azure Artifact Credential Provider.

## NuGet.config files

You need to at least the following `NuGet.config` file:

- `%AppData%\Roaming\NuGet\NuGet.Config`

You can consider to also have the below `NuGet.config` files to override or add project specific configurations:

- `C:\src\NuGet.Config`
- `C:\src\domeva\NuGet.config`

`%AppData%\Roaming\NuGet\NuGet.Config` is shared between all projects and will, depending on your credential provider, contain the credentials for NuGet package repositories.

```xml
<?xml version="1.0" encoding="utf-8"?>
<configuration>
  <packageRestore>
    <add key="enabled" value="True" />
    <add key="automatic" value="True" />
  </packageRestore>
  <bindingRedirects>
    <add key="skip" value="False" />
  </bindingRedirects>
  <packageManagement>
    <add key="format" value="0" />
    <add key="disabled" value="False" />
  </packageManagement>
  <packageSources>
    <add key="NuGet" value="https://api.nuget.org/v3/index.json" />
    <add key="Microsoft Visual Studio Offline Packages" value="C:\Program Files (x86)\Microsoft SDKs\NuGetPackages\" />
    <add key="Domeva" value="https://nuget.pkg.github.com/jonasengedal/index.json" />
    <add key="LocalNuGet_Prerelease" value="C:\src\LocalNuGetPrerelease" />
  </packageSources>
  <packageSourceCredentials>
    <Domeva>
      <add key="Username" value="GitHub Username" />
      <add key="Password" value="Encrypted GitHub PAT token with package read" />
    </Domeva>
  </packageSourceCredentials>
</configuration>

`C:\src\NuGet.Config` will contain the package source mapping. TODO: Test and describe when this is needed.

```xml
<?xml version="1.0" encoding="utf-8"?>
<configuration>
 <packageSourceMapping>
  <packageSource key="NuGet">
   <package pattern="*" />
  </packageSource>
  <packageSource key="Domeva">
   <package pattern="Domeva.*" />
  </packageSource>
 </packageSourceMapping>
</configuration>
```

## Local NuGet Prerelease

The script `BuildLocalPrerelease.bat` can be used to build local NuGet prerelease packages. It will use a local file called `local-prelease.txt` to have the incremental build number. Place `BuildLocalPrerelease.bat` in the solution folder containing the project needed to be build to NuGet packages.
