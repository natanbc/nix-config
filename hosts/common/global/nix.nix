{ lib, ... }:
{
  nix = {
    settings = {
      auto-optimise-store = lib.mkDefault true;
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
    };

    gc = {
      automatic = lib.mkDefault true;
      dates = "weekly";
      options = "--delete-older-than +3";
    };
  };
}
