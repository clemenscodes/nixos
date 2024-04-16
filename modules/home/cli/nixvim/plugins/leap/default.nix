{pkgs, ...}: {
  programs = {
    nixvim = {
      extraConfigLuaPost =
        /*
        lua
        */
        ''
          vim.keymap.del({'x', 'o'}, 'x')
          vim.keymap.del({'x', 'o'}, 'X')
        '';
      extraPlugins = with pkgs; [
        vimPlugins.vim-repeat
      ];
      keymaps = [
        {
          action =
            /*
            lua
            */
            ''
              function ()
                local focusable_windows = vim.tbl_filter(
                  function (win) return vim.api.nvim_win_get_config(win).focusable end,
                  vim.api.nvim_tabpage_list_wins(0)
                )
                require('leap').leap { target_windows = focusable_windows }
              end
            '';
          key = "s";
          mode = "n";
          lua = true;
        }
      ];
      autoCmd = [
        {
          event = ["User"];
          pattern = ["LeapEnter"];
          callback.__raw =
            /*
            lua
            */
            ''
              function()
                vim.cmd.hi('Cursor', 'blend=100')
                vim.opt.guicursor:append { 'a:Cursor/lCursor' }
              end
            '';
        }
        {
          event = ["User"];
          pattern = ["LeapLeave"];
          callback.__raw =
            /*
            lua
            */
            ''
              function()
                vim.cmd.hi('Cursor', 'blend=0')
                vim.opt.guicursor:append { 'a:Cursor/lCursor' }
              end
            '';
        }
      ];
      plugins = {
        leap = {
          enable = true;
        };
      };
    };
  };
}
