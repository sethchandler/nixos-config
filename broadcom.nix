{ config, pkgs, ... }:

{
  # 1. Allow insecure package (required for specific Broadcom STA version)
  nixpkgs.config.permittedInsecurePackages = [
    "broadcom-sta-6.30.223.271-59-6.12.63"
  ];

  # 2. Add the Broadcom STA driver to the kernel
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];

  # 3. Load the 'wl' module and blacklist conflicting open-source drivers
  boot.kernelModules = [ "wl" ];
  boot.blacklistedKernelModules = [ "b43" "bcma" "brcmfmac" "brcmsmac" "ssb" ];
}
