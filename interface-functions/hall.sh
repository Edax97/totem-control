#!/bin/bash

source "/usr/local/etc/.env"

HALL_URL="http://127.0.0.1:6060"
HALL_ID="$HOME/.hall_id"

clean_browser_ (){
    pkill -f "firefox" 2>/dev/null
    sleep 0.4
    if pgrep -f "firefox" > /dev/null; then
      echo "Forceful kill"
      pkill -9 "firefox" 2>/dev/null
    fi
}

start_hall() {
    systemctl --user start feed.service
#    systemctl --user start voice.service
    PID=$(cat "$HALL_ID" 2>/dev/null)
    if kill -0 "$PID" > /dev/null 2>&1; then
        echo "Hall running"
        return 1
    fi

    clean_browser_
    /usr/bin/firefox --kiosk "$HALL_URL" > /dev/null 2>&1 &
    echo "$!" > "$HALL_ID"
}

stop_hall () {
    systemctl --user stop feed.service
#    systemctl --user stop voice.service

    PID=$(cat "$HALL_ID" 2>/dev/null)
    kill "$PID" 2>/dev/null
    sleep 0.2

    if kill -0 "$PID" > /dev/null 2>&1; then
        echo "Forceful kill"
        kill -9 "$PID" 2>/dev/null
        return 1
    fi
}


