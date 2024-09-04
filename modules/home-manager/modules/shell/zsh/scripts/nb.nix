{
  pkgs,
  config,
}: let
  text =
    if config.modules.shell.nom.enable
    then "nom build"
    else "nix build";
in
  with pkgs;
    writeShellScriptBin "nb" ''
      ${text} "$@"
    ''
