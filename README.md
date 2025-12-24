# NixOS Configuration

This repository contains my personal configuration files for NixOS. It focuses on a Hyprland desktop environment workflow with a customized Waybar status bar.

It is designed to be cloned into a user directory (e.g., `~/nixos-config`), with system files and dotfiles symlinked to their appropriate locations.

## Key Features

### Stable Hardware Monitoring (No More "Hwmon Roulette")
A primary feature of the Waybar configuration is a robust solution for the Linux hardware sensor index shifting issue (where `hwmon4` becomes `hwmon5` after a reboot).

Instead of relying on unstable indices, this configuration utilizes the `hwmon-path-abs` property in Waybar. It points directly to the persistent physical device path (e.g., `/sys/devices/platform/coretemp.0/hwmon`), ensuring temperature readings remain accurate regardless of kernel enumeration order.

### Software Stack
* **OS:** NixOS
* **Window Manager:** Hyprland
* **Status Bar:** Waybar (Custom JSON config with stable sensors)
* **Editor:** Micro / VSCodium
* **Shell:** Zsh / Bash

## Repository Structure
* `configuration.nix`: The declarative system definition.
* `waybar/`: Contains `config` (JSON) and `style.css`.
* `hypr/`: Contains `hyprland.conf` and associated scripts.
* `install.sh`: A helper script to automate the symlinking process.

## Installation & Bootstrapping

### 1. Clone Repository
Clone this repository to your home directory.

```bash
cd ~
git clone [https://github.com/sethchandler/nixos-config.git](https://github.com/sethchandler/nixos-config.git)
```

### 2. Run the Installer (Recommended)
This repository includes a script to automatically back up your old config and symlink the new files.

```bash
cd ~/nixos-config
chmod +x install.sh
./install.sh
```

*Note: The script attempts to detect if `micro` is installed and offers to open the configuration for immediate editing.*

### 3. Manual Installation (Alternative)
If you prefer to link files manually:

**System Config:**
```bash
sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.bak
sudo ln -sf ~/nixos-config/configuration.nix /etc/nixos/configuration.nix
```

**User Dotfiles:**
```bash
mkdir -p ~/.config
rm -rf ~/.config/waybar ~/.config/hypr
ln -sf ~/nixos-config/waybar ~/.config/waybar
ln -sf ~/nixos-config/hypr ~/.config/hypr
```

### 4. Apply Changes
Once the links are established, rebuild the system.

```bash
sudo nixos-rebuild switch
```
