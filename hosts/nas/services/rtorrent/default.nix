{ config, ... }: {
  imports = [ ./nginx.nix ];

  services.rtorrent = {
    enable = true;
    downloadDir = config.fileSystems."/mnt/scratch".mountPoint + "/rtorrent";
    openFirewall = false;
  };

  services.rutorrent = {
    enable = true;
    hostName = "rtorrent.natanbc.net";
    nginx.enable = true;
    plugins = [ "httprpc" "create" "data" "diskspace" "edit" "erasedata" "theme" "trafic" ];
  };
}
