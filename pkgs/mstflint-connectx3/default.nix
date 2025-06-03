{ fetchFromGitHub, pkgs }:

(pkgs.callPackage ./mstflint-nixpkgs-24.11.nix { enableDPA = false; }).overrideAttrs rec {
  pname = "mstflint-connectx3";
  version = "4.25.0-1";

  src = fetchFromGitHub {
    owner = "Mellanox";
    repo = "mstflint";
    rev = "v${version}";
    sha256 = "sha256-4eN8L3LTCXZCdNt112fZRtUnxyNdiWav+m+HKbBt5Co=";
    leaveDotGit = true;
  };

  patches = [
    ./0001-Add-stdlib-include.patch
  ];

  configureFlags = [
    "--enable-xml2"
    "--datarootdir=${placeholder "out"}/share"
    "--enable-cs"
    "--enable-dc"
    "--enable-fw-mgr"
    "--enable-inband"
    "--enable-rdmem"
  ];

  enableParallelBuilding = false;
}
