{...}: {
  programs = {
    nixvim = {
      plugins = {
        lsp = {
          servers = {
            html = {
              enable = true;
              extraOptions = {};
              filetypes = [
                "typescript"
                "html"
                "typescriptreact"
                "typescript.tsx"
              ];
            };
          };
        };
      };
    };
  };
}
