#!/bin/bash

source /usr/local/etc/.env
sudo tailscale serve --bg --set-path /copyparty http://127.0.0.1:3923/copyparty
#raspberrypi-1.tail3c3868.ts.net/copyparty 
sudo tailscale serve --bg --https 8888 http://127.0.0.1:9999/cam
# raspberrypi-1.tail3c3868.ts.net:8888


# room: vigilancia