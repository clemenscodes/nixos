{pkgs, ...}: {
  programs = {
    nixvim = {
      extraPlugins = with pkgs; [
        vimPlugins.nui-nvim
        vimPlugins.searchbox-nvim
      ];
      extraConfigLuaPost =
        /*
        lua
        */
        ''
          require('searchbox').setup({
            defaults = {
              reverse = false,
              exact = false,
              prompt = ' ',
              modifier = 'disabled',
              confirm = 'off',
              clear_matches = true,
              show_matches = false,
            },
            popup = {
              relative = 'win',
              position = {
                row = '5%',
                col = '95%',
              },
              size = 30,
              border = {
                style = 'rounded',
                text = {
                  top = ' Search ',
                  top_align = 'left',
                },
              },
              win_options = {
                winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
              },
            },
            hooks = {
              before_mount = function(input)
                -- code
              end,
              after_mount = function(input)
                -- code
              end,
              on_done = function(value, search_type)
                -- code
              end
            }
          })
        '';
      keymaps = [
        {
          action = ":SearchBoxIncSearch<CR>";
          key = "/";
          mode = "n";
          options = {
            silent = true;
            desc = "Search incrementally";
          };
        }
        {
          action = ":SearchBoxIncSearch visual_mode=true<CR>";
          key = "/";
          mode = "v";
          options = {
            silent = true;
            desc = "Search incrementally";
          };
        }
        {
          action = ":SearchBoxReplace<CR>";
          key = "<leader>s";
          mode = "n";
          options = {
            silent = true;
            desc = "Search and replace";
          };
        }
        {
          action = ":SearchBoxIncSearch visual_mode=true<CR>";
          key = "<leader>s";
          mode = "v";
          options = {
            silent = true;
            desc = "Search and replace";
          };
        }
      ];
      plugins = {
        which-key = {
          registrations = {
            "/" = "Search incrementally";
            "<leader>s" = "Search and replace";
          };
        };
      };
    };
  };
}
