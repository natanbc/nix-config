{
  imports = [
    ./cloudflared
    ./dnsmasq.nix
    ./docker-registry
    ./forgejo
    ./garage
    #./k3s
    ./kanidm
    ./oauth2-proxy
    ./rtorrent
    ./samba.nix
    ./tailscale.nix
  ];

  age.secrets.cloudflare-dns-token.file = ./cloudflare-dns-token.age;
}
