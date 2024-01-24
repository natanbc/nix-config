{
  imports = [
    ./nix.nix
    ./ssh.nix
  ];

  hardware.enableRedistributableFirmware = true;
  hardware.wirelessRegulatoryDatabase = true;
}
