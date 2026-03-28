#!/usr/bin/env bash

set -Eeuo pipefail

function wb_label {
  echo -e "\n\e[30;46m $* \e[0m\n"
}

readonly php_versions='7.3 7.4 8.0 8.1 8.2 8.3 8.4 8.5'
readonly php_latest_version='8.5'
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

# Build base dev image.
if [[ $target = all || $target = dev ]]; then
  wb_label attr/dev
  docker build -t attr/dev "$images_dir/dev"
  [[ $push = true ]] && docker push attr/dev
  [[ $remove = true ]] && (docker rmi attr/dev || true)
fi

# Build PHP images for each version in the matrix.
for image in dev-apache-php dev-php-fpm php-fpm; do
  for php_version in $php_versions; do
    if [[ $target = all || $target = "$image" ]]; then
      image_id=attr/$image:$php_version
      wb_label $image_id
      docker build -t $image_id --build-arg="PHP_VERSION=$php_version" $images_dir/$image

      if [[ $php_version = "$php_latest_version" ]]; then
        docker tag "attr/$image:$php_version" "attr/$image:latest"
        [[ $push = true ]] && docker push "attr/$image:latest"
        [[ $remove = true ]] && (docker rmi "attr/$image:latest" || true)
      fi

      [[ $push = true ]] && docker push $image_id
      [[ $remove = true ]] && (docker rmi $image_id || true)
    fi
  done
done
