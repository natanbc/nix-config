{ pkgs, ... }:
{
  imports = [
    ./nix.nix
    ./ssh.nix
    ./zsh.nix
  ];

  boot.tmp.cleanOnBoot = true;
  boot.tmp.useTmpfs = true;

  environment.systemPackages = with pkgs; [
    git
  ];

  hardware.enableRedistributableFirmware = true;
  hardware.wirelessRegulatoryDatabase = true;
}

