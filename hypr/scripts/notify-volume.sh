#!/bin/bash

raw=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
volume=$(echo "$raw" | awk '{print $2}')
muted=$(echo "$raw" | grep -q MUTED && echo "true" || echo "false")
percent=$(awk "BEGIN { printf(\"%.0f\", $volume * 100) }")

if [ "$muted" = "true" ]; then
    icon="/usr/share/icons/Papirus/22x22/panel/audio-volume-muted.svg"
elif [ "$percent" -lt 30 ]; then
    icon="/usr/share/icons/Papirus/22x22/panel/audio-volume-low.svg"
elif [ "$percent" -lt 70 ]; then
    icon="/usr/share/icons/Papirus/22x22/panel/audio-volume-medium.svg"
else
    icon="/usr/share/icons/Papirus/22x22/panel/audio-volume-high.svg"
fi

dunstify -a "Volume" -i "$icon" -r 91190 -u low "Lautstärke: ${percent}%"