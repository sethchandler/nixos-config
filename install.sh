#!/usr/bin/env bash

# Define paths
REPO_DIR="$HOME/nixos-config"
NIXOS_CONFIG_DIR="/etc/nixos"
USER_CONFIG_DIR="$HOME/.config"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Starting NixOS Configuration Setup...${NC}"

# --- System Configuration ---
echo -e "\n${BLUE}Step 1: Linking System Configuration${NC}"

# Create backup if file exists and is not already a symlink
if [ -f "$NIXOS_CONFIG_DIR/configuration.nix" ] && [ ! -L "$NIXOS_CONFIG_DIR/configuration.nix" ]; then
    echo "Backing up existing configuration.nix..."
    sudo mv "$NIXOS_CONFIG_DIR/configuration.nix" "$NIXOS_CONFIG_DIR/configuration.nix.bak-$(date +%s)"
fi

# Link the file
echo "Creating symlink for configuration.nix..."
sudo ln -sf "$REPO_DIR/configuration.nix" "$NIXOS_CONFIG_DIR/configuration.nix"
echo -e "${GREEN}System configuration linked.${NC}"


# --- User Dotfiles ---
echo -e "\n${BLUE}Step 2: Linking User Dotfiles${NC}"

# Ensure .config exists
mkdir -p "$USER_CONFIG_DIR"

# Function to link user config folders
link_config() {
    local TARGET=$1
    echo "Processing $TARGET..."
    
    # Remove existing dir or symlink if it exists
    if [ -d "$USER_CONFIG_DIR/$TARGET" ] || [ -L "$USER_CONFIG_DIR/$TARGET" ]; then
        rm -rf "$USER_CONFIG_DIR/$TARGET"
    fi

    ln -s "$REPO_DIR/$TARGET" "$USER_CONFIG_DIR/$TARGET"
    echo -e "${GREEN}Linked $TARGET.${NC}"
}

# Link Waybar and Hyprland
link_config "waybar"
link_config "hypr"


# --- Finalize ---
echo -e "\n${BLUE}Setup complete!${NC}"
echo "You can now run: sudo nixos-rebuild switch"

# Optional: Open in Micro
if command -v micro &> /dev/null; then
    echo
    read -p "Would you like to open configuration.nix in micro now? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        micro "$REPO_DIR/configuration.nix"
    fi
else
    echo "(Install 'micro' to edit files with better keybindings!)"
fi
