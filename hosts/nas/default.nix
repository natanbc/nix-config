{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/users/natan

    ./lanzaboote.nix
    ./remote-disk-unlock.nix
    ./wol.nix

    ./fs
    ./services
  ];

  boot.kernelParams = [
    # 96GiB
    "zfs.zfs_arc_max=103079215104"
  ];
  boot.tmp.tmpfsSize = "112G";

  networking = {
    hostName = "nas";
    useDHCP = true;
  };
  system.stateVersion = "24.05";
}
