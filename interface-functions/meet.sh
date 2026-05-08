#!/bin/bash

source /usr/local/etc/.env

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
    if pgrep -f "firefox" > /dev/null; then
        echo "Meet running"
        return 0
    fi
    clean_browser
    /usr/bin/firefox --kiosk "$MEET_URL" > /dev/null 2>&1 &
}
stop_meet () {
     if pgrep -f "firefox" > /dev/null; then
        pkill -f "firefox" 2>/dev/null
    fi
}

restart_meet() {
    clean_browser
    /usr/bin/firefox --kiosk "$MEET_URL" > /dev/null 2>&1 &
}