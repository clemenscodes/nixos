{...}: {
  programs = {
    nixvim = {
      extraConfigLuaPost =
        /*
        lua
        */
        ''
          vim.api.nvim_set_hl(0, "red", { fg = "#DD2E44" })
          vim.api.nvim_set_hl(0, "blue", { fg = "#3d59a1" })
          vim.api.nvim_set_hl(0, "green", { fg = "#9ece6a" })
          vim.api.nvim_set_hl(0, "yellow", { fg = "#FFFF00" })
          vim.api.nvim_set_hl(0, "orange", { fg = "#f09000" })
          vim.fn.sign_define('DapBreakpoint', { text='•', texthl='red', numhl='DapBreakpoint' })
          vim.fn.sign_define('DapBreakpointCondition', { text='•', texthl='blue', numhl='DapBreakpoint' })
          vim.fn.sign_define('DapBreakpointRejected', { text='•', texthl='orange', numhl='DapBreakpoint' })
          vim.fn.sign_define('DapStopped', { text='•', texthl='green', numhl='DapBreakpoint' })
          vim.fn.sign_define('DapLogPoint', { text='•', texthl='yellow', numhl='DapBreakpoint' })
        '';
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
