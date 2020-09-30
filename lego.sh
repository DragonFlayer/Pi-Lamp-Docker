#!/bin/sh

while read line; do export "$line"; done < .env

echo "Renewing..." >> $WORKDIR$LEGO_LOG
sudo docker run $DOCKER_ARGS -v $WORKDIR$DOCKER_VOL -e $DOCKER_ENV goacme/lego $LEGO_ARGS --domains $LEGO_DOMAINS --email $LEGO_EMAIL $1 >> $WORKDIR$LEGO_LOG