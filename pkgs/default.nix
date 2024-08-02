{ pkgs ? import <nixpkgs> {} }:
{
  hoshinova    = pkgs.callPackage ./hoshinova {};
  mstflint-425 = pkgs.callPackage ./mstflint-425 {};
  tunrotate    = pkgs.callPackage ./tunrotate {};
  ytarchive    = pkgs.callPackage ./ytarchive {};
}

