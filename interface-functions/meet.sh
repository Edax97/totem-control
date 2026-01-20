#!/bin/bash

#source /usr/local/etc/.env
MEETING_URL="https://c4d-totem.tail969bfa.ts.net/vigilancia"
MEET_ID="$HOME/.meet_id"

start_meet () {
    PID=$(cat "$MEET_ID" 2>/dev/null)
    if kill -0 "$PID" > /dev/null 2>&1; then
        echo "Firefox running"
        return 1
    fi
    /usr/bin/firefox --kiosk "$MEETING_URL" > /dev/null 2>&1 &
    echo "$!" > "$MEET_ID"
}

stop_meet () {
    # stop any firefox process
    PID=$(cat "$MEET_ID" 2>/dev/null)
    kill "$PID" 2>/dev/null
    sleep 1
    if kill -0 "$PID" > /dev/null 2>&1; then
        echo "Forceful kill"
        kill -9 "$PID" 2>/dev/null
        return 1
    fi
}
