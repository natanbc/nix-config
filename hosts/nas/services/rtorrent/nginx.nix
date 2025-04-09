{
  services.nginx.virtualHosts = {
    "rtorrent.natanbc.net" = {
      addSSL = true;
      enableACME = true;
      acmeRoot = null;

      listenAddresses = [ "100.77.21.38" "[fd7a:115c:a1e0::e001:1526]" ];
    };
  };
}
