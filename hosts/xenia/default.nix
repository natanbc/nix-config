{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/optional/tailscale.nix
    ../common/optional/zfs.nix
    ../common/users/natan

    ./udev.nix
  ];

  networking = {
    hostName = "xenia";
    useDHCP = true;
  };
  system.stateVersion = "24.11";
}
