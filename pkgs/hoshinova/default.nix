{ fetchFromGitHub, fetchYarnDeps, git, mkYarnPackage, rustPlatform, ... }:
let
  pname = "hoshinova";
  version = "f97c92c";
  src = fetchFromGitHub {
    owner = "HoloArchivists";
    repo = "${pname}";
    rev = "f97c92c0932bc7bd2041ae80ae2db34839a66941";
    sha256 = "sha256-CTmYF7arldVe1kR2+PtIMBHV5zA/EAcjwRGW08eMVFU=";
    leaveDotGit = true;
  };

  frontend-build = mkYarnPackage {
    inherit version;

    pname = "hoshinova-frontend";
    src = "${src}/web";

    offlineCache = fetchYarnDeps {
      yarnLock = "${src}/web/yarn.lock";
      sha256 = "sha256-DJpJJ6SuLxb6rsR+PFBLY4zsf2zws75pQEjyO/P+/lw=";
    };

    packageJSON = "${src}/web/package.json";

    postUnpack = ''
      mkdir web/src/bindings
      cp ${./bindings}/* web/src/bindings
    '';

    buildPhase = "yarn --offline build";
    distPhase = "true";
    installPhase = ''
      cp -r deps/web/dist $out
    '';
  };
in
rustPlatform.buildRustPackage {
  inherit pname src version;

  cargoSha256 = "sha256-psrZKcbPTpahOfUDqEJg6GgXTQRpnKwKadH1nourKh0=";

  nativeBuildInputs = [ git ];

  patches = [ ./no-lto.patch ];

  postPatch = ''
    cp -R ${frontend-build} web/dist/
  '';
}

