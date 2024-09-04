{pkgs}:
with pkgs;
  writeShellScriptBin "switch" ''
    sudo $FLAKE/result/bin/switch-to-configuration switch "$@"
  ''
