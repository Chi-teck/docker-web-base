#!/usr/bin/env bash

set -Eeuo pipefail

function wb_label {
  echo -e "\n\e[30;46m $* \e[0m\n"
}

php_versions='7.3 7.4 8.0 8.1 8.2 8.3'
images_dir=$(dirname "$(readlink -f "$0")")/../images

target=all
push=false
remove=false

for arg in "$@"
do
  if [[ $arg == '--push' ]]; then
    push=true
  elif [[ $arg == '--remove' ]]; then
    remove=true
  else
    target=$arg
  fi
done

for image in dev nginx; do
  if [[ $target = all || $target = "$image" ]]; then
    wb_label $image
    docker build -t attr/$image $images_dir/$image
    [[ $push = true ]] && docker push attr/$image
    [[ $remove = true ]] && docker rmi attr/$image
  fi
done

for image in dev-apache-php dev-php-fpm php-fpm; do
  for php_version in $php_versions; do
    if [[ $target = all || $target = "$image" ]]; then
      wb_label $image:$php_version
      docker build -t attr/$image:$php_version --build-arg="PHP_VERSION=$php_version" $images_dir/$image
      [[ $push = true ]] && docker push attr/$image:$php_version
      [[ $remove = true ]] && docker rmi attr/$image:$php_version
    fi
  done
done
