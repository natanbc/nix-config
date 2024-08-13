{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/users/natan

    ./lanzaboote.nix
    ./remote-disk-unlock.nix
    ./wol.nix

    ./services
  ];

  networking = {
    hostName = "nas";
    useDHCP = true;
  };
  system.stateVersion = "24.05";

  # HACK: the package fails to build when used from home-manager, but works system-wide
  environment.systemPackages = with pkgs; [
    mstflint-connectx3
  ];
}
