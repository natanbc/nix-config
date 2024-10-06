{
  services.nginx.virtualHosts = {
    "argocd-webhook.natanbc.net" = {
      addSSL = true;
      enableACME = true;
      locations."/api/webhook" = {
        proxyPass = "https://127.0.0.1:31243";
        extraConfig = ''
          proxy_ssl_verify off;
        '';
      };
    };
  };
}
