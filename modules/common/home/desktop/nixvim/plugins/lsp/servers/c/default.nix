{...}: {
  programs = {
    nixvim = {
      plugins = {
        clangd-extensions = {
          enable = true;
          enableOffsetEncodingWorkaround = true;
        };
        lsp = {
          servers = {
            clangd = {
              enable = true;
              extraOptions = {};
            };
          };
        };
      };
    };
  };
}
