{pkgs}:
with pkgs;
  writeShellScriptBin "tracewarning" ''
    NIX_ABORT_ON_WARN=true build --option pure-eval false --show-trace "$@"
  ''
