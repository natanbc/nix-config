{ config, ... }:
{
  age.secrets = let
    s = name: {
      "mastodon-${name}" = {
        file = ./. + "/${name}.age";
        group = "mastodon";
        owner = "mastodon";
      };
    };
  in {}
  // s "otp-key"
  // s "secret-key-base"
  // s "vapid-priv"
  // s "vapid-pub";

  services.mastodon = {
    enable = true;
    localDomain = "natanbc.net";
    extraConfig = {
#      AUTHORIZED_FETCH = "true";
      SINGLE_USER_MODE = "true";
      WEB_DOMAIN = "mastodon.natanbc.net";
    };

    mediaAutoRemove = {
      enable = true;
      olderThanDays = 90;
    };

    configureNginx = true;
    smtp.fromAddress = "noreply@mastodon.natanbc.net";
    streamingProcesses = 3;

    otpSecretFile = config.age.secrets.mastodon-otp-key.path;
    secretKeyBaseFile = config.age.secrets.mastodon-secret-key-base.path;
    vapidPrivateKeyFile = config.age.secrets.mastodon-vapid-priv.path;
    vapidPublicKeyFile = config.age.secrets.mastodon-vapid-pub.path;
  };

  services.nginx.virtualHosts."natanbc.net" = {
    forceSSL = false;
    enableACME = false;
    locations."@proxy" = {
      extraConfig = "proxy_set_header X-Forwarded-Proto https;";
    };
  };
}

