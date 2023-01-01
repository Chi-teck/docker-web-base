#!/usr/bin/env bash

set -Eeuo pipefail
set +x
playbooks="$*"

# Collect dependencies
for playbook in $playbooks; do
  dir="/usr/lib/playbooks/$playbook"
  if [ -f $dir/dependencies.txt ]; then
    playbooks="$(cat $dir/dependencies.txt) $playbooks"
  fi
done
playbooks=$(echo -e "${playbooks// /\\n}" | awk '!a[$0]++')

# Check.
for playbook in $playbooks; do
  if [[ ! -d /usr/lib/playbooks/$playbook ]]; then
    echo -e "\e[91mPlaybook ${playbook} does not exists.\e[0m" >&2
    exit 1
  fi
done

# Export playbooks.
echo 'Playbooks to be installed'
for playbook in $playbooks; do
  echo " • $playbook"
  # shellcheck disable=SC2046
  export PLAYBOOK_$(echo $playbook | tr '[:lower:]' '[:upper:]' | tr - _)=1
done
echo

# Pre-install.
for playbook in $playbooks; do
  dir="/usr/lib/playbooks/$playbook"
  if [ -f $dir/pre-install.sh ]; then
    echo "🚩 Pre-install $playbook"
    DIR=$dir source "$dir/pre-install.sh"
  fi
done

# Install.
for playbook in $playbooks; do
  dir="/usr/lib/playbooks/$playbook"
  if [ -f $dir/install.sh ]; then
    echo "🚩 Install $playbook"
    DIR=$dir source "$dir/install.sh"
  fi
done

# Post-install.
for playbook in $playbooks; do
  dir="/usr/lib/playbooks/$playbook"
  if [ -f $dir/post-install.sh ]; then
    echo "🚩 Post-install $playbook"
    DIR=$dir source "$dir/post-install.sh"
  fi
done

# Configure services.
for playbook in $playbooks; do
  echo "🚩 Configure services for $playbook"
  dir="/usr/lib/playbooks/$playbook"
  if [ -f $dir/start.sh ]; then
    envsubst < "$dir/start.sh" > /root/start/$playbook.sh
  fi
  if [ -f $dir/stop.sh ]; then
    envsubst < "$dir/stop.sh" > /root/stop/$playbook.sh
  fi
done
