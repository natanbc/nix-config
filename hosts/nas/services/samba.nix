{ config, ... }:
{
  services = {
    avahi = {
      enable = true;
      openFirewall = true;

      publish = {
        enable = true;
        userServices = true;
      };
    };

    samba = {
      enable = true;
      openFirewall = true;

      extraConfig = ''
        guest account = nobody
        map to guest = bad user

        logging = syslog@3
      '';

      shares = {
        data = {
          path = "/data";
          "read only" = "no";
          browseable = "yes";
          "guest ok" = "no";
          comment = "NAS file share";
        };
      };
    };

    samba-wsdd = {
      enable = true;
      openFirewall = true;
    };
  };
}
