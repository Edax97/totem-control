#!/bin/bash
#
mkdir -p "$HOME/.config/autostart"

sudo cp .env /usr/local/etc/
cp .settings.yaml "$HOME/Pictures/"

# config-manager
sudo cp config-manager/config-manager.sh /usr/local/bin/
cp config-manager/config-manager.desktop "$HOME/.config/autostart/"

# slides
sudo cp slides/slides.sh /usr/local/bin/
cp slides/slides.desktop "$HOME/.config/autostart/"

# feed
sudo cp feed/mediamtx /usr/local/bin/
sudo cp feed/mediamtx.yml /usr/local/etc/
sudo cp feed/feed.service "$HOME/.config/systemd/user/"
# voice
sudo cp voice/voice.py voice/voice.sh /usr/local/bin/
sudo cp voice/voice.service "$HOME/.config/systemd/user/"
# hall ui
sudo cp interface-functions/hall.sh /usr/local/bin/
# hall
sudo cp -r hall/hall-html "/var/www/"

# meet-ui
sudo cp interface-functions/meet.sh /usr/local/bin/

# copyparty
sudo cp copyparty/copyparty-sfx.py copyparty/copyparty.sh /usr/local/bin/
sudo cp copyparty/copyparty.service /etc/systemd/system/

sudo chmod +x /usr/local/bin/*.sh /usr/local/bin/*.py /usr/local/bin/mediamtx

# reload systemctl
sudo systemctl daemon-reload
sudo systemctl enable --now copyparty.service
systemctl --user daemon-reload

