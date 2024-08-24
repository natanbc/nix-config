# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

let
  it87-frankcrawford = config.boot.kernelPackages.callPackage ../../pkgs/it87-frankcrawford {};
in
{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ it87-frankcrawford ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices = {
    "luks-rpool-6a28a049-626a-4122-a68e-a6c9a94cb569".device = "/dev/disk/by-uuid/6a28a049-626a-4122-a68e-a6c9a94cb569";
  };

  fileSystems."/" =
    { device = "rpool/safe/root";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "rpool/safe/home";
      fsType = "zfs";
    };

  fileSystems."/home/nix" =
    { device = "rpool/local/nix";
      fsType = "zfs";
    };

  fileSystems."/home/var/log" =
    { device = "rpool/local/log";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/D7F2-5F0E";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp1s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp1s0d1.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp4s0.useDHCP = lib.mkDefault true;
  networking.hostId = "4fbf7f4e";

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
