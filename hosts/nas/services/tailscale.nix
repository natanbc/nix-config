{ ... }:
{
  services.tailscale = {
    extraSetFlags = ["--advertise-exit-node" "--advertise-routes=192.168.0.0/23"];
    useRoutingFeatures = "both";
  };
}
