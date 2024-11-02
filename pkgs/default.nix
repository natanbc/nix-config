{ pkgs ? import <nixpkgs> {} }:
{
  alist              = pkgs.callPackage ./alist {};
  gokapi             = pkgs.callPackage ./gokapi {};
  hoshinova          = pkgs.callPackage ./hoshinova {};
  mstflint-connectx3 = pkgs.callPackage ./mstflint-connectx3 {};
  perftest           = pkgs.callPackage ./perftest {};
  tunrotate          = pkgs.callPackage ./tunrotate {};
  ytarchive          = pkgs.callPackage ./ytarchive {};
}

