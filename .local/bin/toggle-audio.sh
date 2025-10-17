#!/bin/bash

# Audio sink names
headset="alsa_output.usb-Logitech_G533_Gaming_Headset-00.analog-stereo"
speakers="alsa_output.pci-0000_00_1f.3.analog-stereo"

# Get current default sink
current=$(pactl get-default-sink)

# Toggle between headset and speakers
if [ "$current" = "$headset" ]; then
    pactl set-default-sink "$speakers"
    new_sink="$speakers"
else
    pactl set-default-sink "$headset"
    new_sink="$headset"
fi

# Move active audio streams to the new sink
for input in $(pactl list short sink-inputs | cut -f1); do
    pactl move-sink-input "$input" "$new_sink"
done

# Optional desktop notification (requires notify-send)
notify-send "Audio Output Switched" "Now using: $new_sink"
