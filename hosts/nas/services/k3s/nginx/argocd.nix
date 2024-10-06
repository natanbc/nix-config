{
  services.nginx.virtualHosts = {
    "argocd.natanbc.net" = {
      addSSL = true;
      enableACME = true;
      acmeRoot = null;

      locations."/" = {
        proxyPass = "https://127.0.0.1:31243";
        extraConfig = ''
          proxy_ssl_verify off;
        '';
      };
    };
  };
}
