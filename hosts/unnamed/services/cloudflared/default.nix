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
      "00000000-0000-0000-0000-000000000000" = {
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

