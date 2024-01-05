# Run PostgreSQL in Docker

Download latest PostgreSQL docker image

```bash
docker pull postgres
```

Create postgres container with name `local-postgres` and run it.

```bash
docker run --name local-postgres -e POSTGRES_PASSWORD=Password123 -p 5432:5432 -d postgres
```

Connect to the database with following connection string. Using localhost instead of 127.0.0.1 gives timeout exception in dotnet.

```bash
Server=127.0.0.1;Port=5432;User Id=postgres;Password=Wel123;Database=postgres
```

Common Docker commands.

```bash
docker start local-postgres
docker stop local-postgres

# Remove docker container. Need to call this before docker run can be called again
docker rm local-postgres
```

Execute `psql -U postgres` inside the `local-postgres` container.

```bash
docker exec -it local-postgres psql -U postgres
```

## Dotnet EF database commands

```bash
# Update database
dotnet ef database update
# Create an "Empty" migrations to verify that no code changes are missing a DB migration
dotnet ef migrations add Empty
# Remove latest migration
dotnet ef migrations remove
```
