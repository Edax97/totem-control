#!/bin/bash
#
APP_DIR="$HOME/app"
mkdir -p "$APP_DIR" "$HOME/.config/autostart"

sudo chmod 744 app/*.sh

cp ./app/*.sh "$APP_DIR/"
cp .env "$HOME/.env"
cp .settings.yaml "$HOME/Pictures/"

cp app/slides.desktop app/init-ftp.desktop app/config-manager.desktop "$HOME/.config/autostart/"
sed -i "s|APP|$APP_DIR|g" "$HOME/.config/autostart/slides.desktop"
sed -i "s|APP|$APP_DIR|g" "$HOME/.config/autostart/init-ftp.desktop"
sed -i "s|APP|$APP_DIR|g" "$HOME/.config/autostart/config-manager.desktop"
