#!/bin/bash

current_mode=$(tlp-stat -s | grep "Mode" | awk '{print $3}')
gtk3_file="$HOME/.config/gtk-3.0/settings.ini"
gtk4_file="$HOME/.config/gtk-4.0/settings.ini"
qt_file="$HOME/.config/qt5ct/qt5ct.conf"

if [[ "$current_mode" == "AC" ]]; then
  cp ~/.config/hypr/hyprland.leistung.conf ~/.config/hypr/hyprland.conf

  sed -i 's/^gtk-enable-animations=.*/gtk-enable-animations=true/' "$gtk3_file" 2>/dev/null || true
  sed -i 's/^gtk-enable-animations=.*/gtk-enable-animations=true/' "$gtk4_file" 2>/dev/null || true
  sed -i 's/^animations_enabled=.*/animations_enabled=true/' "$qt_file" 2>/dev/null || true

  sudo iw dev wlan0 set power_save off
  pkill hyprpaper
  hyprpaper &
  brightnessctl set 100%
  ~/.config/hypr/scripts/notify-brightness.sh

else
  cp ~/.config/hypr/hyprland.eco.conf ~/.config/hypr/hyprland.conf

  sed -i 's/^gtk-enable-animations=.*/gtk-enable-animations=false/' "$gtk3_file" 2>/dev/null || true
  sed -i 's/^gtk-enable-animations=.*/gtk-enable-animations=false/' "$gtk4_file" 2>/dev/null || true
  sed -i 's/^animations_enabled=.*/animations_enabled=false/' "$qt_file" 2>/dev/null || true

  sudo iw dev wlan0 set power_save on
  pkill hyprpaper
  brightnessctl set 30%
  ~/.config/hypr/scripts/notify-brightness.sh
fi
