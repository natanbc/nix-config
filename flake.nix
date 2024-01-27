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
    lib = nixpkgs.lib;

    systems = [ "x86_64-linux" "aarch64-linux" ];
    pkgsFor = lib.genAttrs systems (system: import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    });
    forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});

    box = name: lib.nixosSystem {
      modules = [
        ({
          system.configurationRevision =
            if self ? rev
            then self.rev
            else "DIRTY";

          nixpkgs.overlays = builtins.attrValues outputs.overlays;
        })
        agenix.nixosModules.default
        (./hosts + "/${name}")
      ];
      specialArgs = { inherit inputs outputs; };
    };
  in {
    packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });

    overlays = {
      pkgs = final: prev: import ./pkgs { pkgs = final; };
    };

    nixosConfigurations = {
      live-iso = box "live-iso";
      unnamed = box "unnamed";
    };
  };
}

