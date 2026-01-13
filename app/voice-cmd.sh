#!/bin/bash

source "$HOME/.env"
export TOTEM_TIME
$HOME/.pyenv/bin/python "$SRC_DIR/voice-cmd/voice-cmd.py" -m es -d 0

