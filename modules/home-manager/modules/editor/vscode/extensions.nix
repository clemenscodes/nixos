{
  inputs,
  system,
  ...
}: {
  programs = {
    vscode = {
      extensions = with inputs.nix-vscode-extensions.extensions.${system}.vscode-marketplace; [
        asvetliakov.vscode-neovim
        vspacecode.whichkey
        bbenoist.nix
        kamadorueda.alejandra
        mskelton.one-dark-theme
        pkief.material-icon-theme
        editorconfig.editorconfig
        mkhl.direnv
        prisma.prisma
        tamasfe.even-better-toml
        serayuzgur.crates
        rust-lang.rust-analyzer
        redhat.vscode-yaml
        moonrepo.moon-console
      ];
    };
  };
}
