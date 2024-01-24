{
  programs.zsh = {
    enable = true;

    autocd = true;
    history = {
      extended = true;
      save = 100000;
      size = 100000;
    };
    initExtra = "autoload zmv";
    sessionVariables = {
      LESS = "-R -Q";
      TIMER_FORMAT = "# %d";
      TIMER_THRESHOLD = "3";
    };
    shellAliases = {
      cat = "bat";
    };

    oh-my-zsh = {
      enable = true;

      plugins = [ "timer" ];
    };
  };
}
