{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}: let
  cfg = config.modules.explorer;
in
  with lib; {
    options = {
      modules = {
        explorer = {
          yazi = {
            enable = mkEnableOption "Enable yazi file browser" // {default = cfg.defaultExplorer == "yazi";};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.yazi.enable) {
      home = {
        packages = with pkgs; [
          file
          ffmpegthumbnailer
          unar
          poppler
          jq
          fd
          ripgrep
          fzf
          zoxide
          wl-clipboard
        ];
        file = {
          ".config/yazi/plugins/smart-enter.yazi/init.lua" = {
            text =
              /*
              lua
              */
              ''
                return {
                	entry = function()
                		local h = cx.active.current.hovered
                		ya.manager_emit(h and h.cha.is_dir and "enter" or "open", { hovered = true })
                	end,
                }
              '';
          };
          ".config/yazi/keymap.toml" = {
            text =
              /*
              toml
              */
              ''
                [[manager.prepend_keymap]]
                on   = [ "l" ]
                run  = "plugin --sync smart-enter"
                desc = "Enter the child directory, or open the file"
              '';
          };
        };
      };
      programs = {
        yazi = {
          enable = cfg.yazi.enable;
          catppuccin = mkIf (osConfig.modules.themes.catppuccin.enable) {
            inherit (osConfig.modules.themes.catppuccin) enable flavor;
          };
          settings = {
            manager = {
              show_hidden = true;
              show_symlink = false;
            };
            keymap = {
              "[manager.prepend_keymap]" = {
                on = ["l"];
                run = "plugin --sync smart-enter";
                desc = "Enter the child directory, or open the file";
              };
            };
          };
        };
      };
    };
  }
