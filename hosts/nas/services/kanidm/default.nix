{ config, pkgs, ... }:
let
  domain = "idp.x86-64.mov";
  port = 44443;
  tls_dir = config.security.acme.certs."${domain}".directory;
in
{
  networking.firewall.allowedTCPPorts = [ port ];

  security.acme.certs."${domain}".group = config.users.groups.kanidm.name;

  services.kanidm = {
    enableServer = true;
    package = pkgs.kanidm_1_6;
    serverSettings = {
      bindaddress = "0.0.0.0:${toString port}";
      tls_chain = "${tls_dir}/fullchain.pem";
      tls_key = "${tls_dir}/key.pem";
      domain = domain;
      origin = "https://${domain}";
    };
  };
}
