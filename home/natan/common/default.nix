{ nixosConfig, inputs, outputs, pkgs, ... }:
{
  imports = [
    ./direnv.nix
    ./git.nix
    ./helix.nix
    ./htop.nix
    ./ssh.nix
    ./vim.nix
    ./zsh.nix
  ];

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
  };

  programs = {
    bat.enable = true;
    dircolors.enable = true;
    git.enable = true;
    home-manager.enable = true;
    jujutsu.enable = true;
  };

  home = {
    username = "natan";
    homeDirectory = "/home/natan";
    stateVersion = "23.11";
    sessionPath = [ "$HOME/.local/bin" ];

    shellAliases = {
      "cat" = "bat";
      "cp" = "cp -a";
    };

    packages = let
      unstable = import inputs.nixpkgs-unstable {
        system = pkgs.system;
        overlays = builtins.attrValues outputs.overlays;
      };
      unstable-small = import inputs.nixpkgs-unstable-small {
        system = pkgs.system;
        overlays = builtins.attrValues outputs.overlays;
      };

      hwPackages = with pkgs; [
        dmidecode
        efibootmgr
        efivar
        ethtool
        flashrom
        hdparm
        lm_sensors
        nvme-cli
        pciutils
        sg3_utils
        smartmontools
        sysstat
        usbtop
        usbutils
      ];
    in with pkgs; [
      aria2
      curl
      dig
      fastfetch
      ffmpeg
      file
      iperf
      jq
      killall
      mediainfo
      mtr
      ncdu_2
      nload
      openssl # needed for transcrypt
      parallel
      pv
      ripgrep
      rsync
      socat
      strace
      tcpdump
      tmux
      transcrypt
      tree
      unar
      wget
      unstable-small.yt-dlp
      zip
    ] ++ (if !nixosConfig.boot.isContainer then hwPackages else []);
  };
}

