{ ... }:
{
  boot.kernelParams = [ "ip=dhcp" ];
  boot.initrd = {
    availableKernelModules = [ "mlx4_en" "r8169" ];
    network = {
      enable = true;
      ssh = {
        enable = true;
        port = 22;
        authorizedKeys = (import ../common/sshkeys.nix).root;
        hostKeys = [
          "/etc/secrets/initrd/ssh_host_ed25519_key"
          "/etc/secrets/initrd/ssh_host_rsa_key"
        ];
      };
    };
  };
}
