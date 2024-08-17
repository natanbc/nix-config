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
      # Test share, just to measure performance
      test = {
        path = "/tmp/samba-test";
        browseable = "yes";
        "force user" = config.users.users.samba-test.name;
        "guest ok" = "yes";
        writeable = "yes";
      };
    };
  };

  systemd.services.samba-smbd.after = [
    config.systemd.services.tailscaled.name
  ];

  users.users.samba-test = {
    isSystemUser = true;
    group = config.users.groups.samba-test.name;
  };
  users.groups.samba-test = {};
}
