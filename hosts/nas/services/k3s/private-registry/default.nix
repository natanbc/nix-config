{ config, pkgs, ... }:
{
  age.secrets.docker-registry-password.file = ./password.age;

  scalpel.trafos."k3s-private-registry.yml" = {
    source = toString ((pkgs.formats.yaml {}).generate "k3s-private-registry.yml" {
      configs = {
        "docker-registry.natanbc.net".auth = {
          username = "kubernetes";
          password = "!!PASSWORD!!";
        };
      };
    });
    matchers.PASSWORD.secret = config.age.secrets.docker-registry-password.path;
  };

  services.k3s.settings = {
    private-registry = config.scalpel.trafos."k3s-private-registry.yml".destination;
  };
}
