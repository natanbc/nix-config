{ ... }:
{
  services.tailscale = {
    extraSetFlags = ["--advertise-exit-node" "--advertise-routes=192.168.0.0/23,10.208.0.0/12,10.224.0.0/12"];
    useRoutingFeatures = "both";
  };
}
