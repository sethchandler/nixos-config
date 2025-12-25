{
  description = "Foxy NixOS System";

  inputs = {
    # You are on the 25.11 branch, which HAS Cosmic natively
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      # Your Stable System
      Foxy = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [ ./configuration.nix ];
      };

      # Your Cosmic Experiment
      Foxy-Cosmic = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./cosmic-configuration.nix
        ];
      };
    };
  };
}



