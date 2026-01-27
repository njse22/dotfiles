#!/bin/bash

option_1="󱣴  Capture Full Screen"
option_2="󰩭  Capture Area and Save"
option_3="󰩭  Capture Area to Clipboard"

if [ -z "$1" ]; then
  echo "$option_1"
  echo "$option_2"
  echo "$option_3"
else
  case "$1" in
  "$option_1")
    flameshot full -p /home/i2t/Pictures/Screenshots
    ;;
  "$option_2")
    flameshot gui -p /home/i2t/Pictures/Screenshots
    ;;
  "$option_3")
    flameshot gui -c
    ;;
  esac
fi
