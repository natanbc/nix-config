final: prev:
{
  hantek6022api                    = final.callPackage ./hantek6022api {};
  hoshinova                        = final.callPackage ./hoshinova {};
  jtag-quartus-ft232h              = final.callPackage ./jtag-quartus-ft232h {};
  mstflint-connectx3               = final.callPackage ./mstflint-connectx3 {};
  perftest                         = final.callPackage ./perftest {};
  quartus-prime-standard-unwrapped = final.callPackage ./quartus-prime-standard-unwrapped {
    withQuesta = false;
    supportedDevices = [ "Stratix V" ];
  };
  quartus-prime-standard           = final.callPackage ./quartus-prime-standard {
    withQuesta = false;
    supportedDevices = [ "Stratix V" ];
  };
  rauthy                           = final.callPackage ./rauthy {};
  sv_second_pcie_hip               = final.callPackage ./sv_second_pcie_hip {};
  tunrotate                        = final.callPackage ./tunrotate {};
  ytarchive                        = final.callPackage ./ytarchive {};
}

