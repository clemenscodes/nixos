{pkgs}:
with pkgs;
  writeShellScriptBin "clean" ''
    rm -rf $FLAKE/result "$@"
  ''
