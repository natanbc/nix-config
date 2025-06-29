{ config, ... }: {
  services.anubis.instances."git.natanbc.net" = {
    settings = {
      TARGET = "unix://${config.services.forgejo.settings.server.HTTP_ADDR}";
      COOKIE_DOMAIN = "git.natanbc.net";
      REDIRECT_DOMAINS = "git.natanbc.net";
    };
  };
}
