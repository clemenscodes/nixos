{...}: {
  programs = {
    nixvim = {
      plugins = {
        dap = {
          enable = true;
          extensions = {
            dap-ui = {
              enable = true;
            };
            dap-virtual-text = {
              enable = true;
            };
          };
        };
        which-key = {
          registrations = {
            "<leader>d" = {
              name = "+Debug";
              b = "Toggle breakpoint";
              c = "Continue";
              t = "Toggle UI";
            };
          };
        };
      };
      keymaps = [
        {
          action = ":DapToggleBreakpoint<CR>";
          key = "<leader>db";
          mode = "n";
          options = {
            silent = true;
            desc = "Toggle breakpoint";
          };
        }
        {
          action = ":DapContinue<CR>";
          key = "<leader>dc";
          mode = "n";
          options = {
            silent = true;
            desc = "Continue";
          };
        }
        {
          action = ":lua require('dapui').toggle()<CR>";
          key = "<leader>dt";
          mode = "n";
          options = {
            silent = true;
            desc = "Toggle UI";
          };
        }
      ];
    };
  };
}
