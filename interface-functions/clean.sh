#!/bin/bash

clean_browser (){
    pkill -f "firefox" 2>/dev/null
    sleep 1
    if pgrep -f "firefox" > /dev/null; then
        echo "Forceful kill"
        pkill -9 "firefox" 2>/dev/null
    fi
}

