{ pkgs, ... }:
{
  networking.firewall.allowedTCPPorts = [
    6443
  ];

  services.k3s = {
    enable = true;
    role = "server";
  };

  environment.systemPackages = [ pkgs.k3s ];

  systemd.services.k3s.path = [ pkgs.ipset ];
}
