{ pkgs ? import <nixpkgs> {} }:
{
  hoshinova                        = pkgs.callPackage ./hoshinova {};
  mstflint-connectx3               = pkgs.callPackage ./mstflint-connectx3 {};
  perftest                         = pkgs.callPackage ./perftest {};
  quartus-prime-standard-unwrapped = pkgs.callPackage ./quartus-prime-standard-unwrapped {
    withQuesta = false;
    supportedDevices = [ "Stratix V" ];
  };
  quartus-prime-standard           = pkgs.callPackage ./quartus-prime-standard {
    withQuesta = false;
    supportedDevices = [ "Stratix V" ];
  };
  tunrotate                        = pkgs.callPackage ./tunrotate {};
  ytarchive                        = pkgs.callPackage ./ytarchive {};
}

