{ pkgs, ... }:

{
  # 1. Enable the native COSMIC Desktop
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  # 2. Exclude the text editor if it causes conflicts (optional but safe)
  # environment.cosmic.excludePackages = with pkgs; [ cosmic-edit ];
}
