{ fetchFromGitHub
, pkg-config
, pkgs
, python3Packages
, ...
}:

python3Packages.buildPythonPackage rec {
  pname = "hantek6022api";
  version = "2.10.8";

  src = fetchFromGitHub {
    owner = "Ho-Ro";
    repo = "Hantek6022API";
    rev = version;
    sha256 = "sha256-2qjUiAVPtb9wWOu7QPxPP1QWKlMCY2sNOkNDd/hwDB8=";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ pkgs.libusb1 ];
  propagatedBuildInputs = with python3Packages; [
    libusb1
    numpy
  ];

  preBuild = ''
    make -C fx2upload
  '';
}

