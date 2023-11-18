#!/usr/bin/env bash

set -Eeuo pipefail
shopt -s nullglob

function stop_services {
  echo
  run-parts /root/stop
  date +'🏁 Stopped at %c.'
  exit
}
trap 'stop_services' exit
trap 'exit' SIGTERM SIGINT

run-parts /root/start
date +'🚩 Started at %c.'

sleep infinity &
wait $!

