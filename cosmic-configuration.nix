{ pkgs,lib, ... }:

{
  # 1. Enable the native COSMIC Desktop
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  # 2. CRITICAL: Disable SDDM so it doesn't conflict with Cosmic Greeter
  # This override ONLY happens when you boot the Cosmic build.
  services.displayManager.sddm.enable = lib.mkForce false;

  # 3. Exclude cosmic-edit if you prefer VSCode/Kate
  environment.cosmic.excludePackages = with pkgs; [ cosmic-edit ];


}
