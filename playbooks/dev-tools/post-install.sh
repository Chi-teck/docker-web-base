#!/usr/bin/env bash

set -Eeuo pipefail

if [[ -n ${PLAYBOOK_USER:-} ]]; then
    mc_ini=/home/$USER_NAME/.config/mc/ini
    if [[ -f $mc_ini ]]; then
       sed -i 's/skin=default/skin=julia256/g' /home/broker/.config/mc/ini
    fi
fi
