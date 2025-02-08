{ lib, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/optional/cloudflare-dns01.nix
    ../common/optional/nginx.nix
    ../common/optional/tailscale.nix
    ../common/optional/zfs.nix
    ../common/users/natan

    ./connectx3-sriov.nix
    ./lanzaboote.nix
    ./remote-disk-unlock.nix
    ./services
    ./wol.nix

  ];
  
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "quartus-prime-standard-unwrapped"
    "quartus-unwrapped"
  ];

  boot.kernelParams = [
    # 96GiB
    "zfs.zfs_arc_max=103079215104"
  ];
  boot.tmp.tmpfsSize = "112G";

  systemd.tmpfiles.rules = [
    "L+ /opt/quartus-prime-standard - - - - ${pkgs.quartus-prime-standard}"
  ];

  networking = {
    dhcpcd = {
      denyInterfaces = [ "cni0" "flannel*" "veth*" ];
      # TODO: handle other interfaces (if ever connected to LAN)
      runHook = ''
        ip=${pkgs.iproute2}/bin/ip
        if [[ "$interface" = "enp6s0" && "$if_up"   = "true" ]]; then $ip rule add    to 192.168.1.0/24 priority 2500 lookup main; fi
        if [[ "$interface" = "enp6s0" && "$if_down" = "true" ]]; then $ip rule delete to 192.168.1.0/24 priority 2500 lookup main; fi
      '';
    };
    hostName = "nas";
    useDHCP = true;
  };
  system.stateVersion = "24.05";
}
