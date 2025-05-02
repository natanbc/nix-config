{
  services.nginx.virtualHosts = {
    "rtorrent.natanbc.net" = {
      addSSL = true;
      enableACME = true;
      acmeRoot = null;
    };
  };
}
