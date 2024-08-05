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
      # This option can only take `Xd` as an argument, see ./nix-gc.nix for the workaround
      #options = "--delete-older-than +3";

      nixEnvOptions = "--delete-generations +3";
      options = "-d";
    };
  };
}
