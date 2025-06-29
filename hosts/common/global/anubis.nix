{
  services.anubis.defaultOptions = {
    settings = {
      OG_PASSTHROUGH = true;
      OG_EXPIRY_TIME = "1h";
      # Default to one anubis instance per domain
      OG_CACHE_CONSIDER_HOST = false;

      # Allow everyone to access the anubis socket
      SOCKET_MODE = "0666";
    };
  };
}
