{ ... }:
{
  services.tailscale = {
    extraSetFlags = ["--advertise-exit-node"];
    useRoutingFeatures = "both";
  };
}
