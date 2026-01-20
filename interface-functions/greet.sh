#!/bin/bash

source "/usr/local/etc/.env"
export TOTEM_TIME
start_hall () {
    systemctl --user start feed.service
    if pgrep -f "voice" > /dev/null; then
        echo "Voice-cmd running"
        return 1
    fi
    $HOME/.pyenv/bin/python "$SRC_DIR/voice-cmd/voice-cmd.py" -m es -d 0
}

stop_hall () {
    systemctl --user stop feed.service

    pkill -f "voice" 2>/dev/null
    sleep 1
    if pgrep -f "voice" > /dev/null; then
        echo "Forceful kill"
        pkill -9 "voice" 2>/dev/null
    fi

}
