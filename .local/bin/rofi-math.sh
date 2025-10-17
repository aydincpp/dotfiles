#!/usr/bin/env bash

# Pick a symbol and copy it to clipboard
choice=$(cat ~/.local/share/rofi/math-symbols.txt | rofi -dmenu -p "Math Symbol" | awk '{print $1}')

# If user picked something
[ -n "$choice" ] && echo -n "$choice" | xclip -selection clipboard
