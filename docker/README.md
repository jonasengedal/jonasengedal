# Docker commands

## Use Rancher Desktop to host Docker engine

[Docker Desktop](https://www.docker.com/products/docker-desktop/) now require a license which you often do not have. Best available alternative is [RancherDesktop](https://rancherdesktop.io/).

## Common commands

List installed docker images.

```bash
docker images
```

List all (`-a`) docker containers. Omit `-a` to only get running containers.

```bash
docker ps -a
```

Create docker container from docker image and run the container in the background by specifying the `-d` (`--detach`) argument.

```bash
docker run --name container-name -d image-name
```

Start existing docker container

```bash
docker start container-name
```

Stop docker container

```bash
docker stop container-name
```

Remove docker container

```bash
docker rm container-name
```

Run image and destroy the container after completion.

```bash
docker run -it --rm image-name
```

Read content of docker image.

```bash
# linux image
docker run -it --entrypoint sh image-name
# windows image
docker run -it --entrypoint cmd image-name
```

Get docker logs for container.

```bash
docker logs local-postgres
```

Check if port `5432` is alreay in use.

```bash
netstat -ano | findstr :5432
```

Get process name with id `10368`.

```bash
tasklist /fi "pid eq 10368"
```
