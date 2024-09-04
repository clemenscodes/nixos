{
  pkgs,
  config,
}: let
  text =
    if config.modules.shell.nom.enable
    then "nom develop -c $SHELL"
    else "nix develop -c $SHELL";
in
  with pkgs;
    writeShellScriptBin "nd" ''
      ${text} "$@"
    ''
