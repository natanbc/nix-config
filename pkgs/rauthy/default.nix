{
  lib,
  fetchFromGitHub,
  rustPlatform,
  openssl,
  perl,
  pkg-config,
  rocksdb
}:
rustPlatform.buildRustPackage rec {
  pname = "rauthy";
  version = "0.29.4";

  src = fetchFromGitHub {
    owner = "sebadob";
    repo = "rauthy";
    tag = "v${version}";
    hash = "sha256-+k5t4CTVFFmWKoCdkN2t4jK/uDI+HcM6LuButdUzBa4=";
  };


  cargoHash = "sha256-l/rByM1QxBY4mTXKtR9bKaL+xrHmLluxKOUuyR1moek=";

  cargoPatches = [
    ./0001-enable-vendored-feature-for-utoipa-swagger-ui.patch
    ./0002-speed-up-build.patch
  ];

  ROCKSDB_INCLUDE_DIR = "${rocksdb}/include";
  ROCKSDB_LIB_DIR = "${rocksdb}/lib";

  nativeBuildInputs = [
    perl
    pkg-config
    rustPlatform.bindgenHook
  ];

  buildInputs = [
    openssl
  ];

  doCheck = false;

  meta = {
    description = "OpenID Connect Single Sign-On Identity & Access Management";
    homepage = "https://sebadob.github.io/rauthy/";
    license = lib.licenses.asl20;
    maintainers = [ ];
  };
}
