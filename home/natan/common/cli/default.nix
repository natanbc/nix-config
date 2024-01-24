{ nixosConfig, inputs, pkgs, ... }:
let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
  };

  hwPackages = with pkgs; [
    dmidecode
    efibootmgr
    efivar
    ethtool
    hdparm
    lm_sensors
    pciutils
    smartmontools
    sysstat
    usbutils
  ];
in
{
  imports = [
    ./direnv.nix
    ./git.nix
    ./htop.nix
    ./vim.nix
    ./zsh.nix
  ];

  programs.bat.enable = true;

  home.packages = with pkgs; [
    curl
    dig
    ffmpeg
    file
    iperf
    jq
    killall
    mediainfo
    mtr
    ncdu_2
    neofetch
    nload
    parallel
    pv
    ripgrep
    socat
    strace
    tcpdump
    tmux
    tree
    unar
    wget
    unstable.yt-dlp
    zip
  ] ++ (if !nixosConfig.boot.isContainer then hwPackages else []);
}

