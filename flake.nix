{
  description = "Rose NixOS System";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    sharedHomeManager = {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.backupFileExtension = "hm-backup";
      home-manager.users.seth = import ./home.nix;
    };
  in {
    nixosConfigurations = {

      Rose = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./rose-hardware.nix
          home-manager.nixosModules.home-manager
          sharedHomeManager
        ];
      };

      Rose-Cosmic = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./cosmic-configuration.nix
          ./rose-hardware.nix
          home-manager.nixosModules.home-manager
          sharedHomeManager
        ];
      };

      Rose-XFCE = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./xfce-configuration.nix
          ./rose-hardware.nix
          home-manager.nixosModules.home-manager
          sharedHomeManager
        ];
      };

      Rose-Experimental = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./cosmic-configuration.nix
          ./cinnamon-configuration.nix
          ./xfce-configuration.nix
          ./rose-hardware.nix
          home-manager.nixosModules.home-manager
          sharedHomeManager
        ];
      };
    };
  };
}
