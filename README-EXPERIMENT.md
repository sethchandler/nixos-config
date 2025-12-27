# Broadcom Configuration Refactor Walkthrough

I have successfully refactored the Broadcom-specific settings into a modular file to make your configuration more portable for your new PC.

## Changes Made

### 1. Created `broadcom.nix`
I moved all hardware-specific Broadcom settings to [broadcom.nix](file:///home/seth/nixos-config/broadcom.nix). This includes the proprietary driver and blacklists.

### 2. Created `cinnamon-configuration.nix`
I modularized the Cinnamon desktop environment into [cinnamon-configuration.nix](file:///home/seth/nixos-config/cinnamon-configuration.nix).

### 3. Updated `flake.nix`
I added a new output to [flake.nix](file:///home/seth/nixos-config/flake.nix) called **`Rose-Experimental`**. This configuration imports KDE, COSMIC, and Cinnamon.

---

## 🛡️ The "Undo Plan"

If you decide the Cinnamon experiment isn't for you, or if something goes wrong, here is precisely how to undo it:

### Phase 1: Immediate Safety (The "Emergency Brake")
If the system becomes unstable or won't boot to a desktop:
1.  **Reboot** your computer.
2.  In the boot menu (systemd-boot), select a **previous generation** (the one before your most recent switch).
3.  You will be back in your stable `Rose` or `Rose-Cosmic` environment instantly.

### Phase 2: Rolling Back the Switch
If you are logged in but just want to go back to your stable version:
- Run: `sudo nixos-rebuild switch --flake .#Rose` (to go back to standard KDE)
- Or: `sudo nixos-rebuild switch --flake .#Rose-Cosmic` (to go back to KDE + COSMIC)

### Phase 3: Permanent Cleanup
If you want to remove all traces of Cinnamon:
1.  **Delete** the file [cinnamon-configuration.nix](file:///home/seth/nixos-config/cinnamon-configuration.nix).
2.  **Remove** the `Rose-Experimental` block from [flake.nix](file:///home/seth/nixos-config/flake.nix).
3.  **Clean up disk space** by running: `sudo nix-collect-garbage -d`. This will remove all the Cinnamon binaries that are no longer referenced by any of your current configurations.
