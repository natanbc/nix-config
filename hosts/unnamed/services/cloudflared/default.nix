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
          "k3s.natanbc.net" = {
            service = "https://localhost:6443";
          };
          "argocd-webhook.natanbc.net" = {
            service = "https://localhost:31243";
          };
          "did-ze-use-the-nixos-vm-yet.natanbc.net" = {
            service = "http://localhost:80";
          };
        };
        originRequest.noTLSVerify = true;
        default = "http_status:404";
      };
    };
  };
}

