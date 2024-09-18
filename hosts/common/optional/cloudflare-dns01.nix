{ config, ... }:
{
  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "acme@natanbc.net";

      dnsProvider = "cloudflare";
      credentialFiles = {
        "CLOUDFLARE_DNS_API_TOKEN_FILE" = config.age.secrets.cloudflare-dns-token.path;
      };
    };
  };
}
