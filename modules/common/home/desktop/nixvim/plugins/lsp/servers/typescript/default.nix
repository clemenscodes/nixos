{...}: {
  programs = {
    nixvim = {
      plugins = {
        lsp = {
          servers = {
             tsserver = {
              enable = true;
              extraOptions = {};
            };
          };
        };
      };
    };
  };
}
