{ config, ... }: {
  assertions = [{
    assertion = config.services.oauth2-proxy.enable;
    message = "rtorrent authentication is handled by oauth2-proxy";
  }];

  services.nginx.virtualHosts = {
    "rtorrent.natanbc.net" = {
      addSSL = true;
      enableACME = true;
      acmeRoot = null;

    };
  };

  services.oauth2-proxy.nginx.virtualHosts."rtorrent.natanbc.net" = {
    allowed_groups = ["rtorrent_users@idp.x86-64.mov"];
  };
}
