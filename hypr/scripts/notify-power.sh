#!/bin/bash

status=$(cat /sys/class/power_supply/AC/online)

if [[ "$status" -eq 1 ]]; then
    icon="/usr/share/icons/Papirus/22x22/symbolic/status/battery-ac-adapter-symbolic.svg"
    msg="Am Stromnetz"
else
    icon="/usr/share/icons/Papirus/22x22/symbolic/status/battery-level-100-symbolic.svg"
    msg="Akku-Modus"
fi

dunstify -a "Power" -i "$icon" -r 91192 -u normal "$msg"