{ outputs, ... }:
{
  imports = [
    ./cli
  ];

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
  };

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  home = {
    username = "natan";
    homeDirectory = "/home/natan";
    stateVersion = "23.11";
    sessionPath = [ "$HOME/.local/bin" ];
  };
}
