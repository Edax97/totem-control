#!/bin/bash

source /usr/local/etc/.env
MEET_URL="https://c4d-totem.tail969bfa.ts.net/vigilancia"

clean_browser (){
    pkill -f "firefox" 2>/dev/null
    sleep 1
    if pgrep -f "firefox" > /dev/null; then
        echo "Forceful kill"
        pkill -9 "firefox" 2>/dev/null
    fi
    sleep 1
}

start_meet () {
    if pgrep -f "firefox.*$MEET_URL" > /dev/null; then
        echo "Meet running"
        return 0
    fi
    clean_browser
    /usr/bin/firefox --kiosk "$MEET_URL" > /dev/null 2>&1 &
}
stop_meet () {
     if pgrep -f "firefox.*$MEET_URL" > /dev/null; then
        pkill -f "firefox.*$MEET_URL" 2>/dev/null
    fi
}
