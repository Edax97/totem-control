#!/bin/bash
# exposed by ftp server w pass
source .env

declare -i IMAGE_DELAY CONTENT_IS_ACTIVE TIME_SINCE=0 PLAYLIST_MODIFIED SETTINGS_MODIFIED

mkdir -p "$PLAYLIST_DIR"
#mpv --loop-playlist --input-ipc-server=/tmp/mpv --use-filedir-conf --idle &

for ((;;)); do
  PLAYLIST_MODIFIED=$(stat --printf="%Y" "$PLAYLIST_DIR")
  SETTINGS_MODIFIED=$(stat --printf="%Y" "$SETTINGS_FILE")
  if [ $PLAYLIST_MODIFIED -lt $TIME_SINCE ] && [ $SETTINGS_MODIFIED -lt $TIME_SINCE ]; then
    sleep 10
    continue
  fi

  TIME_SINCE=$(date +%s)

  IMAGE_DELAY=$( yq '.image_delay' "$SETTINGS_FILE" )
  CONTENT_IS_ACTIVE=$( yq '.content_is_active' "$SETTINGS_FILE")
  echo "$IMAGE_DELAY $CONTENT_IS_ACTIVE"

  if [ $CONTENT_IS_ACTIVE -eq 0 ]; then
    echo '{ "command": ["stop"] }' | socat - /tmp/mpvsocket
    continue
  fi
  
  ls "$PLAYLIST_DIR" > "$PLAYLIST_DIR/.list.m3u"
  echo "fs=yes
terminal=no
image-display-duration=$IMAGE_DELAY" > "$PLAYLIST_DIR/.mpv.config"
        
  echo '{ "command": ["loadfile", ".list.m3u"] }' | socat - /tmp/mpvsocket
  echo '{ "command": ["load-config-file", ".mpv.config"] }' | socat - /tmp/mpvsocket
  sleep 15
done

