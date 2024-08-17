{ config, ... }:
{
  services.samba = {
    enable = true;

    extraConfig = ''
      guest account = nobody
      map to guest = bad user

      logging = syslog@3
    '';

    shares = {
    };
  };

  systemd.services.samba-smbd.after = [
    config.systemd.services.tailscaled.name
  ];
}
