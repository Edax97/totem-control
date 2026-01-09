#!/bin/bash

source "$HOME/.env"

MEDIAMTX_NAME=mediamtx
GREETING_NAME=greeting.py

start_greet(){
    if pgrep -f "$MEDIAMTX_NAME" > /dev/null; then
        echo "Greeting running"
        return 1
    fi
    /usr/bin/python "$APP_DIR/greeting.py" &
    $SRC_DIR/feed/mediamtx "$SRC_DIR/feed/mediamtx" &
}

stop_greet(){
    pkill -f "$MEDIAMTX_NAME" 2>/dev/null
    pkill -f "$GREETING_NAME" 2>/dev/null
    sleep 2
    if pgrep -f "$MEDIAMTX_NAME" > /dev/null; then
        echo "Forceful kill"
        pkill -9 "$MEDIAMTX_NAME" 2>/dev/null
        pkill -9 "$GREETING_NAME" 2>/dev/null
        return 1
    fi

}
