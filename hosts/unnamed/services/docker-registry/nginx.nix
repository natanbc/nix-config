{ config, ... }:
{
  services.nginx.virtualHosts = {
    "docker-registry.natanbc.net" = {
      addSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass =
          let
            ip = config.services.dockerRegistry.listenAddress;
            port = toString config.services.dockerRegistry.port;
          in "http://${ip}:${port}";
        extraConfig = ''
          proxy_request_buffering off;
          client_max_body_size 5G;
        '';
      };
    };
  };
}
