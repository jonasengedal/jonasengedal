@echo off

pushd %~dp0
set /p version=<../version.md
if not exist "local-prerelease.txt" (
    echo 0 > local-prerelease.txt
)
set /p prereleaseversion=<local-prerelease.txt
    set /a newprerelease=%prereleaseversion%+1
set buildversion=%version%.%newprerelease%
dotnet restore Domeva.sln --interactive
dotnet build Domeva.sln --no-restore --configuration Debug
dotnet pack Domeva.sln --no-build --configuration Debug -p:PackageVersion= --output C:/src/LocalNuGetPrerelease/ -p:PackageVersion=%buildversion%-alpha --include-symbols --include-source
echo %newprerelease% > local-prerelease.txt
popd