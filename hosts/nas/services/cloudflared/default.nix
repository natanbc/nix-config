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
      "9e9faf95-a6a0-47d2-b6db-7517078d29d6" = {
        credentialsFile = config.age.secrets.cloudflared-credentials.path;
        ingress = {
          "argocd-webhook.natanbc.net" = {
            service = "http://localhost:80";
          };
          "docker-registry.natanbc.net" = {
            service = "http://localhost:80";
          };
          "s3.natanbc.net" = {
            service = "http://localhost:80";
          };
          "s3web.natanbc.net" = {
            service = "http://localhost:80";
          };
        };
        default = "http_status:404";
      };
    };
  };
}

