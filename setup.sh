#!/bin/bash
#
#
mkdir -p "$HOME/.local/bin" "$HOME/.local/etc" "$HOME/.config/autostart"
sudo chmod 744 *.sh

cp *.sh "$HOME/.local/bin/"
cp .env "$HOME/.local/etc/"

cp slides.desktop "$HOME/.config/autostart/"
sed -i "s|HOME|$HOME|g" "$HOME/.config/autostart/slides.desktop"
