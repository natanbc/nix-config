{
  boot.kernelParams = [
    "mlx4_core.num_vfs=4,4,0"
    "mlx4_core.probe_vf=4,4,0"
    "mlx4_core.port_type_array=2,2"
    "pci=realloc=on"
    "intel_iommu=on"
    "vfio-pci.ids=15b3:1004"
  ];

  boot.initrd.kernelModules = [
    "vfio_pci"
    "vfio"
    "vfio_iommu_type1"
  ];
}
