## PostgreSQL

### Available variables

Note that this Postgres account will only be created when user playbook is installed.

- POSTGRESQL_USER (default value: $USER_NAME)
- POSTGRESQL_PASSWORD (default value: 123)

### Mounting
In order to preserve database when rebuilding the container mount host
data to the container as follows:
```
/host/path/to/pg/data:/var/lib/postgresql/15/main
```

Default port: 5432
