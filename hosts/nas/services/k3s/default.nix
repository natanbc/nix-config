{ config, lib, pkgs, ... }:
let
  cfg = config.services.k3s;
  yaml = pkgs.formats.yaml {};
  configFile = yaml.generate "k3s.yaml" cfg.settings;
in
{
  imports = [
    ./flannel.nix
    ./kubelet.nix
    ./nginx
    ./private-registry
  ];

  options.services.k3s = {
    flags = lib.mkOption {
      description = ''
        k3s command line flags
      '';
      default = [];
      type = lib.types.listOf lib.types.str;
    };

    settings = lib.mkOption {
      description = ''
        k3s.yaml configuration
      '';
      default = {};
      type = lib.types.attrs;
    };
  };

  config = {
    age.secrets = {
      k3s-agent-token.file = ./agent-token.age;
      k3s-token.file = ./token.age;
    };

    boot.kernel.sysctl = {
      "fs.inotify.max_user_watches" = 65535;
      "fs.inotify.max_user_instances" = 65535;
      "fs.inotify.max_queued_events" = 65535;
    };

    networking.firewall.allowedTCPPorts = [
      6443
    ];

    networking.firewall.interfaces.cni0.allowedTCPPorts = [ 10250 ];

    services = {
      k3s = {
        enable = true;

        configPath = configFile;
        flags = [
          "--agent-token-file" "${config.age.secrets.k3s-agent-token.path}"
          "--disable" "coredns"
          "--disable" "local-storage"
          "--disable" "metrics-server"
          "--disable" "runtimes"
          "--disable" "servicelb"
          "--disable" "traefik"
          "--flannel-iface" "tailscale0"
        ];
        extraFlags = lib.concatStringsSep " " (builtins.map lib.escapeShellArg config.services.k3s.flags);
        role = "server";
        tokenFile = config.age.secrets.k3s-token.path;
      };
    };

    systemd.services.k3s = {
      after = [
        config.systemd.services.tailscaled.name
      ];
      path = with pkgs; [ ipset ];
    };
  };
}
