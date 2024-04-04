{...}: {
  programs = {
    nixvim = {
      plugins = {
        lsp = {
          servers = {
            texlab = {
              enable = true;
              extraOptions = {};
            };
          };
        };
      };
    };
  };
}
