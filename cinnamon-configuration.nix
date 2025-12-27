{ pkgs, ... }:

{
  # 1. Enable the Cinnamon Desktop Manager
  services.xserver.desktopManager.cinnamon.enable = true;

  # 2. Enable Cinnamon-specific applications (Nemo, Xed, etc.)
  services.cinnamon.apps.enable = true;

  # 3. Add xinit to provide 'startx' which some sessions might expect when launched from Wayland greeters
  environment.systemPackages = with pkgs; [
    xorg.xinit
    cinnamon-common
    nemo-with-extensions
    mint-themes
    mint-x-icons
    mint-cursor-themes
  ];
}
