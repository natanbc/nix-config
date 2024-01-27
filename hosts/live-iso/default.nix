{ inputs, pkgs, ... }:
{
  imports = [
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"

    ../common/global
  ];

  networking = {
    hostName = "live-iso";
    useDHCP = true;
  };
  system.stateVersion = "23.11";
  nixpkgs.hostPlatform = "x86_64-linux";

  environment.systemPackages = with pkgs; [
    file
    gparted
    htop
    iperf
    mtr
    neofetch
    nload
    pv
    tcpdump
    tmux
    tree
    vim
  ];

  services.logind = {
    lidSwitch = "ignore";
    lidSwitchDocked = "ignore";
    lidSwitchExternalPower = "ignore";
  };

  services.xserver = {
    enable = true;
    autorun = false;
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };

  nix = {
    settings.auto-optimise-store = false;
    gc.automatic = false;
  };
}

