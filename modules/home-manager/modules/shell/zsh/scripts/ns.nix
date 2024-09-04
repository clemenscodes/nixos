{
  pkgs,
  config,
}: let
  text =
    if config.modules.shell.nom.enable
    then "nom shell"
    else "nix shell";
in
  with pkgs;
    writeShellScriptBin "ns" ''
      ${text} "$@"
    ''
