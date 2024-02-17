{...}: {
  programs = {
    nixvim = {
      plugins = {
        cmp-nvim-lsp = {
          enable = true;
        };
      };
    };
  };
}
