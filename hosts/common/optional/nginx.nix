{
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  security.acme = {
    acceptTerms = true;
    defaults.email = "acme@natanbc.net";
  };

  services.nginx = {
    enable = true;

    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    commonHttpConfig = ''
      set_real_ip_from 127.0.0.0/8;
      set_real_ip_from ::1/128;
      real_ip_header CF-Connecting-IP;

      # For websockets
      map $http_upgrade $connection_upgrade {
        default upgrade;
        \'\'      close;
      }
    '';
  };
}
