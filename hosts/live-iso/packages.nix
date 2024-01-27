{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    dmidecode
    efibootmgr
    efivar
    ethtool
    file
    gparted
    hdparm
    htop
    iperf
    lm_sensors
    mtr
    neofetch
    nload
    pciutils
    pv
    smartmontools
    sysstat
    tcpdump
    tmux
    tree
    usbutils
    vim
  ];
}

