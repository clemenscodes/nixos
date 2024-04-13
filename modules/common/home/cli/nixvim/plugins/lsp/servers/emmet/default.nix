{...}: {
  programs = {
    nixvim = {
      plugins = {
        lsp = {
          servers = {
            emmet_ls = {
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
