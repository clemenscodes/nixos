{...}: {
  programs = {
    nixvim = {
      plugins = {
        lsp = {
          servers = {
            eslint = {
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
