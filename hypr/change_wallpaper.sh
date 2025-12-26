#!/usr/bin/env bash

# Path to your wallpaper directory
WALLPAPER_DIR="$HOME/.config/hypr/Wallpapers"

# Pick a random file from the directory
RANDOM_WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

# Preload the new wallpaper (hyprpaper requires preloading before displaying)
hyprctl hyprpaper preload "$RANDOM_WALLPAPER"

# Set the wallpaper for all monitors
# We use 'unload all' first to keep memory usage low
hyprctl hyprpaper wallpaper ",$RANDOM_WALLPAPER"

# Clean up: unload other wallpapers to save RAM
hyprctl hyprpaper unload all
