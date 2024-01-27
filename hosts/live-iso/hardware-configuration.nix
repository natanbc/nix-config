{
  nixpkgs.hostPlatform = "x86_64-linux";
  # Breaks boot at least on ventoy
  #hardware.cpu.amd.updateMicrocode = true;
  #hardware.cpu.intel.updateMicrocode = true;
}

