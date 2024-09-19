{ config, ... }:
{
  services.nginx.clientMaxBodySize = "100M";
  services.nginx.virtualHosts = {
    "docker-registry.natanbc.net" = {
      addSSL = true;
      enableACME = true;
      locations."/".proxyPass =
        let
          ip = config.services.dockerRegistry.listenAddress;
          port = toString config.services.dockerRegistry.port;
        in "http://${ip}:${port}";
    };
  };
}
