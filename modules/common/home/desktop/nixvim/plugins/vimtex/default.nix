{pkgs,...}: {
  programs = {
    nixvim = {
      plugins = {
        vimtex = {
          enable = true;
          package = pkgs.texliveFull;
          settings = {
            view_method = "zathura";
          };
        };
      };
    };
  };
}
