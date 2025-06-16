{ config, lib, pkgs, ... }:
let
  cfg = config.services.k3s;
  yaml = pkgs.formats.yaml {};
  configFile = yaml.generate "k3s.yaml" cfg.settings;
in
{
  imports = [
    ./oidc.nix
    ./private-registry
  ];

  options.services.k3s = {
    settings = lib.mkOption {
      description = ''
        k3s.yaml configuration
      '';
      default = {};
      type = lib.types.attrs;
    };
  };

  config = {
    boot.kernel.sysctl = {
      "fs.inotify.max_user_watches" = 65535;
      "fs.inotify.max_user_instances" = 65535;
      "fs.inotify.max_queued_events" = 65535;
    };

    networking.firewall.allowedTCPPorts = [ 6443 ];
    networking.firewall.interfaces.cni0.allowedTCPPorts = [ 10250 ];

    services = {
      k3s = {
        enable = true;

        configPath = configFile;
        extraFlags = [
          "--disable" "coredns"
          "--disable" "local-storage"
          "--disable" "metrics-server"
          "--disable" "runtimes"
          "--disable" "servicelb"
          "--disable" "traefik"
        ];
        role = "server";
      };
    };

    systemd.services.k3s = {
      path = with pkgs; [ ipset ];
    };
  };
}
