{ pkgs, ... }:

{
  services.udev.packages = with pkgs; [
    hantek6022api
  ];
}
