{ lib, ... }:
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
  };
}
