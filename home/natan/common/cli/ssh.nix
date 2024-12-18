{
  programs.ssh = {
    enable = true;
    compression = true;
    controlMaster = "auto";
    controlPath = "~/.ssh/.socket-%r@%n:%p";
    controlPersist = "1h";
    serverAliveInterval = 30;
    serverAliveCountMax = 10;

    extraConfig = "TCPKeepAlive yes";
  };
}
