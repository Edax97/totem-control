#!/bin/bash
#
mkdir -p "$HOME/.config/autostart"

sudo cp .env.slides /usr/local/etc/.env
sudo cp .settings.yaml "$HOME/Pictures/"

# slides-manager
sudo cp slides-manager/slides-manager.sh /usr/local/bin/
cp slides-manager/slides-manager.desktop "$HOME/.config/autostart/"

# slides
sudo cp slides/slides.sh /usr/local/bin/
cp slides/slides.desktop "$HOME/.config/autostart/"

# copyparty
sudo cp copyparty/copyparty-sfx.py copyparty/copyparty.sh /usr/local/bin/
sudo cp copyparty/copyparty.service /etc/systemd/system/

sudo chmod +x /usr/local/bin/*.sh /usr/local/bin/*.py

# reload systemctl
sudo systemctl daemon-reload
sudo systemctl enable copyparty.service
sudo systemctl restart copyparty.service

