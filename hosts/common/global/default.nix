{
  imports = [
    ./nix.nix
    ./ssh.nix
    ./zsh.nix
  ];

  hardware.enableRedistributableFirmware = true;
  hardware.wirelessRegulatoryDatabase = true;
}

