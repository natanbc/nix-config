{ pkgs, ... }:
{
  imports = [ ./common ];

  home.packages = with pkgs; [
    mstflint-connectx3
    opensm
    perftest
    rdma-core
  ];
}
