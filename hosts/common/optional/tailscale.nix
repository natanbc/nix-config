{ config, inputs, lib, pkgs, ... }:
let
  cfg = config.services.tailscale;
  tuneForwarding = cfg.enable && builtins.elem cfg.useRoutingFeatures ["both" "server"];
in
{
  services.tailscale = {
    enable = true;
    openFirewall = true;
    useRoutingFeatures = lib.mkDefault "client";

    package = (import inputs.nixpkgs-unstable {
      system = pkgs.system;
    }).tailscale;
  };

  services.udev.extraRules = lib.mkIf tuneForwarding ''
    ACTION=="add", SUBSYSTEM=="net", RUN+="${pkgs.ethtool}/bin/ethtool -K $name rx-udp-gro-forwarding on rx-gro-list off"
  '';
}
