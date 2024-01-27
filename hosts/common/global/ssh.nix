{
  users.users.root.openssh.authorizedKeys.keys = (import ../sshkeys.nix).root;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "prohibit-password";
    };    
  };

  security.pam.enableSSHAgentAuth = true;
}
