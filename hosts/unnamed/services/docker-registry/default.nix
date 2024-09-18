{ config, ... }:
let
  user = config.systemd.services.docker-registry.serviceConfig.User;
in
{
  age.secrets.docker-registry-htpasswd = {
    file = ./htpasswd.age;
    group = user;
    owner = user;
  };

  services.dockerRegistry = {
    enable = true;
    enableDelete = true;
    enableGarbageCollect = true;
    extraConfig = {
      auth = {
        htpasswd = {
          realm = "natanbc";
          path = config.age.secrets.docker-registry-htpasswd.path;
        };
      };
    };
    listenAddress = "127.0.0.1";
  };

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
