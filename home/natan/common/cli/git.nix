{
  programs.git = {
    enable = true;
    extraConfig = {
      color.ui = "auto";
      push.default = "current";
      init.defaultBranch = "master";
    };
    userName = "natanbc";
    userEmail = "natanbc@users.noreply.github.com";
    ignores = [ ".*.swp" "result" ".direnv/*"];
  };
}

