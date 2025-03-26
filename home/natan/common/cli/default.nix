{ nixosConfig, inputs, outputs, pkgs, ... }:
let
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
  programs.jujutsu.enable = true;

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
}

