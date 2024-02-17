{config,...}: {
  
  programs = {
    nixvim = {
      options = {
        shiftwidth = 2;
        tabstop = 2;
        scrolloff = 8;
        undodir = "${config.xdg.dataHome}/nvim/undo";
        undofile = true;
        expandtab = true;
      };
    };
  };
}
