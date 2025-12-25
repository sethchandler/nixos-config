{ pkgs, ... }:

{
  # Enable the COSMIC Desktop
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  # Binary cache to avoid long compile times
  nix.settings = {
    substituters = [ "https://cosmic.cachix.org" ];
    trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD0w8M3wHwdF4W9qaQl1LFeXX94HLN7idMxCg=" ];
  };
}

