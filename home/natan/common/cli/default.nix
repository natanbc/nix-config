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
in
{
  imports = [
    ./direnv.nix
    ./git.nix
    ./htop.nix
    ./ssh.nix
    ./vim.nix
    ./zsh.nix
  ];

  programs.bat.enable = true;

  home.packages = with pkgs; [
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
    parallel
    pv
    ripgrep
    rsync
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

