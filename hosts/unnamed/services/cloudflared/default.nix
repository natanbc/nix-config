{ config, ... }:
{
  age.secrets.cloudflared-credentials = {
    file = ./credentials.age;
    group = config.services.cloudflared.group;
    owner = config.services.cloudflared.user;
  };

  services.cloudflared = {
    enable = true;
    tunnels = {
      "2a26f50f-d803-41e9-b3a4-a34c8b5104a2" = {
        credentialsFile = config.age.secrets.cloudflared-credentials.path;
        ingress = {
          "docker-registry.natanbc.net" = {
            service = "http://localhost:80";
          };
        };
        default = "http_status:404";
      };
    };
  };
}

