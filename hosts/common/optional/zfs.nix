{
  services.zfs = {
    autoScrub = {
      enable = true;
      interval = "monthly";
    };

    autoSnapshot = {
      enable = true;
      flags = "-k -p --utc";
      # 15 min
      frequent = 8;
      hourly = 48;
      daily = 14;
      weekly = 8;
      monthly = 24;
    };
  };
}
