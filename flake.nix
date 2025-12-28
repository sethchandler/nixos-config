{
  description = "Rose NixOS System";

  inputs = {
    # You are on the 25.11 branch, which HAS Cosmic natively
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {


      # Your Stable System
      Rose = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [ ./configuration.nix
                    ./rose-hardware.nix
                    ];
      };

      # Your Cosmic Experiment
      Rose-Cosmic = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./cosmic-configuration.nix
          ./rose-hardware.nix
        ];
      };

      # Lightweight XFCE-only configuration
      Rose-XFCE = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./xfce-configuration.nix
          ./rose-hardware.nix
        ];
      };

      # The "Kitchen Sink" - KDE + COSMIC + Cinnamon + XFCE
      Rose-Experimental = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./cosmic-configuration.nix
          ./cinnamon-configuration.nix
          ./xfce-configuration.nix
          ./rose-hardware.nix
        ];
      };
    };
  };
}



