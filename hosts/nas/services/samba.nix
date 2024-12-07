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
      nmbd.enable = false;
      winbindd.enable = false;
      openFirewall = true;

      settings = {
        global = {
          "guest account" = "nobody";
          "map to guest" = "bad user";

          "logging" = "syslog@3";

          "encrypt passwords" = true;
          "server signing" = "mandatory";
          "server min protocol" = "SMB3";
          "server smb encrypt" = "required";
        };

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
