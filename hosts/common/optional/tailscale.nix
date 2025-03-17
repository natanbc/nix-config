{ config, inputs, lib, pkgs, ... }:
let
  cfg = config.services.tailscale;
  defaultServerRouting = cfg.advertiseSubnets != [] || cfg.advertiseExitNode;
  routeString = lib.strings.concatStringsSep "," cfg.advertiseSubnets;
  tuneForwarding = cfg.enable && builtins.elem cfg.useRoutingFeatures ["both" "server"];
in
{
  options.services.tailscale = {
    advertiseExitNode = lib.mkOption {
      description = ''
        Whether to advertise the machine as an exit node.
      '';
      default = false;
      type = lib.types.bool;
    };

    advertiseSubnets = lib.mkOption {
      description = ''
        Extra subnets to advertise as routes.
      '';
      default = [];
      type = lib.types.listOf lib.types.str;
    };
  };

  config = {
    services.tailscale = {
      enable = true;
      extraSetFlags = (
        (lib.optional cfg.advertiseExitNode "--advertise-exit-node") ++
        (lib.optional (cfg.advertiseSubnets != []) "--advertise-routes=${routeString}")
      );
      openFirewall = true;
      useRoutingFeatures = lib.mkDefault (if defaultServerRouting then "both" else "client");

      package = (import inputs.nixpkgs-unstable {
        system = pkgs.system;
      }).tailscale;
    };

    services.udev.extraRules = lib.mkIf tuneForwarding ''
      ACTION=="add", SUBSYSTEM=="net", RUN+="${pkgs.ethtool}/bin/ethtool -K $name rx-udp-gro-forwarding on rx-gro-list off"
    '';
  };
}
