{ pkgs, ... }:
{
  # Longhorn-specific configuration

  environment.systemPackages = with pkgs; [ openiscsi ];

  services = {
    openiscsi = {
      enable = true;
      name = "iqn.2024-09.net.natanbc:unnamed";
    };
  };

  systemd.tmpfiles.rules = [
    "L+ /usr/local/bin - - - - /run/current-system/sw/bin/"
  ];
}
