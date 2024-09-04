{
  pkgs,
  username,
  machine,
}:
with pkgs;
  writeShellScriptBin "build" ''
    nb $FLAKE/#nixosConfigurations.${username}.${machine}.config.system.build.toplevel -o $FLAKE/result "$@"
  ''
