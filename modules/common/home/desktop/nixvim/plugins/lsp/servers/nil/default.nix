{...}: {
  programs = {
    nixvim = {
      plugins = {
        lsp = {
          servers = {
            nil_ls = {
              enable = true;
              extraOptions = {};
            };
          };
        };
      };
    };
  };
}
