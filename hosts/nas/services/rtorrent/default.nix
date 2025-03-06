{ config, ... }: {
  imports = [ ./nginx.nix ];

  networking.firewall = {
    allowedTCPPorts = [ 50001 ];
    allowedUDPPorts = [
      config.services.rtorrent.port
      50001
    ];
  };

  services.rtorrent = {
    enable = true;
    downloadDir = config.fileSystems."/mnt/scratch".mountPoint + "/rtorrent";
    openFirewall = true;
    configText = ''
      dht.mode.set = auto
      dht.port.set = 50001
      protocol.pex.set = yes
      trackers.use_udp.set = yes
    '';
  };

  services.rutorrent = {
    enable = true;
    hostName = "rtorrent.natanbc.net";
    nginx.enable = true;
    plugins = [ "httprpc" "create" "data" "diskspace" "edit" "erasedata" "theme" "trafic" ];
  };
}
