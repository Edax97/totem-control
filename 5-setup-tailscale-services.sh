#!/bin/bash

source /usr/local/etc/.env
sudo tailscale serve --bg --set-path /copyparty http://127.0.0.1:3923/copyparty
# raspberrypi-1.tail3c3868.ts.net/copyparty 
sudo tailscale serve --bg --https 8888 http://127.0.0.1:9999
# raspberrypi-1.tail3c3868.ts.net:8888
sudo tailscale serve --bg --https 8444 http://localhost:3000
# raspberrypi-1.tail3c3868.ts.net:8444
# room: vigilancia