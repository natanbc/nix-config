{ pkgs ? import <nixpkgs> {} }:
{
  tunrotate = pkgs.callPackage ./tunrotate {};
}

