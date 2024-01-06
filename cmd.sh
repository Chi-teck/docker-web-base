#!/usr/bin/env bash

set -Eeuo pipefail

if [[ -z ${SERVICE:-} ]]; then
  echo 'Service is not configured. Sleeping...'
  trap 'exit' SIGTERM SIGINT
  sleep infinity &
  wait
fi

dir=/usr/lib/playbook/${SERVICE}
if [[ ! -d $dir ]]; then
  >&2 echo "${SERVICE} is not installed."
  exit 1
fi

cmd=$dir/cmd.sh
if [[ ! -x $cmd ]]; then
  >&2 echo "${SERVICE} cannot be started as a service."
  exit 1
fi

echo "Starting $SERVICE..."
exec $cmd
