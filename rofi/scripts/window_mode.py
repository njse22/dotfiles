#!/usr/bin/env python3
import json
import sys
import os

# Try to import pydbus
try:
    from pydbus import SessionBus
except ImportError:
    # If pydbus is missing, we can't really do anything. 
    # In a real scenario, we might print an error item.
    sys.exit(1)

def get_windows():
    bus = SessionBus()
    try:
        # Connect to the "Window Calls" extension
        proxy = bus.get("org.gnome.Shell", "/org/gnome/Shell/Extensions/Windows")
        # Get the list of windows
        windows_json = proxy.List()
        return json.loads(windows_json), proxy
    except Exception:
        return [], None

def main():
    # Check if an argument is passed (Rofi passes the selected string as an argument)
    if len(sys.argv) > 1:
        selection = sys.argv[1]
        windows, proxy = get_windows()
        if not windows or not proxy:
            return

        # Find the window ID matching the selection string
        for win in windows:
            display_str = f"[{win['wm_class']}] {win['title']}"
            if display_str == selection:
                proxy.Activate(win['id'])
                break
    else:
        windows, _ = get_windows()
        if windows:
            for win in windows:
                ## win keys : ['in_current_workspace', 'workspace', 'wm_class', 'wm_class_instance', 'title', 'pid', 'id', 'frame_type', 'window_type', 'focus']
                print(f"[{win['wm_class']}] {win['title']}")
        else:
            pass

if __name__ == "__main__":
    main()
