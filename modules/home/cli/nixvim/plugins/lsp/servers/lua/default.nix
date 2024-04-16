{...}: {
  programs = {
    nixvim = {
      plugins = {
        lsp = {
          servers = {
            lua-ls = {
              enable = true;
              extraOptions = {};
            };
          };
        };
      };
    };
  };
}
