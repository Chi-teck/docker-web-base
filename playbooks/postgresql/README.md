## PostgreSQL

### Available variables

- POSTGRESQL_PASSWORD (default value: 123)

Default port: 5432

### Mounting
In order to preserve database when rebuilding the container mount host
data to the container as follows:
```
/host/path/to/pg/data:/var/lib/postgresql/15/main
```
