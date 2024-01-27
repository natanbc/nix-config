{
  services.logind = {
    lidSwitch = "ignore";
    lidSwitchDocked = "ignore";
    lidSwitchExternalPower = "ignore";
  };

  services.xserver = {
    enable = true;
    autorun = false;
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };
}

