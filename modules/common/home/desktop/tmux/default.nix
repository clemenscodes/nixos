{pkgs, ...}: {
  programs = {
    tmux = {
      enable = true;
      clock24 = true;
      keyMode = "vi";
      customPaneNavigationAndResize = true;
      disableConfirmationPrompt = true;
      mouse = true;
      shell = "${pkgs.zsh}/bin/zsh";
      sensibleOnTop = true;
      escapeTime = 0;
      terminal = "xterm-kitty";
      extraConfig = ''
        set -as terminal-features ",xterm-kitty:RGB"
      '';
    };
  };
}
