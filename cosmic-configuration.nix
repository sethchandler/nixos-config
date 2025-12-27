{ pkgs,lib, ... }:

{
  # 1. Enable the native COSMIC Desktop
  services.desktopManager.cosmic.enable = true;
  
  # 2. Disable Cosmic Greeter - SDDM is already enabled in configuration.nix
  # SDDM can launch both X11 and Wayland sessions properly
  services.displayManager.cosmic-greeter.enable = lib.mkForce false;

  # 3. Exclude cosmic-edit if you prefer VSCode/Kate
  environment.cosmic.excludePackages = with pkgs; [ cosmic-edit ];


}
