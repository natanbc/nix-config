{
  home.shellAliases = {
    "vim" = "hx";
  };

  programs.helix = {
    enable = true;

    defaultEditor = true;
    settings = let
      move_keys = {
        "C-r"     = "redo";
        "C-right" = [ "move_next_word_start" "move_char_right" "collapse_selection" ];
        "C-left"  = [ "move_prev_word_start"                   "collapse_selection" ];
        "C-down"  = "move_line_down";
        "C-up"    = "move_line_up";
      };
    in {
      keys.normal = move_keys // {
       "backspace" = [ "move_char_left" "delete_selection" ];
       "ins"       = "insert_mode";

        ";" = {
          "w" = ":w";
          "q" = {
            ret = ":q";
            "!" = {
              ret = ":q!";
            };
          };
          "x" = {
            ret = ":x";
          };
        };
        "d" = {
          "d"    = ["extend_to_line_bounds" "yank_main_selection_to_clipboard" "delete_selection"];
          "down" = ["select_mode" "extend_to_line_bounds" "extend_line_below" "yank_main_selection_to_clipboard" "delete_selection" "normal_mode"];
          "up"   = ["select_mode" "extend_to_line_bounds" "extend_line_above" "yank_main_selection_to_clipboard" "delete_selection" "normal_mode"];
        };
        "y" = {
          "y"    = ["extend_to_line_bounds" "yank_main_selection_to_clipboard" "normal_mode" "collapse_selection"];
          "down" = ["select_mode" "extend_to_line_bounds" "extend_line_below" "yank_main_selection_to_clipboard" "collapse_selection" "normal_mode"];
          "up"   = ["select_mode" "extend_to_line_bounds" "extend_line_above" "yank_main_selection_to_clipboard" "collapse_selection" "normal_mode"];

        };
      };
      keys.insert = move_keys;
    };
  };
}
