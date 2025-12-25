{
  description = "Foxy NixOS flake with COSMIC experiment";

  inputs = {
    # Your existing 25.11 source
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    # New input for COSMIC
    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    nixos-cosmic.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixos-cosmic, ... }@inputs: {
    nixosConfigurations = {

      # 1. Your original "safe" configuration
      # Run: sudo nixos-rebuild switch --flake .#Foxy
      Foxy = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
        ];
      };

      # 2. Your experimental COSMIC configuration
      # Run: sudo nixos-rebuild switch --flake .#Foxy-Cosmic
      Foxy-Cosmic = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix         # Keeps your users, apps, and hardware settings
          ./cosmic-configuration.nix  # A new file just for COSMIC settings
          nixos-cosmic.nixosModules.default
        ];
      };
    };
  };
}



