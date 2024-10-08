{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/optional/cloudflare-dns01.nix
    ../common/optional/nginx.nix
    ../common/optional/tailscale.nix
    ../common/optional/zfs.nix
    ../common/users/natan

    ./lanzaboote.nix
    ./remote-disk-unlock.nix
    ./services
    ./wol.nix

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
