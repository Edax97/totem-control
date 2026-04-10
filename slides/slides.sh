#!/bin/bash

source "/usr/local/etc/.env"
mkdir -p "$PLAYLIST_DIR"
cd "$PLAYLIST_DIR" || exit 1
mpv --loop-playlist --input-ipc-server=/tmp/mpvsocket --use-filedir-conf --idle
