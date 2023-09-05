# Docker commands

## Build docker image of a .Net project

Executable is build by dotnet outside of the image.

```bash
#!/bin/bash
dotnet build --configuration Debug
docker build -t image-tag -f Dockerfile .\bin\Debug\net7.0
```

## Read content of docker image

```bash
#!/bin/bash
# linux image
docker run -it --entrypoint sh image-name
# windows image
docker run -it --entrypoint cmd image-name
```

## Run image and destroy the container

```bash
# !/bin/bash
docker run -it --rm image-name
```
