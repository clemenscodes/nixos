{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.shell.multiplexers;
in
  with lib; {
    options = {
      modules = {
        shell = {
          multiplexers = {
            tmux = {
              enable = mkEnableOption "Enable tmux" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.tmux.enable) {
      programs = {
        tmux = {
          enable = cfg.tmux.enable;
          clock24 = true;
          baseIndex = 1;
          keyMode = "vi";
          shortcut = "Space";
          customPaneNavigationAndResize = true;
          disableConfirmationPrompt = true;
          mouse = true;
          shell = "${pkgs.zsh}/bin/zsh";
          sensibleOnTop = true;
          escapeTime = 0;
          terminal = "xterm-kitty";
          plugins = with pkgs; [
            tmuxPlugins.vim-tmux-navigator
            tmuxPlugins.catppuccin
            tmuxPlugins.yank
          ];
          extraConfig = ''
            set -as terminal-features ",xterm-kitty:RGB"
            bind '"' split-window -v -c "#{pane_current_path}"
            bind % split-window -h -c "#{pane_current_path}"
          '';
        };
      };
    };
  }
