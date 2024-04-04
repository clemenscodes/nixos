{pkgs, ...}: let
  nio = pkgs.vimUtils.buildVimPlugin {
    name = "nio";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-neotest";
      repo = "nvim-nio";
      rev = "173f285eebb410199273fa178aa517fd2d7edd80";
      hash = "sha256-bjYtZygrL05qB2dM7Q8lJor81VYO+u8/JWQqfZ19Wzk=";
    };
  };
in
{
  programs = {
    nixvim = {
      extraPlugins = [nio];
      extraConfigLuaPost =
        /*
        lua
        */
        ''
          local dap, dapui = require("dap"), require("dapui")
          dap.listeners.before.attach.dapui_config = function()
            dapui.open()
          end
          dap.listeners.before.launch.dapui_config = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
          end
          dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
          end
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
          adapters = {
            servers = {
              codelldb = let
                port = 13000;
              in {
                inherit port;
                host = "127.0.0.1";
                executable = {
                  command = "${pkgs.vscode-extensions.vadimcn.vscode-lldb.adapter}/bin/codelldb";
                  args = ["--port" "${builtins.toString port}"];
                };
              };
            };
          };
          configurations = {
            rust = [];
          };
          extensions = {
            dap-ui = {
              enable = true;
              controls = {
                element = "console";
              };
              layouts = [
                {
                  elements = [
                    {
                      id = "scopes";
                      size = 1;
                    }
                  ];
                  position = "right";
                  size = 100;
                }
                {
                  elements = [
                    {
                      id = "repl";
                      size = 0.50;
                    }
                    {
                      id = "console";
                      size = 0.50;
                    }
                  ];
                  position = "bottom";
                  size = 15;
                }
              ];
            };
            dap-virtual-text = {
              enable = true;
            };
          };
        };
        which-key = {
          registrations = {
            "<leader>td" = "Toggle dapui";
            "<leader>d" = {
              name = "+Debug";
              b = "Toggle breakpoint";
              c = "Continue";
              k = "Kill debugging session";
            };
            "<leader>ds" = {
              name = "+Steps";
              i = "Step into function call";
              u = "Step out of function call";
              o = "Step over function call";
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
          action = ":lua require('dapui').open({reset = true})<CR>";
          key = "<leader>dr";
          mode = "n";
          options = {
            silent = true;
            desc = "Reset UI";
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
          action = ":DapTerminate<CR>";
          key = "<leader>dk";
          mode = "n";
          options = {
            silent = true;
            desc = "Kill debugging session";
          };
        }
        {
          action = ":DapStepInto<CR>";
          key = "<leader>dsi";
          mode = "n";
          options = {
            silent = true;
            desc = "Step into function call";
          };
        }
        {
          action = ":DapStepOut<CR>";
          key = "<leader>dsu";
          mode = "n";
          options = {
            silent = true;
            desc = "Step out of function call";
          };
        }
        {
          action = ":DapStepOver<CR>";
          key = "<leader>dso";
          mode = "n";
          options = {
            silent = true;
            desc = "Step over function call";
          };
        }
        {
          action = ":lua require('dapui').toggle()<CR>";
          key = "<leader>td";
          mode = "n";
          options = {
            silent = true;
            desc = "Toggle dapui";
          };
        }
      ];
    };
  };
}
