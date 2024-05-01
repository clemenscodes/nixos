{pkgs, ...}: 
let
  codevim = pkgs.writeShellScriptBin "codevim" ''
    nix run 'github:neovim/neovim?dir=contrib' -- "$@"
  '';
in
{
  imports = [
    ./keybindings.nix
    ./settings.nix
    ./extensions.nix
    ./launcher.nix
  ];
  home = {
    packages = [codevim];
  };
  programs = {
    vscode = {
      enable = true;
      package = pkgs.vscodium;
      enableExtensionUpdateCheck = true;
      enableUpdateCheck = true;
    };
  };
}
