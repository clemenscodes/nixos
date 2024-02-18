{pkgs, ...}: {
  programs = {
    nixvim = {
      extraPackages = with pkgs; [eslint_d];
      keymaps = [
        {
          action =
            /*
            lua
            */
            ''
              function()
                lint.try_lint()
              end
            '';
          key = "<leader>l";
          mode = "n";
          options = {
            silent = true;
            desc = "Trigger linting for current file";
          };
        }
      ];
      plugins = {
        lint = {
          enable = true;
          extraOptions = {};
          lintersByFt = {
            javascript = ["eslint_d"];
            typescript = ["eslint_d"];
            javascriptreact = ["eslint_d"];
            typescriptreact = ["eslint_d"];
          };
        };
        which-key = {
          registrations = {
            "<leader>l" = "Trigger linting for currentl file";
          };
        };
      };
    };
  };
}
