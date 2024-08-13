{
  services.tailscale = {
    enable = true;
    extraSetFlags = ["--advertise-exit-node"];
    openFirewall = true;
    useRoutingFeatures = "both";
  };
}
