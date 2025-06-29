{ config, ... }: {
  assertions = [{
    assertion = config.services.oauth2-proxy.enable;
    message = "rtorrent authentication is handled by oauth2-proxy";
  }];

  networking.firewall.allowedTCPPorts = [ 444 ];
  security.acme.certs."rtorrent.natanbc.net".group = config.services.nginx.group;

  services.nginx.virtualHosts = {
    "rtorrent.natanbc.net" = {
      addSSL = true;
      useACMEHost = "rtorrent.natanbc.net";

      listen = [
        { addr = "0.0.0.0"; port = 444; proxyProtocol = true; ssl = true; }
        { addr = "[::0]";   port = 444; proxyProtocol = true; ssl = true; }
      ];

      extraConfig = ''
        set_real_ip_from 100.64.0.0/10;
        set_real_ip_from fd7a:115c:a1e0::/48;
        real_ip_header proxy_protocol;
      '';
    };
  };

  services.oauth2-proxy.nginx.virtualHosts."rtorrent.natanbc.net" = {
    allowed_groups = ["rtorrent_users@idp.x86-64.mov"];
  };
}
