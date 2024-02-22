{...}: {
  programs = {
    nixvim = {
      plugins = {
        lsp = {
          servers = {
             cmake = {
              enable = true;
              extraOptions = {};
            };
          };
        };
      };
    };
  };
}
