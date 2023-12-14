{
  inputs,
  system,
  ...
}: {
  programs = {
    vscode = {
      extensions = with inputs.nix-vscode-extensions.extensions.${system}.vscode-marketplace; [
        vspacecode.whichkey
        kamadorueda.alejandra
        esbenp.prettier-vscode
        dbaeumer.vscode-eslint
        mskelton.one-dark-theme
        pkief.material-icon-theme
        editorconfig.editorconfig
        asvetliakov.vscode-neovim
        ms-azuretools.vscode-docker
        firsttris.vscode-jest-runner
        ms-vscode.vscode-typescript-next
        ecmel.vscode-html-css
        vue.volar
        arrterian.nix-env-selector
        jnoortheen.nix-ide
        mkhl.direnv
        prisma.prisma
        antfu.vite
      ];
    };
  };
}
