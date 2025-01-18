# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  age.secrets = {
    luks-key-scratch.file = ./luks-key-scratch.age;
    zfs-key-tank.file = ./zfs-key-tank.age;
  };

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  # Does not automatically load because of a resource conflict, but this ensures the module is available.
  # To load manually, use `modprobe it87 ignore_resource_conflict`
  boot.extraModulePackages = [ config.boot.kernelPackages.it87 ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices = {
    "luks-rpool-6a28a049-626a-4122-a68e-a6c9a94cb569" = {
      allowDiscards = true;
      crypttabExtraOpts = [ "tpm2-device=auto" "tpm2-measure-pcr=yes" ];
      device = "/dev/disk/by-uuid/6a28a049-626a-4122-a68e-a6c9a94cb569";
    };
  };

  environment.etc.crypttab.text = ''
    scratch UUID=e73bb99d-e337-48d1-a2b9-ad1eee0dc491 ${config.age.secrets.luks-key-scratch.path}
  '';

  fileSystems."/" =
    { device = "rpool/safe/root";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "rpool/safe/home";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    { device = "rpool/local/nix";
      fsType = "zfs";
    };

  fileSystems."/var/log" =
    { device = "rpool/local/log";
      fsType = "zfs";
    };

  fileSystems."/var/lib/kubelet" =
    { device = "rpool/local/kubelet";
      fsType = "zfs";
    };

  fileSystems."/var/lib/rancher/k3s/agent/containerd" =
    { device = "rpool/local/k3s-containerd";
      fsType = "zfs";
    };

  fileSystems."/var/lib/rancher/k3s/server/db" =
    { device = "rpool/safe/k3s-db";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/D7F2-5F0E";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  fileSystems."/data" =
    { device = "tank/data";
      fsType = "zfs";
    };

  fileSystems."/mnt/garage" =
    { device = "tank/garage";
      fsType = "zfs";
    };

  fileSystems."/mnt/scratch" =
    { device = "scratch/scratch";
      fsType = "zfs";
    };

  fileSystems."/opt/local-path-provisioner" =
    { device = "scratch/local-path-provisioner";
      fsType = "zfs";
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
