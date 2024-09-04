{
  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" "sdhci_pci" ];
    };
    loader.systemd-boot.enable = true;
    kernelModules = [ "kvm-intel" ];
  };

  fileSystems."/" = {
    device = "rpool/safe/root";
    fsType = "zfs";
  };

  fileSystems."/home" = {
    device = "rpool/safe/home";
    fsType = "zfs";
  };

  fileSystems."/var" = {
    device = "rpool/safe/var";
    fsType = "zfs";
  };

  fileSystems."/var/lib/longhorn" = {
    device = "/dev/zvol/rpool/local/longhorn-data";
    fsType = "ext4";
  };

  fileSystems."/var/log" = {
    device = "rpool/local/log";
    fsType = "zfs";
  };

  fileSystems."/nix" = {
    device = "rpool/local/nix";
    fsType = "zfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/2ECB-9D33";
    fsType = "vfat";
  };

  nixpkgs.hostPlatform = "x86_64-linux";

  hardware.cpu.intel.updateMicrocode = true;

  networking.hostId = "8425e349";
}
