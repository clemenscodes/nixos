{...}: {
  programs = {
    nixvim = {
      plugins = {
        lsp = {
          servers = {
            tailwindcss = {
              enable = true;
              extraOptions = {};
              filetypes = [
                "typescript"
                "html"
                "typescriptreact"
                "typescript.tsx"
              ];
              rootDir =
                /*
                lua
                */
                ''
                  require('lspconfig').util.root_pattern(".git")
                '';
            };
          };
        };
      };
    };
  };
}
