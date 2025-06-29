{ config, pkgs, ... }:
let
  domain = "oauth2-proxy-nas.natanbc.net";
in
{
  imports = [
    ../../../common/optional/oauth2-proxy.nix
  ];

  age.secrets.oauth2-proxy.file = ./secrets.nix;

  networking.firewall.allowedTCPPorts = [ 444 ];
  security.acme.certs."${domain}".group = config.services.nginx.group;

  services.nginx.virtualHosts."${domain}" = {
    addSSL = true;
    useACMEHost = domain;

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

  services.oauth2-proxy = {
    clientID = "oauth2-proxy-nas";
    nginx.domain = domain;
    reverseProxy = true;
  };

  systemd.services.oauth2-proxy.after = [
    config.systemd.services.kanidm.name
  ];
}
