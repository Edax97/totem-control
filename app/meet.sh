#!/bin/bash

FIREFOX_PROCESS_NAME=firefox
MEETING_URL="https://c4d-totem.tail969bfa.ts.net/vigilancia"

start_meet () {
    if pgrep -f "$FIREFOX_PROCESS_NAME" > /dev/null; then
        echo "Firefox running"
        return 1
    fi
    /usr/bin/firefox --kiosk "$MEETING_URL" > /dev/null 2>&1 &
}

stop_meet () {
    # stop any firefox process
    pkill -f "$FIREFOX_PROCESS_NAME" 2>/dev/null
    sleep 1
    if pgrep -f "$FIREFOX_PROCESS_NAME" > /dev/null; then
        echo "Forceful kill"
        pkill -9 "$FIREFOX_PROCESS_NAME" 2>/dev/null
        return 1
    fi

}
