{ fetchFromGitHub, fetchpatch, mstflint, lib }:

(mstflint.override { enableDPA = false; }).overrideAttrs rec {
  pname = "mstflint-connectx3";
  version = "4.25.0-1";

  src = fetchFromGitHub {
    owner = "Mellanox";
    repo = "mstflint";
    rev = "v${version}";
    sha256 = "sha256-D1bw+VwPEbFPl+ejNn2CbX0A5RfWBPPqkjzKInaf2C0=";
    leaveDotGit = true;
  };

  configureFlags = [
    "--enable-xml2"
    "--datarootdir=${placeholder "out"}/share"
    "--enable-cs"
    "--enable-dc"
    "--enable-fw-mgr"
    "--enable-inband"
    "--enable-rdmem"
  ];
}
