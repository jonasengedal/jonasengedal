# NuGet

## Azure Artifact Credential Provider

The [Azure Artifact Credential Provider](https://github.com/microsoft/artifacts-credprovider?tab=readme-ov-file#azure-artifacts-credential-provider) automates the acquisition of credentials needed to restore NuGet packages as part of your .NET development workflow.

### Manual installation on Windows

1. Download the latest release of [Microsoft.NuGet.CredentialProvider.zip](https://github.com/Microsoft/artifacts-credprovider/releases)
2. Unzip the file
3. Copy the netcore (and netfx for nuget.exe) directory from the extracted archive to $env:UserProfile\.nuget\plugins (%UserProfile%/.nuget/plugins/)

### Errors

error NU1301: Unable to load the service index for source https://pkgs.dev.azure.com/ can be solved by using the right credentials for the NuGet feed, e.g through the Azure Artifact Credential Provider.
