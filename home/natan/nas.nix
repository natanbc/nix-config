{ pkgs, ... }:
{
  imports = [ ./common ];

  home.packages = with pkgs; [
    mstflint-connectx3
    perftest
  ];
}
