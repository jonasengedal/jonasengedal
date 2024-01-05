# Using Docker in .NET projects

## Build docker image of a .Net project

Executable is build by dotnet outside of the image.

```bash
#!/bin/bash
dotnet build --configuration Debug
docker build -t image-tag -f Dockerfile .\bin\Debug\net7.0
```
