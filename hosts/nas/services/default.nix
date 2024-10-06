{
  imports = [
    ./cloudflared
    ./dnsmasq.nix
    ./garage
    ./k3s
    ./samba.nix
    ./tailscale.nix
  ];

  age.secrets.cloudflare-dns-token.file = ./cloudflare-dns-token.age;
}
