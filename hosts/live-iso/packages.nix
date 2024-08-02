{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    dmidecode
    dnsmasq
    efibootmgr
    efivar
    ethtool
    file
    gparted
    hdparm
    htop
    iperf
    killall
    lm_sensors
    mstflint-connectx3
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

