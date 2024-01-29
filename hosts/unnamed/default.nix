{
  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/users/natan

    ./services
  ];

  networking = {
    hostName = "unnamed";
    useDHCP = true;
  };
  system.stateVersion = "23.11";
}
