{ config, ... }:
{
  age.secrets.cloudflared-credentials = {
    file = ./cloudflared-credentials.age;
    group = "cloudflared";
    owner = "cloudflared";
  };

  services.cloudflared = {
    enable = true;
    tunnels = {
      "2a26f50f-d803-41e9-b3a4-a34c8b5104a2" = {
        credentialsFile = config.age.secrets.cloudflared-credentials.path;
        ingress = {
          "mastodon.natanbc.net" = {
            service = "http://localhost:55001";
          };
        };
        default = "http_status:404";
      };
    };
  };
}

