{ fetchFromGitHub, fetchpatch, mstflint, lib }:

(mstflint.override { enableDPA = false; }).overrideAttrs rec {
  version = "4.25.0-1";

  src = fetchFromGitHub {
    owner = "Mellanox";
    repo = "mstflint";
    rev = "v${version}";
    sha256 = "sha256-D1bw+VwPEbFPl+ejNn2CbX0A5RfWBPPqkjzKInaf2C0=";
    leaveDotGit = true;
  };

  patches = [
    ./mlxlink-build-fix.patch
  ];
}
