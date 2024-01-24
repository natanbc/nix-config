{
  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/users/natan
  ];

  networking = {
    hostName = "unnamed";
    useDHCP = true;
  };
  system.stateVersion = "23.11";
}
