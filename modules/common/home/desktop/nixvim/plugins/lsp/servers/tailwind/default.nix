{...}: {
  programs = {
    nixvim = {
      plugins = {
        lsp = {
          servers = {
            tailwindcss = {
              enable = true;
              extraOptions = {};
              rootDir =
                /*
                lua
                */
                ''
                  require('lspconfig').util.root_pattern(".git")
                '';
            };
          };
        };
      };
    };
  };
}
