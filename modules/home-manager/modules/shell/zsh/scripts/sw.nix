{pkgs}:
with pkgs;
  writeShellScriptBin "sw" ''
    buildprofile && nixdiff && switch && clean "$@"
  ''
