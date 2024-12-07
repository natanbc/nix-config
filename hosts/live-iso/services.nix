{
  services.logind = {
    lidSwitch = "ignore";
    lidSwitchDocked = "ignore";
    lidSwitchExternalPower = "ignore";
  };
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="tty", KERNEL=="ttyACM*", ENV{SYSTEMD_WANTS}+="serial-getty@%k.service"
    ACTION=="add", SUBSYSTEM=="tty", KERNEL=="ttyUSB*", ENV{SYSTEMD_WANTS}+="serial-getty@%k.service"
  '';

  networking.firewall.enable = false;

}

