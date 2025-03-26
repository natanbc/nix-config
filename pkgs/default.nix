final: prev:
{
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
  sv_second_pcie_hip               = final.callPackage ./sv_second_pcie_hip {};
  tunrotate                        = final.callPackage ./tunrotate {};
  ytarchive                        = final.callPackage ./ytarchive {};
  yt-dlp                           = final.callPackage ./yt-dlp { yt-dlp = prev.yt-dlp; };
}

