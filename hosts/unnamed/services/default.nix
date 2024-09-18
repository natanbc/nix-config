{
  imports = [
    ./cloudflared
    ./docker-registry
    ./k3s
  ];

  age.secrets.cloudflare-dns-token.file = ./cloudflare-dns-token.age;
}
