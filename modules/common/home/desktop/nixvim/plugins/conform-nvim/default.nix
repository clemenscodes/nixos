{pkgs, ...}: {
  programs = {
    nixvim = {
      extraPackages = with pkgs; [
        prettierd
        stylua
        alejandra
      ];
      keymaps = [
        {
          action =
            /*
            lua
            */
            ''
              function()
                require("conform").format({ async = true, lsp_fallback = true })
              end
            '';
          lua = true;
          key = "<leader>i";
          mode = "n";
          options = {
            silent = true;
            desc = "Format";
          };
        }
      ];
      plugins = {
        conform-nvim = {
          enable = true;
          extraOptions = {
            format_on_save = {
              timeout_ms = 500;
              lsp_fallback = true;
            };
          };
          formattersByFt = {
            nix = ["alejandra"];
            lua = ["stylua "];
            rust = ["rustfmt"];
            javascript = [["prettierd" "prettier"]];
            typescript = [["prettierd" "prettier"]];
            javascriptreact = [["prettierd" "prettier"]];
            typescriptreact = [["prettierd" "prettier"]];
            css = [["prettierd" "prettier"]];
            html = [["prettierd" "prettier"]];
            json = [["prettierd" "prettier"]];
            yaml = [["prettierd" "prettier"]];
            graphql = [["prettierd" "prettier"]];
            markdown = [["prettierd" "prettier"]];
          };
        };
        which-key = {
          registrations = {
            "<leader>i" = "Format";
          };
        };
      };
    };
  };
}
