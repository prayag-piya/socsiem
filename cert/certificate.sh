#!/usr/bin/env bash
RED="\033[1;31m"
GREEN="\033[1;32m"
NOCOLOR="\033[0m"


unzip() {
    unzip ~/certs.zip -d ~/certs
}

/usr/share/elasticsearch/bin/elasticsearch-certutil cert ca --pen --in instances.yml --keep-ca-key --out ~/certs.zip
unzip
if [[ $? == 0 ]]; then
    clear
    echo -e "${RED}No unzip found${NOCOLOR}"
    echo -e "${GREEN}Installing unzip${NOCOLOR}"
    unzip
fi

mkdir /etc/elasticsearch/certs/ca -p
cp -R ~/certs/ca/ ~/certs/socsiem/* /etc/elasticsearch/certs/
mv /etc/elasticsearch/certs/socsiem.crt /etc/elasticsearch/certs/elasticsearch.crt
mv /etc/elasticsearch/certs/socsiem.key /etc/elasticsearch/certs/elasticsearch.key
chown -R elastcisearch: /etc/elasticsearch/certs
chmod -R 500 /etc/elasticsearch/certs
chmod 400 /etc/elasticsearch/certs/ca/ca.* /etc/elasticsearch/certs/elasticsearch.*
