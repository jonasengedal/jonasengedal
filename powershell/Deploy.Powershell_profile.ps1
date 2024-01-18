# Backup existing Powershell profile file
New-Item -Path "$(Split-Path -parent $profile)/Backup" -ItemType Directory -ErrorAction SilentlyContinue
Copy-Item $profile -Destination "$(Split-Path -parent $profile)/Backup/$([DateTime]::UtcNow.ToString('yyyyMMddHHmmss'))_Microsoft.Powershell_profile.ps1"

# Deploy Powershell profile file
Copy-Item ./Microsoft.Powershell_profile.ps1 -Destination $profile