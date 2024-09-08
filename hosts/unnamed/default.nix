{
  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/optional/tailscale.nix
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
