{
  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/users/natan

    ./lanzaboote.nix
    ./remote-disk-unlock.nix
  ];

  networking = {
    hostName = "nas";
    useDHCP = true;
  };
  system.stateVersion = "24.05";
}
