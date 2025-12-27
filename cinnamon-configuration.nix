{ pkgs, ... }:

{
  # 1. Enable the Cinnamon Desktop Manager
  services.xserver.desktopManager.cinnamon.enable = true;

  # 2. Enable Cinnamon-specific applications (Nemo, Xed, etc.)
  services.cinnamon.apps.enable = true;
}
