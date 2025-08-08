#!/bin/bash

last_power=""
last_tlp=""

while true; do
  sleep 5

  power_state=$(< /sys/class/power_supply/AC/online)
  if [[ "$power_state" != "$last_power" ]]; then
    ~/.config/hypr/scripts/notify-power.sh "$power_state"
    last_power="$power_state"
  fi

  tlp_mode=$(tlp-stat -s | grep "Mode" | awk '{print $3}')
  if [[ "$tlp_mode" != "$last_tlp" ]]; then
    ~/.config/hypr/scripts/power-toggle.sh
    last_tlp="$tlp_mode"
  fi
done