{ stdenv, fetchFromGitHub, libtool, automake, autoconf, rdma-core, pciutils, ... }:
stdenv.mkDerivation rec {
  pname = "perftest";
  version = "24.07.0-0.44";

  src = fetchFromGitHub {
    owner = "linux-rdma";
    repo = "${pname}";
    rev = "${version}";
    hash = "sha256-Z/DLa3wrZRrceX+Y1cuo6ppythe3qfqXofKN+9IHpv0=";
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
