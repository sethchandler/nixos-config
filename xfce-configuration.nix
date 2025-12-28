{ pkgs, ... }:

{
  # Enable XFCE Desktop Environment
  services.xserver.desktopManager.xfce.enable = true;
  
  # Add useful XFCE plugins and tools
  environment.systemPackages = with pkgs; [
    # Panel plugins
    xfce.xfce4-whiskermenu-plugin  # Modern application menu
    xfce.xfce4-pulseaudio-plugin   # Volume control in panel
    xfce.xfce4-clipman-plugin      # Clipboard manager
    xfce.xfce4-screenshooter       # Screenshot tool
    xfce.xfce4-taskmanager         # Task manager
    xfce.xfce4-systemload-plugin   # CPU/RAM/Network monitor in panel
    
    # Power & system management
    xfce.xfce4-power-manager       # Battery/power settings
    xfce.xfce4-notifyd             # Notification daemon
    
    # File manager enhancements
    xfce.thunar-archive-plugin     # Archive support in Thunar
    xfce.thunar-volman             # Removable media management
    
    # Useful utilities
    xfce.xfce4-appfinder           # Alternative app launcher
    xfce.xfce4-settings            # Settings manager (usually included but explicit)
    xfce.ristretto                 # Lightweight image viewer
    xfce.mousepad                  # Simple text editor (like Notepad)
    
    # Archive manager for GUI file extraction
    xarchiver                      # Lightweight archive manager that integrates with Thunar
    
    # Note: Using kitty terminal from main configuration.nix instead of xfce4-terminal
  ];
}
