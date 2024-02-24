{...}: {
  programs = {
    nixvim = {
      plugins = {
        lsp = {
          servers = {
             ccls = {
              enable = true;
              extraOptions = {};
            };
          };
        };
      };
    };
  };
}
