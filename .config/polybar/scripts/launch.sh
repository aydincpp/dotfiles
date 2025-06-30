#!/usr/bin/env bash

# terminate already running bar instances
# if all your bars have ipc enabled, you can use 
# polybar-msg cmd quit
# otherwise you can use the nuclear option:
killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.1; done

# Launch Polybar on all connected monitors
if type "xrandr" >/dev/null; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload example &
  done
else
  polybar --reload example &
fi

echo "Polybar launched on all connected monitors."
