#!/bin/bash
#
mkdir -p "$HOME/.config/autostart"

sudo cp .env.prod /usr/local/etc/.env
sudo cp .settings.yaml "$HOME/Pictures/"

# copyparty
sudo cp copyparty/copyparty-sfx.py copyparty/copyparty.sh /usr/local/bin/
sudo cp copyparty/copyparty.service /etc/systemd/system/

# config-manager
sudo cp config-manager/config-manager.sh /usr/local/bin/
cp config-manager/config-manager.desktop "$HOME/.config/autostart/"

# modo presentacion
# -----------------
# slides
sudo cp slides/slides.sh /usr/local/bin/

# modo videoportero
# -----------------
# hall web
sudo cp -r hall/hall-html "/var/www/html"
suco cp hall/hall-site "/etc/nginx/sites-enabled/"

# open hall web
sudo cp interface-functions/hall.sh /usr/local/bin/

# camera feed
sudo cp feed/mediamtx /usr/local/bin/
sudo cp feed/mediamtx.yml /usr/local/etc/
sudo cp feed/feed.service "$HOME/.config/systemd/user/"
# voice recognition
sudo cp voice/voice.py voice/voice.sh /usr/local/bin/
sudo cp voice/voice.service "$HOME/.config/systemd/user/"
# meet web
sudo cp interface-functions/meet.sh /usr/local/bin/

sudo chmod +x /usr/local/bin/*.sh /usr/local/bin/*.py /usr/local/bin/mediamtx
# reload systemctl
sudo systemctl daemon-reload
sudo systemctl enable copyparty.service
sudo systemctl restart copyparty.service
sudo nginx -t && sudo systemctl reload nginx
systemctl --user daemon-reload

