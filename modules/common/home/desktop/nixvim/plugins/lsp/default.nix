{...}: {
  imports = [ ./servers ];
  programs = {
    nixvim = {
      keymaps = [
        {
          action = "function() vim.lsp.buf.code_action({apply = true}) end";
          lua = true;
          key = "ca";
          mode = "n";
          options = {
            silent = true;
            desc = "Select code action";
          };
        }
      ];
      plugins = {
        which-key = {
          registrations = {
            c = {
              name = "+LSP";
              a = "Select code action";
            };
          };
        };
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
