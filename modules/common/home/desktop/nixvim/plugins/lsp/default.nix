{...}: {
  imports = [./servers];
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
              gD = "declaration";
              gr = "references";
              gd = "definition";
              gi = "implementation";
              gt = "type_definition";
            };
            silent = true;
          };
        };
        which-key = {
          registrations = {
            c = {
              name = "+LSP";
              a = "Select code action";
            };
          };
        };
      };
      keymaps = [
        {
          action =
            /*
            lua
            */
            ''
              function()
                  vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
              end
            '';
          lua = true;
          key = "<leader>n";
          mode = "n";
          options = {
            silent = true;
            desc = "Toggle inlay hints";
          };
        }
        {
          action =
            /*
            lua
            */
            ''
              function()
                vim.lsp.buf.code_action()
              end
            '';
          lua = true;
          key = "ca";
          mode = "n";
          options = {
            silent = true;
            desc = "Select code action";
          };
        }
      ];
    };
  };
}
