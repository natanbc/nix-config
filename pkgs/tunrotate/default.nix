{ buildGo121Module, fetchFromGitHub }:

buildGo121Module rec {
    pname = "tunrotate";
    version = "04281a0";

    src = fetchFromGitHub {
        owner = "natanbc";
        repo = "${pname}";
        rev = "04281a0ca1fb15d2c376d9fc0beaab3f09c90da9";
        hash = "sha256-p7JWN2gTgfoTCIg80F/mW7O1jQgDm64dxTppSTaMxQE=";
    };

    vendorHash = "sha256-QNnZy/1zCN99LNgB/pyuj61S8C9Kt7QgTZZi+kRBD/M=";

    postBuild = ''
      cc -O1 tunhelper/tunhelper.c -o tunhelper/tunhelper
    '';
    postInstall = ''
      mkdir -p $out/bin
      cp tunhelper/tunhelper $out/bin/tunhelper
    '';
}

