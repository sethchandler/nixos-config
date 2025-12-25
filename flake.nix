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

    };
  };
}



