{ pkgs, ... }:
{
  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = 65535;
    "fs.inotify.max_user_instances" = 65535;
    "fs.inotify.max_queued_events" = 65535;
  };

  environment.systemPackages = with pkgs; [ k3s openiscsi ];

  networking.firewall.allowedTCPPorts = [
    6443
  ];

  services.k3s = {
    enable = true;
    role = "server";
  };

  systemd.services.k3s.path = with pkgs; [ ipset ];
}
