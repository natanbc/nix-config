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
    hostName = "unnamed";
    useDHCP = true;
    wireless.iwd.enable = true;
  };
  system.stateVersion = "23.11";
}
