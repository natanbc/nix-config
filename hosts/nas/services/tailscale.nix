{ inputs, pkgs, ... }:
{
  services.tailscale = {
    enable = true;
    extraSetFlags = ["--advertise-exit-node"];
    openFirewall = true;
    useRoutingFeatures = "both";

    package = (import inputs.nixpkgs-unstable {
      system = pkgs.system;
    }).tailscale;
  };
}
