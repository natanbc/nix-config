{ config, inputs, outputs, pkgs, lib, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./nix.nix
    ./nix-gc.nix
    ./ssh.nix
    ./zsh.nix
  ];
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
    nixosConfig = config;
  };

  boot.tmp.cleanOnBoot = true;
  boot.tmp.useTmpfs = true;

  environment.systemPackages = with pkgs; [
    git
  ];

  hardware.enableRedistributableFirmware = true;
  hardware.wirelessRegulatoryDatabase = true;

  networking.nftables.enable = lib.mkDefault true;

  services.fstrim.enable = lib.mkDefault (!config.boot.isContainer);
  services.fwupd.enable = lib.mkDefault (!config.boot.isContainer);
  services.irqbalance.enable = lib.mkDefault (!config.boot.isContainer);

  users.mutableUsers = lib.mkDefault false;
}

