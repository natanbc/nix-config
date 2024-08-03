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
    iperf2
    killall
    lm_sensors
    mstflint-connectx3
    mtr
    neofetch
    nload
    ntttcp
    opensm
    pciutils
    perftest
    pv
    rdma-core
    smartmontools
    sysstat
    tcpdump
    tmux
    tree
    usbutils
    vim
  ];
}

