{...}: {
  programs = {
    vscode = {
      userSettings = {
        "editor.fontSize" = 16;
        "editor.fontFamily" = "Iosevka Nerd Font Mono";
        "window.titleBarStyle" = "custom";
        "extensions.experimental.affinity" = {
          "asvetliakov.vscode-neovim" = 1;
        };
        "keyboard.dispatch" = "keyCode";
        "security.workspace.trust.enabled" = false;
        "security.workspace.trust.startupPrompt" = "never";
        "security.workspace.trust.banner" = "never";
        "security.workspace.trust.emptyWindow" = false;
        "workbench.colorTheme" = "One Dark";
        "workbench.iconTheme" = "material-icon-theme";
        "files.autoSave" = "afterDelay";
        "files.autoSaveDelay" = 1000;
        "[nix]" = {
          "editor.defaultFormatter" = "kamadorueda.alejandra";
          "editor.formatOnPaste" = true;
          "editor.formatOnSave" = true;
          "editor.formatOnType" = false;
        };
        "alejandra.program" = "alejandra";
        "nxConsole.showNodeVersionOnStartup" = false;
      };
    };
  };
}
