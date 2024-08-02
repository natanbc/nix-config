{
  services.logind = {
    lidSwitch = "ignore";
    lidSwitchDocked = "ignore";
    lidSwitchExternalPower = "ignore";
  };

  services.xserver = {
    enable = true;
    autorun = false;
    desktopManager.plasma5.enable = true;
  };

  services.displayManager.sddm.enable = true;
}

