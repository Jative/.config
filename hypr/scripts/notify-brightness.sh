#!/bin/bash

brightness=$(brightnessctl get)
max_brightness=$(brightnessctl max)
percent=$((brightness * 100 / max_brightness))

if [ "$percent" -lt 30 ]; then
    icon="/usr/share/icons/Papirus/22x22/symbolic/status/display-brightness-low-symbolic.svg"
elif [ "$percent" -lt 70 ]; then
    icon="/usr/share/icons/Papirus/22x22/symbolic/status/display-brightness-medium-symbolic.svg"
else
    icon="/usr/share/icons/Papirus/22x22/symbolic/status/display-brightness-high-symbolic.svg"
fi

dunstify -a "Brightness" -i "$icon" -r 91191 -u low "Helligkeit: ${percent}%"