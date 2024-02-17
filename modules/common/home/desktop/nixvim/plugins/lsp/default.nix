{...}: {
  imports = [ ./servers ];
  programs = {
    nixvim = {
      plugins = {
        lsp = {
          enable = true;
          keymaps = {
            diagnostic = {
              "<leader>j" = "goto_next";
              "<leader>k" = "goto_prev";
            };
            lspBuf = {
              K = "hover";
              gD = "references";
              gd = "definition";
              gi = "implementation";
              gt = "type_definition";
            };
            silent = true;
          };
        };
      };
    };
  };
}
