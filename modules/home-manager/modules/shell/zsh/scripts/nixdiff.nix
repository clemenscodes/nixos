{pkgs}:
with pkgs;
  writeShellScriptBin "nixdiff" ''
    ${nvd}/bin/nvd diff /run/current-system $FLAKE/result "$@"
  ''
