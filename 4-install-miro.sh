#!/bin/bash
# 
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs npm

cd /opt || exit
sudo git clone https://github.com/miroslavpejic85/mirotalk.git
sudo chown -R $USER:$USER /opt/mirotalk
cd mirotalk || exit
cp .env.template .env
cp app/src/config.template.js app/src/config.js
npm ci

sudo npm i -g pm2
pm2 start app/src/server.js --name mirotalkp2p
pm2 save
pm2 startup
