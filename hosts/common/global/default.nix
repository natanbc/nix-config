{
  imports = [
    ./nix.nix
    ./ssh.nix
    ./zsh.nix
  ];

  boot.tmp.cleanOnBoot = true;
  boot.tmp.useTmpfs = true;

  hardware.enableRedistributableFirmware = true;
  hardware.wirelessRegulatoryDatabase = true;
}

