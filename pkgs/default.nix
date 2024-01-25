{ pkgs ? import <nixpkgs> {} }:
{
  hoshinova = pkgs.callPackage ./hoshinova {};
  tunrotate = pkgs.callPackage ./tunrotate {};
  ytarchive = pkgs.callPackage ./ytarchive {};
}

