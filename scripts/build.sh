#!/usr/bin/env bash

set -Eeuo pipefail

function wb_label {
  echo -e "\n\e[30;46m $* \e[0m\n"
}

php_versions='7.3 7.4 8.0 8.1 8.2 8.3'
php_latest_version='8.3'
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

    image_id=attr/$image
    wb_label $image_id
    docker build -t $image_id $images_dir/$image
    [[ $push = true ]] && docker push $image_id
    [[ $remove = true ]] && docker rmi $image_id || true

  fi
done

for image in dev-apache-php dev-php-fpm php-fpm; do
  for php_version in $php_versions; do
    if [[ $target = all || $target = "$image" ]]; then

      image_id=attr/$image:$php_version
      wb_label $image_id
      docker build -t $image_id --build-arg="PHP_VERSION=$php_version" $images_dir/$image
      [[ $push = true ]] && docker push $image_id
      [[ $remove = true ]] && docker rmi $image_id || true

      if [[ $php_version = "$php_latest_version" ]]; then
        image_id=attr/$image:latest
        wb_label $image_id
        docker build -t $image_id --build-arg="PHP_VERSION=$php_version" $images_dir/$image
        [[ $push = true ]] && docker push $image_id
        [[ $remove = true ]] && docker rmi $image_id || true
      fi

    fi
  done
done
