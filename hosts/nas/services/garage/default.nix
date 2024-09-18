{ config, pkgs, ... }:
{
  imports = [
    ./nginx.nix
  ];

  age.secrets = builtins.listToAttrs (builtins.map (name: {
    name = "garage-${name}";
    value = {
      file = ./. + "/${name}.age";
      group = "garage";
      owner = "garage";
    };
  }) ["admin-token" "metrics-token" "rpc-secret"]);

  users.users.garage = {
    group = "garage";
    isSystemUser = true;
  };
  users.groups.garage = {};

  services.garage = {
    enable = true;
    package = pkgs.garage;

    settings = rec {
      data_dir = "/mnt/garage";
      metadata_dir = "/var/lib/garage";
      db_engine = "sqlite";

      replication_factor = 1;
      # Data is already stored on ZFS
      disable_scrub = true;

      rpc_bind_addr = "127.0.0.1:3901";
      rpc_public_addr = rpc_bind_addr;
      rpc_secret_file = config.age.secrets.garage-rpc-secret.path;

      s3_api = {
        api_bind_addr = "/run/garage/s3-api.socket";
        s3_region = "garage";
        root_domain = "s3.natanbc.net";
      };

      admin = {
        api_bind_addr = "/run/garage/admin-api.socket";
        admin_token_file = config.age.secrets.garage-admin-token.path;
        metrics_token_file = config.age.secrets.garage-metrics-token.path;
      };
    };
  };

  systemd.services.garage.serviceConfig.DynamicUser = false;
  systemd.services.garage.serviceConfig.User = config.users.users.garage.name;
  systemd.services.garage.serviceConfig.Group = config.users.groups.garage.name;
  systemd.services.garage.serviceConfig.RuntimeDirectory = "garage";
}
