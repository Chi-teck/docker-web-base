#!/usr/bin/env bash

set -Eeuo pipefail

playbooks="$*"
playbook_source_dir=/tmp/playbook
playbook_install_dir=/usr/lib/playbook

# Collect dependencies
for playbook in $playbooks; do
  dir="$playbook_source_dir/$playbook"
  if [[ -f $dir/dependencies.txt ]]; then
    playbooks="$(cat $dir/dependencies.txt) $playbooks"
  fi
done
playbooks=$(echo -e "${playbooks// /\\n}" | awk '!a[$0]++')

# Validate.
for playbook in $playbooks; do
  if [[ ! -d "$playbook_source_dir/$playbook" ]]; then
    echo -e "\e[91mPlaybook ${playbook} does not exists.\e[0m" >&2
    exit 1
  fi
done

# Copy playbooks.
mkdir $playbook_install_dir
echo 'Playbooks to be installed:'
for playbook in $playbooks; do
  echo " • $playbook"
  # shellcheck disable=SC2046
  export PLAYBOOK_$(echo $playbook | tr '[:lower:]' '[:upper:]' | tr - _)=1
  cp -r $playbook_source_dir/$playbook $playbook_install_dir/$playbook
done
echo

# Pre-install.
for playbook in $playbooks; do
  dir=$playbook_install_dir/$playbook
  if [[ -f $dir/pre-install.sh ]]; then
    echo "🚩 Pre-install $playbook"
    DIR=$dir source "$dir/pre-install.sh"
  fi
done

# Install.
for playbook in $playbooks; do
  dir=$playbook_install_dir/$playbook
  if [[ -f $dir/install.sh ]]; then
    echo "🚩 Install $playbook"
    DIR=$dir source "$dir/install.sh"
  fi
done

# Post-install.
for playbook in $playbooks; do
  dir=$playbook_install_dir/$playbook
  if [[ -f $dir/post-install.sh ]]; then
    echo "🚩 Post-install $playbook"
    DIR=$dir source "$dir/post-install.sh"
  fi
done

## Configure services.
#mkdir /root/{start,stop}
#for playbook in $playbooks; do
#  echo "🚩 Configure service for $playbook"
#  dir=$playbook_install_dir/$playbook
#  if [ -f $dir/cmd.sh ]; then
#    envsubst < $dir/cmd.sh > $dir/real-cmd.sh
#    chmod u+x $dir/real-cmd.sh
#  fi
#done

# Clean-up.
rm -r $playbook_source_dir
