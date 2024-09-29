{
  config,
  lib,
  inputs,
  system,
  ...
}: {
  programs = {
    vscode = {
      extensions = with inputs.nix-vscode-extensions.extensions.${system}.vscode-marketplace;
        [
          asvetliakov.vscode-neovim
          vspacecode.whichkey
          bbenoist.nix
          kamadorueda.alejandra
          pkief.material-icon-theme
          editorconfig.editorconfig
          mkhl.direnv
          tamasfe.even-better-toml
          serayuzgur.crates
          rust-lang.rust-analyzer
          redhat.vscode-yaml
          moonrepo.moon-console
          catppuccin.catppuccin-vsc
          ms-azuretools.vscode-docker
          exiasr.hadolint
        ]
        ++ lib.optional config.modules.editor.vscode.proprietary ms-vscode-remote.remote-containers;
    };
  };
}
