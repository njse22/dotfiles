#!/usr/bin/env bash

# Options
shutdown=' Shutdown'
reboot='  Reboot'
lock=' Lock'
logout='󰗽  Logout'

# Logic
if [ -z "$1" ]; then
  # No argument: Print options
  echo "$lock"
  echo "$logout"
  echo "$reboot"
  echo "$shutdown"
else
  # Argument present: Execute action
  case "$1" in
  "$shutdown")
    systemctl poweroff
    ;;
  "$reboot")
    systemctl reboot
    ;;
  "$logout")
    gnome-session-quit --no-prompt
    ;;
  "$lock")
    xdg-screensaver lock
    ;;
  esac
fi
