# Dev

A generic Docker image with dev tools.

## Extending

```Dockerfile
FROM attr/dev

ARG USER_NAME
ARG USER_GID
ARG USER_UID
ARG USER_PASSWORD

# Change attributes of default user account.
RUN userdel wb && \
    groupadd -g $USER_GID $USER_NAME && \
    useradd $USER_NAME -m -u $USER_UID -g $USER_GID -Gsudo -s /bin/bash && \
    echo $USER_NAME:$USER_PASSWORD | chpasswd
```
