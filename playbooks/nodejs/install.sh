#!/usr/bin/env bash

set -Eeuo pipefail

# Install Node.js and NPM.
curl -sL https://deb.nodesource.com/setup_$NODEJS_VERSION.x | bash - && apt-get install -y nodejs

# Install Yarn.
npm install --global yarn
