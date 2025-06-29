{ config, ... }: {
  networking.firewall.allowedTCPPorts = [ 444 ];
  security.acme.certs."git.natanbc.net".group = config.services.nginx.group;

  services.nginx.virtualHosts."git.natanbc.net" = {
    addSSL = true;
    useACMEHost = "git.natanbc.net";

    locations."/".proxyPass = "http://unix:${config.services.anubis.instances."git.natanbc.net".settings.BIND}";

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
}
