{
  description = "NixOS configs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = github:NixOS/nixpkgs/nixos-unstable;

    agenix = {
      url = "github:ryantm/agenix";
      inputs.darwin.follows = "";
      inputs.home-manager.follows = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = github:nix-community/home-manager/release-24.11;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.pre-commit-hooks-nix.follows = "";
    };

    scalpel = {
      url = "github:polygon/scalpel";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.sops-nix.follows = "";
    };
  };

  outputs = { self, nixpkgs, agenix, home-manager, lanzaboote, scalpel, ... } @ inputs:
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

          environment.etc."current-config".source = ./.;

          nixpkgs.overlays = builtins.attrValues outputs.overlays;
        })
        agenix.nixosModules.default
        lanzaboote.nixosModules.lanzaboote
        scalpel.nixosModules.scalpel
        (./hosts + "/${name}")
      ];
      specialArgs = { inherit inputs outputs; };
    };
  in {
    packages = let
      overlays = lib.composeManyExtensions (builtins.attrValues outputs.overlays);
    in forEachSystem (pkgs: overlays {} pkgs);

    overlays = {
      pkgs = final: prev: import ./pkgs { pkgs = prev; };
    } // (
      if (builtins.readFile ./priv-overlays/available) == "yes" then
        import ./priv-overlays
      else
        {}
    );

    nixosConfigurations = {
      live-iso = box "live-iso";
      live-iso-graphical = box "live-iso-graphical";
      nas = box "nas";
      unnamed = box "unnamed";
    };
  };
}

