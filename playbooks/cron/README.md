## Cron

### Configuration

```Dockerfile
COPY my-tasks my-tasks
RUN crontab my-tasks && rm my-tasks
```

