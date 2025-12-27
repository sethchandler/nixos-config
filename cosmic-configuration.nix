{ pkgs,lib, ... }:

{
  # 1. Enable the native COSMIC Desktop
  services.desktopManager.cosmic.enable = true;
  
  # 2. Use SDDM instead of Cosmic Greeter for proper X11 session support
  # SDDM can launch both X11 and Wayland sessions properly
  services.displayManager.sddm.enable = true;
  services.displayManager.cosmic-greeter.enable = lib.mkForce false;

  # 3. Exclude cosmic-edit if you prefer VSCode/Kate
  environment.cosmic.excludePackages = with pkgs; [ cosmic-edit ];


}
