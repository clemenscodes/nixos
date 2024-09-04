{pkgs}:
with pkgs;
  writeShellScriptBin "swupdate" ''
    update && sw "$@"
  ''
