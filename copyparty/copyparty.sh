#!/bin/bash

source /usr/local/etc/.env
/usr/bin/python /usr/local/bin/copyparty-sfx.py -v "$CONTENT_DIR:/content:r:rwd,adm" -a adm:labotec --rproxy=1 --rp-loc /copyparty --xff-src=100.0.0.0/8,127.0.0.1 --acao https://telepresencia-manager-ui.vercel.app/ --acam "*"
