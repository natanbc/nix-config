{
  imports = [
    ./hardware-configuration.nix

    ../common/global
  ];

  networking = {
    hostName = "unnamed";
    useDHCP = true;
  };
  system.stateVersion = "23.11";
}
