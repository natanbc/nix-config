{ config, pkgs, ... }:
{
  imports = [
    ../../../common/optional/oauth2-proxy.nix
  ];

  age.secrets.oauth2-proxy.file = ./secrets.nix;

  services.nginx.virtualHosts."${config.services.oauth2-proxy.nginx.domain}" = {
    addSSL = true;
    enableACME = true;
  };

  services.oauth2-proxy = {
    clientID = "oauth2-proxy-nas";
    nginx.domain = "oauth2-proxy-nas.natanbc.net";
  };

  systemd.services.oauth2-proxy.after = [
    config.systemd.services.kanidm.name
  ];
}
