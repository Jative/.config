#!/bin/bash

state_file="$HOME/.config/hypr/.layout_state"
kbd="at-translated-set-2-keyboard"

if [[ -f "$state_file" ]]; then
    current=$(cat "$state_file")
else
    current="us"
fi

case "$current" in
  us)
    next="de"
    index=1
    icon="🇩🇪"
    ;;
  de)
    next="ru"
    index=2
    icon="🇷🇺"
    ;;
  ru)
    next="us"
    index=0
    icon="🇺🇸"
    ;;
esac

hyprctl switchxkblayout "$kbd" "$index"

echo "$next" > "$state_file"

dunstify -a "Layout" -r 91192 -u low "Tastatur: $icon ($next)"