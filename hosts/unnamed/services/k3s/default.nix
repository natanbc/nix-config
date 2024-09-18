{ config, pkgs, ... }:
{
  imports = [
    ./longhorn.nix
    ./nginx
  ];

  age.secrets.k3s-registry-config = {
    file = ./registry-config.age;
  };

  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = 65535;
    "fs.inotify.max_user_instances" = 65535;
    "fs.inotify.max_queued_events" = 65535;
  };

  environment.systemPackages = with pkgs; [ k3s ];

  networking.firewall.allowedTCPPorts = [
    6443
  ];

  services = {
    k3s = {
      enable = true;
      extraFlags = "--private-registry ${config.age.secrets.k3s-registry-config.path}";
      role = "server";
    };
  };

  systemd.services.k3s.path = with pkgs; [ ipset ];
}
