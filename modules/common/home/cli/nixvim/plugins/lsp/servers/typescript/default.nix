{...}: {
  programs = {
    nixvim = {
      plugins = {
        lsp = {
          servers = {
            tsserver = {
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
