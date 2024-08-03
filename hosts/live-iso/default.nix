{ inputs, pkgs, ... }:
{
  imports = [
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"

    ../common/global

    ./hardware-configuration.nix
    ./packages.nix
    ./services.nix
    ./sysctl.nix
  ];

  networking = {
    hostName = "live-iso";
    useDHCP = true;
  };
  system.stateVersion = "23.11";

  nix = {
    settings.auto-optimise-store = false;
    gc.automatic = false;
  };

  systemd.tmpfiles.settings = {
    "10-var-lib-misc" = {
      "/var/lib/misc" = {
        d = {
          group = "root";
          user = "root";
          mode = "0755";
        };
      };
    };
  };
}

