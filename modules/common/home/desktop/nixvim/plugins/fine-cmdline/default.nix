{pkgs, ...}: let
  fine-cmdline = pkgs.vimUtils.buildVimPlugin {
    name = "fine-cmdline";
    src = pkgs.fetchFromGitHub {
      owner = "VonHeikemen";
      repo = "fine-cmdline.nvim";
      rev = "dd676584145d62b30d7e8dbdd011796a8f0a065f";
      hash = "sha256-w9wwjClkOWk3wCgEiZIFLZRJ/gAfX38x2LnVRaelKD8=";
    };
  };
in {
  programs = {
    nixvim = {
      opts = {
        cmdheight = 0;
      };
      extraPlugins = with pkgs; [
        vimPlugins.nui-nvim
        fine-cmdline
      ];
      extraConfigLuaPost =
        /*
        lua
        */
        ''
          require('fine-cmdline').setup({
            cmdline = {
              enable_keymaps = true,
              smart_history = true,
              prompt = ':'
            },
            popup = {
              position = {
                row = '50%',
                col = '50%',
              },
              size = {
                width = '60%',
              },
              border = {
                style = 'rounded',
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
              set_keymaps = function(imap, feedkeys)
                -- code
              end
            }
          })
        '';
      keymaps = [
        {
          action =
            /*
            lua
            */
            ''
              function()
                require("fine-cmdline").open({default_value = ""})
              end
            '';
          lua = true;
          key = ":";
          mode = "n";
          options = {
            silent = true;
            desc = "Open FineCmdLine";
          };
        }
      ];
    };
  };
}
