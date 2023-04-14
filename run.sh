#!/bin/bash

[ ! -f $PWD/config.json ] && echo "config.json missing! (see config.json.example)" && exit 1

docker build . -t belabox-receiver
docker run --rm -d --restart unless-stopped --name belabox-receiver \
   -p 5000:5000/udp \
   -p 8181:5011/tcp \
   -p 8282:5010/udp \
   -v $PWD/config.json:/app/config.json belabox-receiver

# SLS stats page:
# http://localhost:5011/stats
#
# Belabox
# host: <ip>
# port: 5000
# stream-id: live/stream/belabox
#
# OBS MediaSource:
# srt://<ip>:5010/?streamid=play/stream/belabox
#
