#!/bin/bash

source "$1"
cd "$PLAYLIST_DIR" || exit 1
mpv --loop-playlist --input-ipc-server=/tmp/mpvsocket --use-filedir-conf --idle
