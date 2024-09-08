{ inputs, lib, pkgs, ... }:
{
  services.tailscale = {
    enable = true;
    openFirewall = true;
    useRoutingFeatures = lib.mkDefault "client";

    package = (import inputs.nixpkgs-unstable {
      system = pkgs.system;
    }).tailscale;
  };
}
