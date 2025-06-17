{ inputs, lib, ... }:
let
  flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
in
{
  nix = {
    settings = {
      auto-optimise-store = lib.mkDefault true;
      experimental-features = [ "nix-command" "flakes" ];
    };

    gc = {
      automatic = lib.mkDefault true;
      dates = "weekly";
    };

    registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };
}
