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
      enableNmbd = false;
      enableWinbindd = false;
      openFirewall = true;

      extraConfig = ''
        guest account = nobody
        map to guest = bad user

        logging = syslog@3
      '';

      shares = {
        data = {
          path = config.fileSystems."/data".mountPoint;
          "read only" = "no";
          browseable = "yes";
          "guest ok" = "no";
          comment = "NAS file share";
        };
        scratch = {
          path = config.fileSystems."/mnt/scratch".mountPoint;
          "read only" = "no";
          browseable = "yes";
          "guest ok" = "no";
          comment = "NAS scratch storage";
        };
      };
    };

    samba-wsdd = {
      enable = true;
      openFirewall = true;
    };
  };
}
