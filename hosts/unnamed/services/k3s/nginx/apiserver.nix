{
  services.nginx.virtualHosts = {
    "k3s.natanbc.net" = {
      enableACME = true;
      onlySSL = true;
      locations."/" = {
        proxyPass = "https://127.0.0.1:6443";
        extraConfig = ''
          proxy_ssl_verify off;
        '';
      };
    };
  };
}
