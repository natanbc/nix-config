{
  description = "NixOS configs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = github:NixOS/nixpkgs/nixos-unstable;

    home-manager = {
      url = github:nix-community/home-manager/release-23.11;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.darwin.follows = "";
    };
  };

  outputs = { self, nixpkgs, home-manager, agenix, ... } @ inputs:
  let
    inherit (self) outputs;
    box = name: nixpkgs.lib.nixosSystem {
      modules = [
        ({
          system.configurationRevision =
            if self ? rev
            then self.rev
            else "DIRTY";
        })
        (./hosts + "/${name}")
      ];
      specialArgs = { inherit inputs outputs; };
    };
  in {
    nixosConfigurations = {
      unnamed = box "unnamed";
    };
  };
}
