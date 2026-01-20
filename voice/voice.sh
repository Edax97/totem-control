#!/bin/bash

source /usr/local/etc/.env
export TOTEM_TIME
$HOME/.pyenv/bin/python /usr/local/bin/voice.py -m es -d 0

