#!/usr/bin/env sh

curl --version >> /dev/null
if [ $? -eq 0 ]; then
    curl -o /etc/letsencrypt/acme-dns-auth.py https://wackyblackie.github.io/acme-dns-certbot/acme-dns-auth.py
    chmod 0700 /etc/letsencrypt/acme-dns-auth.py
else
    echo "$(tput setaf 14)$?$(tput sgr0): Please install curl OR Problem with curl"
fi
