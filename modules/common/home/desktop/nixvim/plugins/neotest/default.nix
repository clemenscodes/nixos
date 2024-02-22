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
              require('rustaceanvim.neotest')
            },
          }
        '';
      extraPlugins = with pkgs; [
        vimPlugins.neotest
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
              n = "Jump to next test";
              p = "Jump to previous test";
              a = "Run all tests";
            };
            "<leader>ts" = "Toggle test summary";
          };
        };
      };
    };
  };
}
