#!/usr/bin/env bash

set -Eeuo pipefail
shopt -s nullglob

function stop_services {
  for cmd in /root/stop/*.sh; do
    # shellcheck disable=SC1090
    source $cmd;
  done
  date +'Started at %c.'
  exit
}
trap 'stop_services' exit
trap 'exit' SIGTERM SIGINT

for cmd in /root/start/*.sh; do
  # shellcheck disable=SC1090
  source $cmd;
done

date +'Started at %c.'
while (( 1 )); do
  sleep 1
done
