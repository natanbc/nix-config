{ config, ... }: {
  services.nginx.virtualHosts."git.natanbc.net" = {
    addSSL = true;
    enableACME = true;
    acmeRoot = null;

    locations."/".proxyPass = "http://unix:${config.services.anubis.instances."git.natanbc.net".settings.BIND}";
  };
}
