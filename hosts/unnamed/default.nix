{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/optional/nginx.nix
    ../common/optional/tailscale.nix
    ../common/optional/zfs.nix
    ../common/users/natan

    ./services
  ];

  networking = {
    dhcpcd = {
      denyInterfaces = [ "cni0" "flannel*" "veth*" ];
      runHook = ''
        ip=${pkgs.iproute2}/bin/ip
        if [[ "$interface" = "enp1s0f0" && "$if_up"   = "true" ]]; then $ip rule add    to 192.168.1.0/24 priority 2500 lookup main; fi
        if [[ "$interface" = "enp1s0f0" && "$if_down" = "true" ]]; then $ip rule delete to 192.168.1.0/24 priority 2500 lookup main; fi
      '';
    };
    hostName = "unnamed";
    useDHCP = true;
    wireless.iwd.enable = true;
  };
  system.stateVersion = "23.11";
}
