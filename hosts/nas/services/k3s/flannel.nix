{ pkgs, ... }:
let
  clusterCIDR = "10.208.0.0/12";
  serviceCIDR = "10.224.0.0/12";
  subnetLen = 22;

  json = pkgs.formats.json {};
  path = json.generate "flannel-conf.json" {
    EnableIPv4 = true;
    EnableIPv6 = false;
    Network = clusterCIDR;
    IPv6Network = "::/0";
    SubnetLen = subnetLen; # up to 1024 pods/node
    Backend = {
      Type = "vxlan";
    };
  };
in
{
  services.k3s.flags = [
    "--flannel-conf"
    "${path}"
    "--cluster-cidr"
    clusterCIDR
    "--service-cidr"
    serviceCIDR
    "--kube-controller-manager-arg=node-cidr-mask-size=${toString subnetLen}"
  ];
  services.tailscale.advertiseSubnets = [ clusterCIDR serviceCIDR ];
}
