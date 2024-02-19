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
          formattersByFt = {
            nix = ["alejandra"];
            rust = ["rustfmt"];
            javascript = ["prettierd"];
            typescript = ["prettierd"];
            javascriptreact = ["prettierd"];
            typescriptreact = ["prettierd"];
            css = ["prettierd"];
            html = ["prettierd"];
            json = ["prettierd"];
            yaml = ["prettierd"];
            graphql = ["prettierd"];
            markdown = ["prettierd"];
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
