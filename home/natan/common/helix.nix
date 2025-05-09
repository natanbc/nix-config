{
  home.shellAliases = {
    "vim" = "hx";
  };

  programs.helix = {
    enable = true;
    
    defaultEditor = true;
    settings = {
      keys.normal = {
        "C-r" = "redo";
        "C-right" = [ "move_next_word_start" "move_char_right" "collapse_selection" ];
        "C-left" =  [ "move_prev_word_start"                   "collapse_selection" ];
        "ins" = "insert_mode";
        ";"."q" = ":q";
        ";"."w" = ":w";
        ";"."x" = ":x";
      };
    };
  };
}
