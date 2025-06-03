{ config, ... }:
{
  age.secrets.cloudflared-credentials = {
    file = ./credentials.age;
  };

  services.cloudflared = {
    enable = true;
    tunnels = {
      "2a26f50f-d803-41e9-b3a4-a34c8b5104a2" = {
        credentialsFile = config.age.secrets.cloudflared-credentials.path;
        ingress = {
        };
        default = "http_status:404";
      };
    };
  };
}

