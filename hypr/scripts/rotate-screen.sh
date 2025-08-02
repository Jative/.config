#!/bin/bash

MONITOR="eDP-1"

CURRENT_TRANSFORM=$(hyprctl monitors | grep 'transform' | awk '{print $2}' | head -n 1)

if [ "$CURRENT_TRANSFORM" -eq 0 ]; then
    NEXT_TRANSFORM=2
else
    NEXT_TRANSFORM=0
fi

hyprctl keyword monitor "$MONITOR, transform, $NEXT_TRANSFORM"

hyprctl keyword input:touchdevice:transform $NEXT_TRANSFORM