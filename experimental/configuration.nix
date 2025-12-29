{ config, pkgs, ... }:

{
  # Basic system configuration
  imports = [ ];

  # Set your hostname
  networking.hostName = "ultra-minimal";

  programs.neovim.enable = true;
  services.xserver.windowManager.dwm.enable = true;

  # Select minimal profile
  environment.systemPackages = with pkgs; [
    micro  # Minimal text editor
    st    # Simple terminal
    mc    # Midnight Commander for file management
    shell-gpt
  ];

  # Enable a simple display manager or just start X manually
  services.xserver.enable = true;
  services.xserver.windowManager.session = [{
    name = "dwm";
    start = ''
      ${pkgs.dwm}/bin/dwm
    '';
  }];

  # Minimal networking
  networking.networkmanager.enable = true;

   # Enable Broadcom STA (wl) driver
  hardware.enableAllFirmware = true;
  boot.extraModulePackages = with config.boot.kernelPackages; [ broadcom_sta ];

  # Blacklist conflicting drivers
  boot.blacklistedKernelModules = [ "bcma" "b43" "ssb" "brcmfmac" "brcmsmac" ];

  # Other minimal settings...

  hardware.enableAllFirmware = true;
  boot.extra
}
