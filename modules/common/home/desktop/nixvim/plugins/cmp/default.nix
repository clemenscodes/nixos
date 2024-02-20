{...}: {
  programs = {
    nixvim = {
      plugins = {
        cmp_luasnip = {
          enable = true;
        };
        cmp-nvim-lsp = {
          enable = true;
        };
        cmp-nvim-lsp-document-symbol = {
          enable = true;
        };
        cmp-nvim-lsp-signature-help = {
          enable = true;
        };
        cmp-nvim-lua = {
          enable = true;
        };
        cmp-tmux = {
          enable = true;
        };
        cmp-path = {
          enable = true;
        };
        cmp-npm = {
          enable = true;
        };
      };
    };
  };
}
