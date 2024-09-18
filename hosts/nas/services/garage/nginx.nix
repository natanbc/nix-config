{
  services.nginx.virtualHosts = {
    "s3.natanbc.net" = {
      addSSL = true;
      enableACME = true;
      locations."/".proxyPass = "http://unix:/run/garage/s3-api.socket";
    };
  };
}
