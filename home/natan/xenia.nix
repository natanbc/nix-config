{ inputs, pkgs, ... }:
let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
  };
in
{
  imports = [ ./common ];

  home.packages = [ unstable.openfpgaloader ];
}
