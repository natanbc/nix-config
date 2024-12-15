{ stdenv
, cmake
, fetchFromGitHub
, gnumake
, jimtcl
, libftdi1
, libusb1
, pkg-config
, ...
}:
stdenv.mkDerivation {
  name = "jtag-quartus-ft232h";
  version = "b32ebb4";

  src = fetchFromGitHub {
    owner = "j-marjanovic";
    repo = "jtag-quartus-ft232h";
    rev = "b32ebb43c99876d626993135eecd892d43d1b93f";
    hash = "sha256-lX24TvBjcgGdxdYWDf91piC/Nx1O/ZiL4Jm29KnAVnA=";
  };

  patches = [ ./jtag-quartus-ft232h-pkg-config.patch ];

  nativeBuildInputs = [ cmake gnumake jimtcl pkg-config ];

  buildInputs = [ libftdi1 libusb1 ];

  installPhase = ''
    mkdir -p $out/quartus/linux64
    cp -a libjtag_hw_otma.so $out/quartus/linux64
  '';
}
