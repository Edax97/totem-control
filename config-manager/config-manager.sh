#!/bin/bash
# exposed by copyparty server w pass
source "/usr/local/etc/.env"
source "/usr/local/bin/meet.sh"
source "/usr/local/bin/hall.sh"
# TOTEM-PING PANEL-PING

declare -i IMAGE_DELAY CONTENT_IS_ACTIVE TIME_SINCE=0 PLAYLIST_MODIFIED SETTINGS_MODIFIED PANEL_PING TOTEM_PING

mkdir -p "$PLAYLIST_DIR"
# Requires: copyparty.service slideshow.service
# greet.service
# interface-functions.service

for ((;;)); do

  sleep 3
  IMAGE_DELAY=$( yq '.image_delay' "$SETTINGS_FILE" )
  CONTENT_IS_ACTIVE=$( yq '.content_is_active' "$SETTINGS_FILE")

  # videocall
  if [ $CONTENT_IS_ACTIVE -eq 0 ]; then
    echo '{ "command": ["stop"] }' | socat - /tmp/mpvsocket
    TOTEM_PING=$(stat --printf="%Y" "$TOTEM_TIME")
    PANEL_PING=$(stat --printf="%Y" "$CONNECT_TIME")
    NOW=$(date +%s)
    if (( PANEL_PING + 10 < NOW )) && (( TOTEM_PING + 50 < NOW )); then
    # Hall
      stop_meet
      sleep 0.2
      start_hall
    else
    # meet
      stop_hall
      sleep 0.2
      start_meet
    fi;
  # slideshow
  else
    stop_meet
    stop_hall
    clean_browser

    PLAYLIST_MODIFIED=$(stat --printf="%Y" "$PLAYLIST_DIR")
    SETTINGS_MODIFIED=$(stat --printf="%Y" "$SETTINGS_FILE")
    if [ $PLAYLIST_MODIFIED -lt $TIME_SINCE ] && [ $SETTINGS_MODIFIED -lt $TIME_SINCE ]; then
      continue
    fi
    TIME_SINCE=$(date +%s)

    ls "$PLAYLIST_DIR" > "$PLAYLIST_DIR/.list.m3u"
    echo "fs=yes
terminal=no
image-display-duration=$IMAGE_DELAY" > "$PLAYLIST_DIR/.mpv.config"

    echo '{ "command": ["loadfile", ".list.m3u"] }' | socat - /tmp/mpvsocket
    echo '{ "command": ["load-config-file", ".mpv.config"] }' | socat - /tmp/mpvsocket

  fi

done
