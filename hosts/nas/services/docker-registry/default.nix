{ config, ... }:
let
  user = config.systemd.services.docker-registry.serviceConfig.User;
in
{
  imports = [
    ./nginx.nix
  ];

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
      catalog = {
        maxentries = 10000; # For compat with registry-cli
      };
    };
    listenAddress = "127.0.0.1";
  };

  systemd.services.docker-registry.serviceConfig.Environment = "OTEL_TRACES_EXPORTER=none";
}
