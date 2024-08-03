{ stdenv, fetchFromGitHub, libtool, automake, autoconf, rdma-core, pciutils, ... }:
stdenv.mkDerivation rec {
  pname = "perftest";
  version = "24.04.0-0.41";

  src = fetchFromGitHub {
    owner = "linux-rdma";
    repo = "${pname}";
    rev = "${version}";
    hash = "sha256-azhB8BDtEpPxOPSTW+iOLF2IQbTgUgIjYWdv987dhvc=";
  };

  nativeBuildInputs = [
    libtool
    automake
    autoconf
  ];

  buildInputs = [
    rdma-core.dev
    pciutils
  ];

  configurePhase = ''
    ./autogen.sh
    ./configure --prefix $out
  '';
}
