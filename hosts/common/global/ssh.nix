{ lib, ... }:
{
  users.users.root.openssh.authorizedKeys.keys = (import ../sshkeys.nix).root;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = lib.mkForce "prohibit-password";
    };    
  };

  security.pam.enableSSHAgentAuth = true;
}
