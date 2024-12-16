{ pkgs ? import <nixpkgs> {} }:
pkgs.lib.makeScope pkgs.newScope (self: {
  hoshinova                        = self.callPackage ./hoshinova {};
  jtag-quartus-ft232h              = self.callPackage ./jtag-quartus-ft232h {};
  mstflint-connectx3               = self.callPackage ./mstflint-connectx3 {};
  perftest                         = self.callPackage ./perftest {};
  quartus-prime-standard-unwrapped = self.callPackage ./quartus-prime-standard-unwrapped {
    withQuesta = false;
    supportedDevices = [ "Stratix V" ];
  };
  quartus-prime-standard           = self.callPackage ./quartus-prime-standard {
    withQuesta = false;
    supportedDevices = [ "Stratix V" ];
  };
  sv_second_pcie_hip               = self.callPackage ./sv_second_pcie_hip {};
  tunrotate                        = self.callPackage ./tunrotate {};
  ytarchive                        = self.callPackage ./ytarchive {};
})

