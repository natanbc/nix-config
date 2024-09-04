{ pkgs, ... }:
{
  networking.firewall.allowedTCPPorts = [
    6443
  ];

  services.k3s = {
    enable = true;
    role = "server";
  };

  environment.systemPackages = with pkgs; [ k3s openiscsi ];

  systemd.services.k3s.path = with pkgs; [ ipset ];
}
