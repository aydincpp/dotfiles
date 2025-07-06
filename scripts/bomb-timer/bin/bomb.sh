#!/usr/bin/env bash

total=1800
id=9999
icon="$HOME/.local/share/bomb-timer/bomb_icon.png"
bomb_start="$HOME/.local/share/bomb-timer/bomb_start.mp3"
bomb_finish="$HOME/.local/share/bomb-timer/bomb_finish.mp3"
pid_file="/tmp/bomb.pid"

# --- Stop command ---
if [[ "$1" == "--stop" ]]; then
    if [[ -f "$pid_file" ]]; then
        kill "$(cat "$pid_file")" 2>/dev/null && echo "Bomb timer stopped."
        rm -f "$pid_file"
    else
        echo "No bomb timer is running."
    fi
    exit 0
fi

# --- Parse arguments ---
while [[ $# -gt 0 ]]; do
    case "$1" in
        --time)
            shift
            time_val=$1
            shift
            case "$time_val" in
                *s) total=${time_val%s} ;;                  # Seconds
                *m) total=$(( ${time_val%m} * 60 )) ;;      # Minutes
                *h) total=$(( ${time_val%h} * 3600 )) ;;    # Hours
                *) total=$(( time_val )) ;;                 # Fallback: Seconds
            esac
            ;;
        *) echo "Unknown option: $1" ; exit 1 ;;
    esac
done

# --- Save PID ---
echo $$ > "$pid_file"

# --- Play start sound ---
pw-play "$bomb_start" &

# --- Countdown loop ---
for ((t=total; t>=0; t--)); do
    mins=$((t / 60))
    secs=$((t % 60))
    dunstify -r "$id" -I "$icon" "💣 Bomb Countdown" "$(printf "%02d:%02d remaining" "$mins" "$secs")"
    sleep 1
done

# --- Final sound and notification ---
pw-play "$bomb_finish" &
dunstify -r "$id" -u critical -I "$icon" "💥 BOOM!" "Time's up!"
