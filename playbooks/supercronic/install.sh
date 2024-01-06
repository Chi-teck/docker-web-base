#!/usr/bin/env bash

set -Eeuo pipefail

# Latest releases available at https://github.com/aptible/supercronic/releases
supercronic_url='https://github.com/aptible/supercronic/releases/download/v0.2.29/supercronic-linux-amd64'
supercronic='supercronic-linux-amd64'
supercronic_sha1sum='cd48d45c4b10f3f0bfdd3a57d054cd05ac96812b'

curl -fsSLO $supercronic_url
echo "${supercronic_sha1sum}  ${supercronic}" | sha1sum -c -
chmod u+x $supercronic
mv $supercronic /usr/local/bin/supercronic
