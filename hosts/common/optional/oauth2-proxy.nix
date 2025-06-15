{ config, lib, ... }:
{
  age.secrets.oauth2-proxy = {
    owner = config.users.users.oauth2-proxy.name;
    group = config.users.groups.oauth2-proxy.name;
  };

  services.oauth2-proxy = rec {
    enable = true;

    keyFile = config.age.secrets.oauth2-proxy.path;
    # Unix socket doesn't work because the NixOS module tries appending a path to it
    httpAddress = "127.0.0.1:44444";
    requestLogging = false;

    email.domains = lib.mkDefault [ "*" ];

    provider = "oidc";
    scope = "openid email profile groups";
    # Needed until https://github.com/oauth2-proxy/oauth2-proxy/pull/2851 is merged
    oidcIssuerUrl = "https://idp.x86-64.mov/oauth2/openid/${config.services.oauth2-proxy.clientID}";
    extraConfig = {
      code-challenge-method = "S256";
      whitelist-domain = [".natanbc.net"];
      session-cookie-minimal = true;
    };

    cookie = {
      domain = ".natanbc.net";
      name = "_oa2_p_" + (lib.replaceStrings ["-"] ["_"] config.services.oauth2-proxy.clientID);
    };

    nginx = {
      proxy = "http://127.0.0.1:44444";
    };
  };
}
