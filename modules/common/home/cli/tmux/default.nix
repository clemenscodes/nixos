{pkgs, ...}: {
  programs = {
    tmux = {
      enable = true;
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
}
