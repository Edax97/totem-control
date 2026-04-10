#!/bin/bash
# exposed by copyparty server w pass
source "/usr/local/etc/.env"

declare -i IMAGE_DELAY CONTENT_IS_ACTIVE TIME_SINCE=0 PLAYLIST_MODIFIED SETTINGS_MODIFIED SLIDES_STARTED=0

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
    killall mpv
  # slideshow
  else
    PLAYLIST_MODIFIED=$(stat --printf="%Y" "$PLAYLIST_DIR")
    SETTINGS_MODIFIED=$(stat --printf="%Y" "$SETTINGS_FILE")
    if [ $PLAYLIST_MODIFIED -lt $TIME_SINCE ] && [ $SETTINGS_MODIFIED -lt $TIME_SINCE ] && [ $SLIDES_STARTED -eq 1 ]; then
      continue
    fi
    SLIDES_STARTED=1
    TIME_SINCE=$(date +%s)

    ls "$PLAYLIST_DIR" > "$PLAYLIST_DIR/.list.m3u"
    echo "fs=yes
terminal=no
image-display-duration=$IMAGE_DELAY" > "$HOME/.config/mpv/mpv.conf"

    #echo '{ "command": ["loadfile", ".list.m3u"] }' | socat - /tmp/mpvsocket

    killall mpv
    mpv --loop-playlist --playlist="$PLAYLIST_DIR/.list.m3u" &

  fi
done
