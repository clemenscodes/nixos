{
  pkgs,
  username,
  machine,
}:
with pkgs;
  writeShellScriptBin "buildprofile" ''
    sudo nb \
      --profile /nix/var/nix/profiles/system \
      $FLAKE/#nixosConfigurations.${username}.${machine}.config.system.build.toplevel \
      -o $FLAKE/result \
      --show-trace \
      --no-eval-cache \
      --accept-flake-config "$@"
  ''
