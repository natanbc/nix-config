{ config, pkgs, ... }:
{
  age.secrets.quartus-license.file = ./quartus-license.age;
  age.secrets.macaddr.file = ./macaddr.age;

  environment.variables.LM_LICENSE_FILE = config.scalpel.trafos."quartus-license.dat".destination;

  scalpel.trafos."quartus-license.dat" = {
    source = config.age.secrets.quartus-license.path;
    matchers.MACADDR.secret = config.age.secrets.macaddr.path;
    mode = "0444";
  };

  systemd.tmpfiles.rules = [
    "L+ /opt/quartus-prime-standard - - - - ${pkgs.quartus-prime-standard}"
  ];
}
