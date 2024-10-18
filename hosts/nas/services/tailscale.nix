{ ... }:
{
  services.tailscale = {
    advertiseExitNode = true;
    advertiseSubnets = ["192.168.0.0/23" "192.168.128.0/24"];
  };
}
