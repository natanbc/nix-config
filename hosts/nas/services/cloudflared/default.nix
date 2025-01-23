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
      "a55b94ed-5be5-4616-b916-720ce605da46" = {
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

