{
  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/users/natan

    ./remote-disk-unlock.nix
  ];

  networking = {
    hostName = "nas";
    useDHCP = true;
  };
  system.stateVersion = "24.05";
}
