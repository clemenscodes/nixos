{...}: {
  programs = {
    nixvim = {
      plugins = {
        lsp = {
          servers = {
             cssls = {
              enable = true;
              extraOptions = {};
            };
          };
        };
      };
    };
  };
}
