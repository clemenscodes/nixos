{pkgs, ...}: {
  programs = {
    nixvim = {
      extraConfigLuaPost =
        /*
        lua
        */
        ''
          require('neotest').setup {
            adapters = {
              require('rustaceanvim.neotest'),
              require('neotest-haskell'),
              require('neotest-jest')({
                jestCommand = "jest",
                jestConfigFile = "jest.config.ts",
                cwd = function(path)
                  return vim.fn.getcwd()
                end,
              }),
            }
          }
        '';
      extraPlugins = with pkgs.vimPlugins; [
        neotest
        neotest-haskell
        neotest-jest
      ];
      keymaps = [
        {
          action = ":Neotest run<CR>";
          key = "<leader>rr";
          mode = "n";
          options = {
            silent = true;
            desc = "Run nearest test";
          };
        }
        {
          action =
            /*
            lua
            */
            ''
              function() 
                require('neotest').run.run({strategy = "dap"})
              end'';
          lua = true;
          key = "<leader>rd";
          mode = "n";
          options = {
            silent = true;
            desc = "Run nearest test";
          };
        }
        {
          action = ":Neotest output-panel toggle<CR>";
          key = "<leader>to";
          mode = "n";
          options = {
            silent = true;
            desc = "Toggle test output panel";
          };
        }
        {
          action = ":Neotest summary toggle<CR>";
          key = "<leader>ts";
          mode = "n";
          options = {
            silent = true;
            desc = "Toggle test summary";
          };
        }
        {
          action = ":Neotest jump next<CR>";
          key = "<leader>rn";
          mode = "n";
          options = {
            silent = true;
            desc = "Jump to next test";
          };
        }
        {
          action = ":Neotest jump prev<CR>";
          key = "<leader>rp";
          mode = "n";
          options = {
            silent = true;
            desc = "Jump to previous test";
          };
        }
        {
          action = ":Neotest run file<CR>";
          key = "<leader>ra";
          mode = "n";
          options = {
            silent = true;
            desc = "Run all tests";
          };
        }
      ];
      plugins = {
        which-key = {
          registrations = {
            "<leader>r" = {
              name = "+Test";
              r = "Run nearest test";
              d = "Debug nearest test";
              n = "Jump to next test";
              p = "Jump to previous test";
              a = "Run all tests";
            };
            "<leader>ts" = "Toggle test summary";
            "<leader>to" = "Toggle test output panel";
          };
        };
      };
    };
  };
}
