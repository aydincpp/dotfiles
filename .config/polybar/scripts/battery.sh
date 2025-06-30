#!/bin/sh

bat="/sys/class/power_supply/BAT0/capacity"
ac="/sys/class/power_supply/AC0/online"

capacity=$(cat "$bat")
online=$(cat "$ac")

if [ "$online" -eq 1 ]; then
    icon=""
    echo "$icon  $capacity%"
else
    case $capacity in
        9[0-9]|100) icon="" ;;
        7[0-9]|8[0-9]) icon="" ;;
        5[0-9]|6[0-9]) icon="" ;;
        3[0-9]|4[0-9]) icon="" ;;
        *) icon="" ;;
    esac
    echo "$icon  $capacity%"
fi
