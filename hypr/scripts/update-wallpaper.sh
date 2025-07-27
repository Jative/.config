#!/bin/bash

WALLPAPER=$(cat ~/.config/hypr/wallpaper_path.conf)

cat > ~/.config/hypr/hyprpaper.conf <<EOF
preload = $WALLPAPER
wallpaper = eDP-1,$WALLPAPER
EOF

sed -i -z "s|background\s*{[^}]*}|background {\n    monitor = eDP-1\n    path = $WALLPAPER\n    color = rgba(313244aa)\n    blur_size = 8\n    blur_passes = 2\n    contrast = 1\n    brightness = 0.5\n    vibrancy = 0.25\n    vibrancy_darkness = 0.25\n    noise = 0.01\n}|" ~/.config/hypr/hyprlock.conf