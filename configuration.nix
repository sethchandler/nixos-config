# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
     # ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "Rose"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
# 1. Allow unfree software (required for proprietary Broadcom drivers)
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.permittedInsecurePackages = [
                "broadcom-sta-6.30.223.271-59-6.12.63"
              ];

  # 2. Add the Broadcom STA driver to the kernel
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];

  # 3. Load the 'wl' module and blacklist conflicting open-source drivers
  boot.kernelModules = [ "wl" ];
  boot.blacklistedKernelModules = [ "b43" "bcma" "brcmfmac" "brcmsmac" "ssb" ];
  # Add support for these filesystems at the kernel level
boot.supportedFilesystems = [ "ntfs" "cifs" "exfat" ];

  # 4. Ensure Networking is enabled (if not already)
  #networking.networkmanager.enable = true;
  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.samba.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.seth = {
    isNormalUser = true;
    description = "Seth Chandler";
    extraGroups = [ "networkmanager" "wheel" "video" "input" "libvirtd"];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;
  programs.nix-ld.enable = true;
  programs.vscode.enable = true;
  programs.hyprland.enable = true;
  #programs.waybar.enable = true;
  programs.fish.enable = true;
  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;

  fonts.packages = with pkgs; [
    font-awesome       # The standard library of icons
    nerd-fonts.jetbrains-mono  # A coding font that includes thousands of icons
  ];

  # Allow unfree packages
  #nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  vim
  git
  gh
  antigravity
  obsidian
  qutebrowser
  micro
  flameshot
  code-cursor
  libreoffice
  librewolf-bin
  signal-desktop
  #google-chrome
  #spotify
  # -- Core Tools --
    kitty
    rofi
    waybar
    dunst
    hyprpaper
    networkmanagerapplet
    pavucontrol

    # -- Screenshot Tools --
    grim
    slurp
    wl-clipboard

    # -- File Manager --
    nautilus       # The file manager
    sushi          # Quick previewer (hit spacebar on a file to peek at it)
    # --- GUI Disk Utilities ---
  gparted      # Partition editor
  gnome-disk-utility # "Disks" - often better for quick mounting/benchmarking

  # --- Filesystem Helpers (Crucial for GParted to work on all formats) ---
  ntfs3g       # NTFS support
  exfat        # exFAT support
  dosfstools   # FAT32 tools
  hfsprogs     # MacOS HFS+ tools

  # --- System Monitoring ---
  btop         # Modern, beautiful version of htop
  iotop        # See what's eating your disk I/O
  nvtopPackages.full # GPU monitoring (NVIDIA/AMD/Intel)

  # --- Network Tools ---
  dig          # DNS lookup
  wget         # File downloader
  curl         # URL transfer
  nmap         # Network scanner
  ethtool      # Network card diagnostics

  # --- File Management & Search ---
  tree         # Visual directory structure
  file         # Determine file type
  zip    # Standard archives
  unzip
  p7zip        # 7z archives
  ripgrep      # Super fast grep (rg)
  fd           # Super fast find
 # for backing up
 timeshift
 backintime
 rsync
 matugen
 swww
 waybar
  ];




  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

}
