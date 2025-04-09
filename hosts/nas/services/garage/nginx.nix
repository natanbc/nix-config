{
  services.nginx.virtualHosts = {
    "s3.natanbc.net" = {
      addSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://unix:/run/garage/s3-api.socket";
        extraConfig = ''
          proxy_request_buffering off;
          client_max_body_size 5G;
        '';
      };
    };
    "s.natanbc.net" = {
      addSSL = true;
      enableACME = true;
      locations."/".proxyPass = "http://unix:/run/garage/s3-web.socket";
    };
  };
}
