{
  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/users/natan
  ];

  networking = {
    hostName = "nas";
    useDHCP = true;
  };
  system.stateVersion = "24.05";
}
