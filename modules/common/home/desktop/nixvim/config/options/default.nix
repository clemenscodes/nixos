{config, ...}: {
  programs = {
    nixvim = {
      options = {
        shiftwidth = 2;
        tabstop = 2;
        scrolloff = 8;
        smartcase = true;
        ignorecase = true;
        number = true;
        undodir = "${config.xdg.dataHome}/nvim/undo";
        signcolumn = "yes";
        wrap = false;
        undofile = true;
        expandtab = true;
        updatetime = 200;
        hlsearch = true;
        virtualedit = "block";
        termguicolors = true;
      };
    };
  };
}
