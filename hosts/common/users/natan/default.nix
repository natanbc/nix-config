{ pkgs, config, ... }:
{
  age.secrets.password-natan.file = ./password.age;

  users.users.natan = {
    uid = 1000;

    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;

    hashedPasswordFile = config.age.secrets.password-natan.path;
    openssh.authorizedKeys.keys = (import ../../sshkeys.nix).natan;
  };
}

