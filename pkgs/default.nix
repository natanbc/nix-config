{ pkgs ? import <nixpkgs> {} }:
{
  hoshinova          = pkgs.callPackage ./hoshinova {};
  mstflint-connectx3 = pkgs.callPackage ./mstflint-connectx3 {};
  tunrotate          = pkgs.callPackage ./tunrotate {};
  ytarchive          = pkgs.callPackage ./ytarchive {};
}

