{ config, ... }: {
  age.secrets.rtorrent-auth = {
    file = ./auth.age;
    owner = "nginx";
    group = "nginx";
  };

  services.nginx.virtualHosts = {
    "rtorrent.natanbc.net" = {
      addSSL = true;
      enableACME = true;
      acmeRoot = null;

      basicAuthFile = config.age.secrets.rtorrent-auth.path;
    };
  };
}
