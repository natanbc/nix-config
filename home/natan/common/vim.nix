{
  programs.vim = {
    enable = true;
    settings = {
      expandtab = true;
      number = true;
      relativenumber = true;
      shiftwidth = 4;
      tabstop = 4;
    };
    extraConfig = ''
    " Start in insert mode
    au BufRead,BufNewFile * startinsert

    " Make ;x ;X :X aliases of :x
    cnoremap X x
    nnoremap ; :
    '';
  };
}

