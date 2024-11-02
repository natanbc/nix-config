{ buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "alist";
  version = "3.38.0";

  src = fetchFromGitHub {
    owner = "AlistGo";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-1nqveTEYrN9kYAOMTbLPw0MFNNNbFOqej+d+aTLAZ1o=";
  };

  vendorHash = "sha256-qSbvb2/y5rdS/OCutNEcRDUQBCAgNudux8XDnY9TRSo=";

  subPackages = [
    "."
  ];
}
