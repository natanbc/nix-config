{ buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "gokapi";
  version = "1.9.2";

  src = fetchFromGitHub {
    owner = "Forceu";
    repo = "Gokapi";
    rev = "v${version}";
    hash = "sha256-IeFInBzgKnAkwlktpAYKxcEvZxQFwC1QRLILgHjUNTs=";
  };

  patches = [
    ./vendor-tool-deps.patch
  ];

  vendorHash = "sha256-Pf00sM3zNAB2Pbr29clzGejPkj3wyTgz+BwvSIZTNO0=";

  subPackages = [
    "cmd/gokapi"
  ];

  preBuild = ''
    go generate ./...
  '';
}
