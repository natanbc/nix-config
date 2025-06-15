{
  imports = [
    ./cloudflared
    ./dnsmasq.nix
    ./docker-registry
    ./garage
    #./k3s
    ./kanidm
    ./rtorrent
    ./samba.nix
    ./tailscale.nix
  ];

  age.secrets.cloudflare-dns-token.file = ./cloudflare-dns-token.age;
}
