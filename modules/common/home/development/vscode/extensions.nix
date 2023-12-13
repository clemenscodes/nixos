{pkgs,...}: {
  programs = {
    vscode = {
      extensions = with pkgs.vscode-extensions; [
        vspacecode.whichkey
        kamadorueda.alejandra
        esbenp.prettier-vscode
        dbaeumer.vscode-eslint
        mskelton.one-dark-theme
        pkief.material-icon-theme
        editorconfig.editorconfig
        asvetliakov.vscode-neovim
        ms-azuretools.vscode-docker
      ];
    };
  };
}

