#!/usr/bin/env bash

set -Eeuo pipefail

mailhog_version='v1.0.1'

wget --quiet https://github.com/mailhog/MailHog/releases/download/$mailhog_version/MailHog_linux_amd64
chmod +x MailHog_linux_amd64
mv MailHog_linux_amd64 /usr/local/bin/mailhog

mhsendmail_version='v0.2.0'
wget --quiet https://github.com/mailhog/mhsendmail/releases/download/$mhsendmail_version/mhsendmail_linux_amd64
chmod +x mhsendmail_linux_amd64
mv mhsendmail_linux_amd64 /usr/local/bin/mhsendmail
