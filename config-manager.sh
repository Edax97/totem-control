#!/bin/bash
# exposed by ftp server w pass
source .env
# TOTEM-PING PANEL-PING

declare -i IMAGE_DELAY CONTENT_IS_ACTIVE TIME_SINCE=0 PLAYLIST_MODIFIED SETTINGS_MODIFIED PANEL_PING

mkdir -p "$PLAYLIST_DIR"
# Requires: ftp.service slideshow.service 
# greet.service
# meet.service

for ((;;)); do

  sleep 10
  IMAGE_DELAY=$( yq '.image_delay' "$SETTINGS_FILE" )
  CONTENT_IS_ACTIVE=$( yq '.content_is_active' "$SETTINGS_FILE")

  # videocall
  if [ $CONTENT_IS_ACTIVE -eq 0 ]; then
    echo '{ "command": ["stop"] }' | socat - /tmp/mpvsocket
    PANEL_PING=$(stat --printf="%Y" "$PANEL_PING_FILE")
    NOW=$(date +%s)
    if [ $(( PANEL_PING + 30 )) -lt $NOW ]; then
      sudo systemctl start greet.service
      sudo systemctl stop meet.service
    else
      sudo systemctl start meet.service
      sudo systemctl stop greet.service
    fi;
  # slideshow
  else
    
    PLAYLIST_MODIFIED=$(stat --printf="%Y" "$PLAYLIST_DIR")
    SETTINGS_MODIFIED=$(stat --printf="%Y" "$SETTINGS_FILE")
    if [ $PLAYLIST_MODIFIED -lt $TIME_SINCE ] && [ $SETTINGS_MODIFIED -lt $TIME_SINCE ]; then
      continue
    fi
    TIME_SINCE=$(date +%s)


    ls "$PLAYLIST_DIR" > "$FTP_DIR/.list.m3u"
    echo "fs=yes
terminal=no
image-display-duration=$IMAGE_DELAY" > "$FTP_DIR/.mpv.config"
        
    echo '{ "command": ["loadfile", ".list.m3u"] }' | socat - /tmp/mpvsocket
    echo '{ "command": ["load-config-file", ".mpv.config"] }' | socat - /tmp/mpvsocket
    
  fi
  
done

