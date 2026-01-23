#!/bin/bash

source "/usr/local/etc/.env"

HALL_URL="http://127.0.0.1:6060"

clean_browser_ (){
    pkill -f "firefox" 2>/dev/null
    sleep 1
    if pgrep -f "firefox" > /dev/null; then
      echo "Forceful kill"
      pkill -9 "firefox" 2>/dev/null
    fi
    sleep 1
}

start_hall() {
    systemctl --user start feed.service
#    systemctl --user start voice.service
    if pgrep -f "firefox.*$HALL_URL" > /dev/null; then
        echo "Hall running"
        return 0
    fi
    clean_browser_
    /usr/bin/firefox --kiosk "$HALL_URL" > /dev/null 2>&1 &
}

stop_hall () {
    systemctl --user stop feed.service
#    systemctl --user stop voice.service

    if pgrep -f "firefox.*$HALL_URL" > /dev/null; then
        pkill -f "firefox.*$HALL_URL" 2>/dev/null
    fi
}


