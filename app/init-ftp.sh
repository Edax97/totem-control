#!/bin/bash

source "$HOME/.env"
/usr/bin/python "$SRC_DIR/ftp/copyparty-sfx.py" -v "$CONTENT_DIR:/content:r:rwd,adm" -a adm:labotec --allow-csrf --ftp=3921 --rproxy=1 
